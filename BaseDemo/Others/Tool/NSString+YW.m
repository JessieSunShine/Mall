//
//  NSString+YW.m
//
//
//  Created by liye on 14-6-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+YW.h"
#import <AddressBook/AddressBook.h>
@implementation NSString (YW)

- (CGSize)textSizeWith:(CGSize)wordSize andFont:(UIFont *)font
{
    NSDictionary *dict = @{NSFontAttributeName : font};
    // 获取文字的宽高
    CGSize size = [self boundingRectWithSize:wordSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size;
}


#pragma mark - 读取通讯录
- (NSString*)readAddressBook {
    NSString *jsonString = nil;
    ABAddressBookRef addressBooks = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    // 记录拼接信息
    NSMutableString *tempStr = [NSMutableString string];
    
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSString *telphoneStr = nil;
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                if (j == 0) {
                    telphoneStr = (__bridge NSString*)value;
                    telphoneStr = [telphoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        
        [tempStr appendFormat:@",'%@'",telphoneStr];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    if (tempStr.length > 0)
        jsonString = [NSString stringWithFormat:@"[%@]", [tempStr substringFromIndex:1]];
    return jsonString;
}

@end

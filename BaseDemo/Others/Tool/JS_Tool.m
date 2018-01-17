//
//  JS_Tool.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "JS_Tool.h"
#import "sys/utsname.h"

#define iPhone4     @"iPhone4"
#define iPhone4s    @"iPhone4S"
#define iPhone5     @"iPhone5"
#define iPhone5s    @"iPhone5s"
#define iPhone6     @"iPhone6"
#define iPhone6p    @"iPhone6Plus"
#define iPhone7     @"iPhone7"
#define iPhone7p    @"iPhone7Plus"
#define iPhone8    @"iPhone8"
#define iPhone8p    @"iPhone8Plus"
#define iPhoneX    @"iPhoneX"

@implementation JS_Tool
+ (AppDelegate *)xfuncGetAppdelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


+ (UIFont *)PXFontConversionIOS:(CGFloat)pxFount
{
//    if ([[JS_Tool deviceString] isEqualToString:iPhone6p]) {
//        pxFount = pxFount / 2.0 * 1.2;
//    }
//    else if ([[JS_Tool deviceString] isEqualToString:iPhone6])
//    {
//        pxFount = pxFount / 2.0 * 1.1;
//    }
//    else
//    {
//        pxFount = pxFount / 2.0;
//    }
    
    CGFloat sizeScale=SCREEN_HEIGHT>568?ScreenHeightRatio+0.1:1;
    pxFount = pxFount / 2.0 * sizeScale;
    
    UIFont *font =[UIFont systemFontOfSize:pxFount];
    
    
    return font;
}

+ (NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"])    return @"iPhoneX";
    if ([deviceString isEqualToString:@"iPhone10,6"])    return @"iPhoneX";

    
    
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon_iPhone_4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod_Touch_1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod_Touch_2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod_Touch_3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod_Touch_4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad_2(WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad_2(GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad_2(CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}


+ (float)getCacheSize
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    filePath = [filePath stringByAppendingPathComponent:@"Caches"];
    if (![manager fileExistsAtPath:filePath])
        return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:filePath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
        folderSize += [JS_Tool fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize / (1024.0*1024.0);
}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
+ (BOOL)clearCache
{
    NSFileManager* manager = [NSFileManager defaultManager];
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    filePath = [filePath stringByAppendingPathComponent:@"Caches"];
    
    NSError *error = nil;
    NSArray *files = [manager contentsOfDirectoryAtPath:filePath error:&error];
    if (error) {
        NSLog(@"%@",error);
        return NO;
    }
    for (id obj in files) {
        BOOL isDir = NO;
        if ([manager fileExistsAtPath:[filePath stringByAppendingPathComponent:obj] isDirectory:&isDir])
        {
            if (isDir) {
                [manager removeItemAtPath:[filePath stringByAppendingPathComponent:obj] error:&error];
            }
        }
    }
    return YES;
}
//
//+ (void)showProgressHUD:(UIView *)view
//{
//    if (!mbHud) {
//        mbHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    }
//}
//+ (void)disMissProgressHud
//{
//    [mbHud hide:YES];
//    mbHud = nil;
//}

+ (NSString *)intervalFromStartDate:(NSString *)startDate toTheDate:(NSString *)endDate {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *sd = [dateFomatter dateFromString:startDate];
    NSDate *ed = [dateFomatter dateFromString:endDate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCom = [calendar components:unit fromDate:sd toDate:ed options:0];
    NSString *differentStr = @"";
    if (dateCom.year != 0) {
        differentStr = [differentStr stringByAppendingString:[NSString stringWithFormat:@"%ld年", (long)dateCom.year]];
    }
    if (dateCom.month != 0) {
        differentStr = [differentStr stringByAppendingString:[NSString stringWithFormat:@"%ld月", (long)dateCom.month]];
    }
    if (dateCom.day != 0) {
        differentStr = [differentStr stringByAppendingString:[NSString stringWithFormat:@"%ld天", (long)dateCom.day]];
    }
    if (dateCom.hour != 0) {
        differentStr = [differentStr stringByAppendingString:[NSString stringWithFormat:@"%ld小时", (long)dateCom.hour]];
    }
    
    if (dateCom.second!=0) {
        
        dateCom.minute=dateCom.minute+1;
    }
    
    if (dateCom.minute != 0) {
        differentStr = [differentStr stringByAppendingString:[NSString stringWithFormat:@"%ld分钟", (long)dateCom.minute%10!=0?((long)dateCom.minute/10+1)*10:(long)dateCom.minute]];
    }
    return differentStr;
}

@end

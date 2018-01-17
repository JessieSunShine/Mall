//
//  NSString+LY.h
//  微博小展
//
//  Created by liye on 14-6-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (YW)

//获取文字size
- (CGSize)textSizeWith:(CGSize)wordSize andFont:(UIFont *)font;

//获取通讯录
- (NSString *)readAddressBook;
@end

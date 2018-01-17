//
//  JS_Tool.h
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface JS_Tool : NSObject

+ (AppDelegate *)xfuncGetAppdelegate;
//字体转换
+ (UIFont *)PXFontConversionIOS:(CGFloat)pxFount;

+ (NSString*)deviceString;

//cache文件大小 返回m
+ (float)getCacheSize;
//缓存清理
+ (BOOL)clearCache;
//提示框
+ (void)showProgressHUD:(UIView *)view;

+ (void)disMissProgressHud;
/**
 比对两个日期 获取时间差
 */
+ (NSString *)intervalFromStartDate:(NSString *)startDate toTheDate:(NSString *)endDate;

@end

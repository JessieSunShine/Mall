//
//  UIButton+Category.h
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/**
 *  将UIButton的属性进行统一的处理，减少代码的重复编写
 *  已处理属性：布局位置、标题、标题颜色 、字号、背景颜色、图片、点击高亮图片
 *  待进行统一处理的属性：圆角的设置、点击事件
 */


-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(CGFloat)font BackgroundColor:(UIColor*)color NormalImage:(NSString*)normalImage SelectImage:(NSString*)selectImage;

@end

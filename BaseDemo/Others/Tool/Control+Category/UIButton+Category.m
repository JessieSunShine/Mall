//
//  UIButton+Category.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "UIButton+Category.h"

@implementation UIButton (Category)

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title TitleColor:(UIColor *)titleColor Font:(CGFloat)font BackgroundColor:(UIColor *)color NormalImage:(NSString *)normalImage SelectImage:(NSString *)selectImage{
    
    if (self=[super initWithFrame:frame]) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
        self.titleLabel.font=[JS_Tool PXFontConversionIOS:font];
        self.backgroundColor=color;
        
        
    }
    
    return self;
    
}
@end

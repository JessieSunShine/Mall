//
//  UILabel+Category.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)
-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment  backgroundColor:(UIColor *)backgroundColor{
    
    if (self=[super initWithFrame:frame]) {
        
        self.text=text;
        self.textColor=textColor;
        self.font=[JS_Tool PXFontConversionIOS:font];
        self.textAlignment=textAlignment;
        self.backgroundColor=backgroundColor;
        
    }
    
    
    return self;
}
@end

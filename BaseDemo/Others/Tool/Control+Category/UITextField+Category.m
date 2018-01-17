//
//  UITextField+Category.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)


-(instancetype)initWithFrame:(CGRect)frame  font:(float)font  keyboardType:(UIKeyboardType)keyboardType placeholder:(NSString *)placeholder{
    
    if (self=[super initWithFrame:frame]) {
        
        self.font=JS_FONT(font);
        self.placeholder=placeholder;
        self.keyboardType=keyboardType;

    }
    
    return self;
    
}

@end

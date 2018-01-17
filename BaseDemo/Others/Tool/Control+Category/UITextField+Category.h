//
//  UITextField+Category.h
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

//self.nameTextField = [[KZWBaseTextField alloc] initWithFrame:CGRectMake(113, 30, SCREEN_WIDTH - 113, 52) font:FontSize30 keyboardType:UIKeyboardTypeDefault placeholder:@"请填写真实姓名" KZWTextFieldType:KZWTextFieldDefault];

-(instancetype)initWithFrame:(CGRect)frame  font:(float)font   keyboardType:(UIKeyboardType)keyboardType placeholder:(NSString*)placeholder;

@end

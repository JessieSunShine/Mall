//
//  UILabel+Category.h
//  BaseDemo
//
//  Created by zizilink on 2017/12/21.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

/**
  1.text;
  2.font;
  3.textColor;
  4.NSTextAlignment    textAlignment;
  5.NSLineBreakMode    lineBreakMode;

 待处理
  5.shadowColor;
  6.CGSize   shadowOffset;    // default is CGSizeMake(0, -1) -- a top shadow
 *
 */


-(instancetype)initWithFrame:(CGRect)frame  text:(NSString*)text textColor:(UIColor*)textColor font:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor*)backgroundColor;
@end

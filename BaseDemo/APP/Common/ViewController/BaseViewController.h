//
//  BaseViewController.h
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


@property (nonatomic, strong) UIView *navgationBarBottomLine;
@property (nonatomic, copy)NSString*page;
@property (nonatomic, copy)NSString*pageNum;


- (void)back;

- (void)leftItemPressed;
- (void)rightItemPressed;

- (void)setLeftItem:(id)itemShowStyle;

- (void)setRightItem:(id)itemShowStyle;


@end

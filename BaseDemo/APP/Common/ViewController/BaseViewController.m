//
//  BaseViewController.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UIBarButtonItem *leftItem;//左侧按钮
    UIBarButtonItem *rightItem;//右侧按钮
}

@property (nonatomic, strong) UIBarButtonItem *backItem;//返回按钮

@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.backBarButtonItem=nil;
    [self.navigationItem.backBarButtonItem setTitle:@""];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setExtendedLayoutIncludesOpaqueBars:NO];
    self.navigationItem.hidesBackButton = YES;
    [self setBackBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabbar) name:NotificationTabBarShow object:nil];
    
    self.view.backgroundColor=BACK_GROUND_COLOR;
    
//    数据请求分页设置
    self.page=@"1";
    self.pageNum=@"10";
    
}

-(void)showTabbar
{
    if (!leftItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

//设置返回按钮
-(void)setBackBtn{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 35, 35);
    [backBtn setImage:[UIImage imageNamed:@"jianTou_left"] forState:UIControlStateNormal];
//    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, IS_IOS7 ? -5 :0, 0, 0);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = self.backItem;
    self.navigationItem.backBarButtonItem=nil;
}

//返回事件
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//定义左侧导航栏按钮
- (void)setLeftItem:(id)itemShowStyle
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 70, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self action:@selector(leftItemPressed) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font=[JS_Tool PXFontConversionIOS:28];
    
    if ([itemShowStyle isKindOfClass:[NSString class]]) {
        [leftBtn setTitle:itemShowStyle forState:UIControlStateNormal];
    }else if([itemShowStyle isKindOfClass:[UIImage class]]){
        [leftBtn setImage:itemShowStyle forState:UIControlStateNormal];
    }else{
        
    }
    
    leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.backBarButtonItem=nil;
}

//左侧导航栏按钮响应时间
- (void)leftItemPressed
{
    
}


//定义右侧导航栏按钮
- (void)setRightItem:(id)itemShowStyle
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [rightBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0,20, 70, 44);
    
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(rightItemPressed) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn.titleLabel.font=[JS_Tool PXFontConversionIOS:28];
    
    if ([itemShowStyle isKindOfClass:[NSString class]]) {
        [rightBtn setTitle:itemShowStyle forState:UIControlStateNormal];
    }else if([itemShowStyle isKindOfClass:[UIImage class]]){
        [rightBtn setImage:itemShowStyle forState:UIControlStateNormal];
    }else{
        
    }
    
    rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

//右侧导航栏响应事件
- (void)rightItemPressed
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

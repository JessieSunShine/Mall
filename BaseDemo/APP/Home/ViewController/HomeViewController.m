//
//  HomeViewController.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "HomeViewController.h"
#import "TopListScrollView.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"首页";
    
    [self setLeftItem:@"返回"];
    
    [self setupCreatTopView];

    UIImageView*frogImageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    frogImageView.backgroundColor=[UIColor redColor];
    [self.view addSubview:frogImageView];
    
//    力学动画生成器
    UIDynamicAnimator*animatic=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    UIGravityBehavior*gravity=[[UIGravityBehavior alloc]initWithItems:@[frogImageView]];
    [gravity setAngle:0.0 magnitude:0.1];
    [animatic addBehavior:gravity];
    
    UISearchBar*search=[[UISearchBar alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
    search.placeholder=@"搜索";
    [self.view addSubview:search];
    

}


-(void)setupCreatTopView{
    
    TopListScrollView*topView=[[TopListScrollView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 50)];
    [self.view addSubview:topView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  BaseTabBarViewController.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/22.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"

#define TabBarVC              @"vc"                //--tabbar对应的视图控制器
#define TabBarTitle           @"title"             //--tabbar标题
#define TabBarImage           @"image"             //--未选中时tabbar的图片
#define TabBarSelectedImage   @"selectedImage"     //--选中时tabbar的图片
#define TabBarItemBadgeValue  @"badgeValue"        //--未读个数
#define TabBarCount 5                              //--tabbarItem的个数

typedef NS_ENUM(NSInteger,TMTabType) {
    
    // --这里的顺序，决定了 tabbar 从左到右item的显示顺序
    TMTabTypeHome,         //首页
    TMTabTypeList,        //分类
    TMTabTypeSend,        //快送
    TMTabTypeShoppingC,            //购物车
    TMTabTypeMine,           //个人中心
};


@interface BaseTabBarViewController ()
@property (nonatomic, strong)  NSDictionary *configs;

@end

@implementation BaseTabBarViewController

+(instancetype)instance{
    
    AppDelegate*delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UIViewController*VC=delegate.window.rootViewController;
    
    if ([VC isKindOfClass:[BaseTabBarViewController class]]) {
        
        return (BaseTabBarViewController*)VC;
        
    }else{
        
        
        return nil;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpSubNav];
}

- (NSArray*)tabbars{
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}

- (void)setUpSubNav {
    
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabBarVC];
        NSString *title  = item[TabBarTitle];
        NSString *imageName = item[TabBarImage];
        NSString *imageSelected = item[TabBarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        BaseNavigationController*nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[UIImage imageNamed:imageName]
                                               selectedImage:[[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[TabBarItemBadgeValue] integerValue];
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        
        [[UITabBar appearance] setTintColor:[UIColor redColor]]; // 设置TabBar上 字体颜色
        
        [vcArray addObject:nav];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
    
}

#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(TMTabType)type{
    
    if (_configs == nil)
    {
        _configs = @{
                     @(TMTabTypeHome) : @{
                             TabBarVC           : @"HomeViewController",
                             TabBarTitle        : @"首页",
                             TabBarImage        : @"tabBar_Home.jpg",
                             TabBarSelectedImage: @"",
                             TabBarItemBadgeValue: @(0)
                             },
                     @(TMTabTypeList)     : @{
                             TabBarVC           : @"DiscoverViewController",
                             TabBarTitle        : @"分类",
                             TabBarImage        : @"tabBar_bill.jpg",
                             TabBarSelectedImage: @"",
                             TabBarItemBadgeValue: @(0)
                             
                             },
                     @(TMTabTypeSend): @{
                             TabBarVC           : @"ContactsViewController",
                             TabBarTitle        : @"快送",
                             TabBarImage        : @"tabBar_message.jpg",
                             TabBarSelectedImage: @"",
                             TabBarItemBadgeValue: @(0)
                             
                             },
                     @(TMTabTypeShoppingC)     : @{
                             TabBarVC           : @"MineViewController",
                             TabBarTitle        : @"购物车",
                             TabBarImage        : @"tabBar_mine.jpg",
                             TabBarSelectedImage: @"",
                             TabBarItemBadgeValue: @(0)
                             
                             },
                     
                     @(TMTabTypeMine)     : @{
                             TabBarVC           : @"MineViewController",
                             TabBarTitle        : @"个人中心",
                             TabBarImage        : @"tabBar_mine.jpg",
                             TabBarSelectedImage: @"",
                             TabBarItemBadgeValue: @(0)
                             
                             }
                     };
        
    }
    return _configs[@(type)];
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

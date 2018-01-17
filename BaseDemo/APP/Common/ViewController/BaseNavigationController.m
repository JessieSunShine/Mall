//
//  BaseNavigationController.m
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

#import "BaseNavigationController.h"

@interface UINavigationItem (margin)


@end

@implementation UINavigationItem (margin)

- (void)setLeftBarButtonItem:(UIBarButtonItem *)_leftBarButtonItem
{
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -5;//此处修改到边界的距离，请自行测试
    
    if (_leftBarButtonItem)
    {
        [self setLeftBarButtonItems:@[negativeSeperator, _leftBarButtonItem]];
    }
    else
    {
        [self setLeftBarButtonItems:@[negativeSeperator]];
    }
    
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)_rightBarButtonItem{
    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -5;//此处修改到边界的距离，请自行测试
    
    if (_rightBarButtonItem)
    {
        [self setRightBarButtonItems:@[negativeSeperator, _rightBarButtonItem]];
    }
    else
    {
        [self setRightBarButtonItems:@[negativeSeperator]];
    }
}


@end


#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

@interface BaseNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
}
@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@property (nonatomic,assign) BOOL isMoving;
@end

@implementation BaseNavigationController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.viewControllers.count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarShow object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarHide object:nil];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];


    [self setNavgationTitle];//设置导航栏标题样式
    [self hiddenNavBarBottomLine];//隐藏导航栏底部黑线
    
    [self setNavBarBack];//设置导航栏背景
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
    
    
}

/*
 * 设置导航栏标题样式
 */
-(void)setNavgationTitle
{
    NSDictionary *dic = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                          NSFontAttributeName: [JS_Tool PXFontConversionIOS:34]};
    self.navigationBar.titleTextAttributes = dic;
    [self.navigationBar setTranslucent:NO];

}

/*
 *隐藏导航栏底部的黑线
 */

-(void)hiddenNavBarBottomLine
{
    self.navigationBar.clipsToBounds = NO;
    if ([self.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

//设置导航栏背景颜色或图片
-(void)setNavBarBack
{
    //    [self.navigationBar setBackgrounImage:[UIImage imageNamed:@"navgationBar"] forBarMetrics: UIBarMetricsDefault];
    [self.navigationBar setBarTintColor:MAIN_COLOR_VALUE];
    self.navigationBar.translucent = NO;
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(_isNewAnimation){
        CATransition *animation2=[CATransition animation];
        animation2.type=@"oglFlip";
        animation2.subtype = @"fromLeft";
        //设置运动时间
        animation2.duration = 1.0f;
        //设置运动速度
        animation2.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [self.view.layer addAnimation:animation2 forKey:nil];
    }else{
        [self.screenShotsList addObject:[self capture]];
    }
    
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarHide object:nil];
    }
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if(_isNewAnimation){
        CATransition *animation2=[CATransition animation];
        animation2.type=@"oglFlip";
        animation2.subtype = @"fromRight";
        //设置运动时间
        animation2.duration = 1.0f;
        //设置运动速度
        animation2.timingFunction = UIViewAnimationOptionCurveEaseInOut;
        [self.view.layer addAnimation:animation2 forKey:nil];
    }
    
    if (self.viewControllers.count <= 2) {
        [self.screenShotsList removeAllObjects];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarShow object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarHide object:nil];
    }
    
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count <= 2) {
        [self.screenShotsList removeAllObjects];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarShow object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarHide object:nil];
        
    }
    return [super popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    [self.screenShotsList removeLastObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTabBarShow object:nil];
    
    return [super popToRootViewControllerAnimated:animated];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;
        
    }
    return self;
}

- (void)dealloc
{
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}




#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    
    NSLog(@"Move to:%f",x);
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = self.view.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                if ([JS_USER_DEFAULT boolForKey:@"isReturn"]==YES) {
                    
                    [self popToRootViewControllerAnimated:NO];
                    
                }else{
                    
                    [self popViewControllerAnimated:NO];
                    
                }
                
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

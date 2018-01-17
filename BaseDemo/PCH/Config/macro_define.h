//
//  macro_define.h
//  BaseDemo
//
//  Created by zizilink on 2017/12/20.
//  Copyright © 2017年 Jessie. All rights reserved.
//

/**
 * iOS常用宏定义小总结
 *****************************************************************
 ***|
 ***| 1. 重写DEBUG模式下的NSLog
 ***| 2. APP屏幕大小相关
 ***| 3. GCD -- 多线程   dispatch
 ***| 4. catch缓存文件夹和Documents文件夹
 ***| 5. 图片  UIImage
 ***| 6. App Version / Info Plist  系统版本比较等
 ***| 7. rgb颜色转换 UIColor
 ***| 8. 字体 UIFont  只列举一种，其他的换名称自己可定义
 ***| 9. 角度转弧度 弧度转角度
 ***| 10. 单例 singleton
 ***| 11. iOS系统内部常用宏定义
 ***
 ******************************************************************
 */
#ifdef __OBJC__   //保证 #ifdef 中的宏定义只会在 OC 的代码中被调用， 否则，一旦引入 C/C++ 的代码或者框架，就会出错

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//  1. NSLog  重写NSLog,Debug模式下打印日志和当前行数  release模式下不打印
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef  DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//  2. App 屏幕相关   Frame   Bounds
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

//状态栏高度
#ifndef StatusBarHeight
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#endif

//NavBar高度
#ifndef NavBar_HEIGHT
#define NavBar_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64
#endif

//底部tabbar高度
#ifndef TabBarHeight
#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#endif


//屏幕尺寸
#ifndef SCREEN_SIZE
#define SCREEN_SIZE        [UIScreen mainScreen].bounds
#endif

//获取屏幕 宽度、高度
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT      [[UIScreen mainScreen] bounds].size.height
#endif

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH       [[UIScreen mainScreen] bounds].size.width
#endif

//不同屏幕尺寸字体适配（375，667是因为目前苹果开发一般用IPHONE6做中间层 如果不是则根据实际情况修改）
#ifndef ScreenWidthRatio
#define ScreenWidthRatio  (SCREEN_WIDTH / 375.0)
#endif

#ifndef ScreenHeightRatio
#define ScreenHeightRatio (SCREEN_HEIGHT / 667.0)
#endif

//根据传入的值算出乘以比例之后的值
#define AdaptedWidth(x)    ceilf((x) * ScreenWidthRatio)
#define AdaptedHeight(x)   ceilf((x) * ScreenHeightRatio)


//判断是那种设备
/*
 iPhone 4  4s
 */
#ifndef IPHONE4
#define IPHONE4  ([[UIScreen mainScreen] bounds].size.height==480)
#endif

/*
 iPhone 5  5s
 */
#ifndef IPHONE5S
#define IPHONE5S ([[UIScreen mainScreen] bounds].size.height==568)
#endif

/*
 iPhone 6  6s 7 8
 */
#ifndef IPHONE6
#define IPHONE6  ([[UIScreen mainScreen] bounds].size.height==667)
#endif

/*
 iPhone 6plus  6splus 7plus 8plus
 */
#ifndef IPHONE6P
#define IPHONE6P ([[UIScreen mainScreen] bounds].size.height==736)
#endif

/*
 iPhone X
 */
#ifndef IPHONEX
#define IPHONEX ([[UIScreen mainScreen] bounds].size.height==812)
#endif

// 是否iPad
#ifndef isPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#endif


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//  3. GCD -- 多线程   dispatch
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

#define JS_GCD_MAIN(__BLOCK__)         dispatch_async(dispatch_get_main_queue(), __BLOCK__)

#define JS_GCD_ASYNC(__BLOCK__)        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), __BLOCK__)

#define JS_OPERATION_MAIN(__BLOCK__)   [[NSOperationQueue mainQueue] addOperationWithBlock:__BLOCK__]


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//   4. catch缓存文件夹和Documents文件夹
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef JS_USER_DEFAULT
#define JS_USER_DEFAULT [NSUserDefaults standardUserDefaults]
#endif

#ifndef JS_CACHE_DIR
#define JS_CACHE_DIR      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#endif

#ifndef JS_DOCUMENTS_DIR
#define JS_DOCUMENTS_DIR  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#endif


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//  5. App Version / Info Plist                                                                      //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////
//设备(手机)版本号
#ifndef IOS_VERSION_S
#define IOS_VERSION_S ([[UIDevice currentDevice] systemVersion])              //str
#endif

//设备(手机)版本号
#ifndef IOS_VERSION_F
#define IOS_VERSION_F ([[[UIDevice currentDevice] systemVersion] floatValue]) //float
#endif

//心痛类型   eg： iOS10.0.1
#ifndef JS_OSTYPE
#define JS_OSTYPE [NSString stringWithFormat:@"iOS%@", [[UIDevice currentDevice] systemVersion]]
#endif


//app 版本号
#ifndef JS_BUNDLE_SHORT_VERSION_STRING
#define JS_BUNDLE_SHORT_VERSION_STRING [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#endif

//build版本号
#ifndef JS_BUNDLE_VERSION_STRING
#define JS_BUNDLE_VERSION_STRING [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#endif

//app 版本号 + build版本号
#ifndef JS_APP_VERSION_STRING
#define JS_APP_VERSION_STRING   [NSString stringWithFormat:@"%@ (%@)", XH_BUNDLE_SHORT_VERSION_STRING, XH_BUNDLE_VERSION_STRING]
#endif

//bundleID
#ifndef JS_BUNDLE_IDENTIFIER
#define JS_BUNDLE_IDENTIFIER (NSString *)([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"])
#endif

//设备名
#ifndef JS_DEVICE_MACHINE_NAME
#define JS_DEVICE_MACHINE_NAME (NSString *)(XH_NSStringMachineNameFromCurrentDevice())
#endif

#ifndef JS_SCREEN_SCALE
#define JS_SCREEN_SCALE ([[UIScreen mainScreen] respondsToSelector:NSSelectorFromString(@"scale")] ? [[UIScreen mainScreen] scale] : 1.f)
#endif

#ifndef JS_DEBUG_APP_CONFIG_STRING
#define JS_DEBUG_APP_CONFIG_STRING [NSString stringWithFormat:@"App Version: '%@' System Version: '%@' Machine Name '%@' Bundle Identifier: '%@'", XH_APP_VERSION_STRING, XH_DEVICE_SYSTEM_VERSION, XH_DEVICE_MACHINE_NAME, XH_BUNDLE_IDENTIFIER]
#endif


//检查系统版本
//相同版本
#define SYSTEM_VERSION_EQUAL_TO(__VERSION__) ([[[UIDevice currentDevice] systemVersion] compare:__VERSION__ options:NSNumericSearch] == NSOrderedSame)

//大于该系统版本
#define SYSTEM_VERSION_GREATER_THAN(__VERSION__) ([[[UIDevice currentDevice] systemVersion] compare:__VERSION__ options:NSNumericSearch] == NSOrderedDescending)

//大于等于系统该版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(__VERSION__) ([[[UIDevice currentDevice] systemVersion] compare:__VERSION__ options:NSNumericSearch] != NSOrderedAscending)

//小于该系统版本
#define SYSTEM_VERSION_LESS_THAN(__VERSION__) ([[[UIDevice currentDevice] systemVersion] compare:__VERSION__ options:NSNumericSearch] == NSOrderedAscending)

//小于等于系统该版本
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(__VERSION__) ([[[UIDevice currentDevice] systemVersion] compare:__VERSION__ options:NSNumericSearch] != NSOrderedDescending)

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//   6. 图片  UIImage                                                                                //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

//读取本地图片 （文件名，后缀名）
#define JS_LOADIMAGE(__FILENAME__,__EXTENSION__) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:__FILENAME__ ofType:__EXTENSION__]]

//定义UIImage对象 （文件名）
#define JS_IMAGE(__IMGNAME__) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__IMGNAME__ ofType:nil]]


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//   7. rgb颜色转换 UIColor                                                                            //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

// rgb颜色转换（16进制->10进制）
#define JS_UIColorFromRGB(__RGBVALUE__) [UIColor colorWithRed:((float)((__RGBVALUE__ & 0xFF0000) >> 16))/255.0 green:((float)((__RGBVALUE__ & 0xFF00) >> 8))/255.0 blue:((float)(__RGBVALUE__ & 0xFF))/255.0 alpha:1.0]

//透明背景色
#ifndef JS_CLEARCOLOR
#define JS_CLEARCOLOR [UIColor clearColor]
#endif

#define JS_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define JS_RGB(r,g,b) JS_RGBA(r,g,b,1.0)


//#define MAIN_COLOR_VALUE  JS_UIColorFromRGB(0xf3e726)  //主色调绿色
#define MAIN_COLOR_VALUE  JS_RGB(25,188,166)
#define BACK_GROUND_COLOR JS_UIColorFromRGB(0xefefef)  //vc背景主色
///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//   8. 字体 UIFont                                                                                    //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

//方正黑体简体字体定义
#define JS_FONT(__SIZE__) [UIFont fontWithName:@"FZHTJW--GB1-0" size:__SIZE__]
#define JS_Font(f)  [UIFont systemFontOfSize:f]
#define JS_Font_Bold(f)[UIFont fontWithName:@"Helvetica-Bold" size:f]

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//   9. 角度转弧度 弧度转角度                                                                             //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////

#define JS_ANGLE_TO_RADIAN(__ANGLE__) (M_PI * (__ANGLE__) / 180.0)

#define JS_RADIAN_TO_ANGLE(__RADIAN__) (__RADIAN__ * 180.0) / (M_PI)

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//   10. 单例 singleton                                                                                 //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


// .h
#define singleton_interface(class) + (instancetype)shared##class;

// .m
#define singleton_implementation(class) \
static class *_instance; \
\
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
\
return _instance; \
} \
\
+ (instancetype)shared##class \
{ \
if (_instance == nil) { \
_instance = [[class alloc] init]; \
} \
\
return _instance; \
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
// 11. 其他系统常用宏定义                                                                               //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device code
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator code
#endif


///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
// 12.导航通知定义宏                                                                              //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////
#define NotificationCenter [NSNotificationCenter defaultCenter]
// 隐藏tabBar
#define NotificationTabBarHide @"NotificationTabBarHide"
// 显示tabBar
#define NotificationTabBarShow @"NotificationTabBarShow"


#endif


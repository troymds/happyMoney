
#ifndef MoneyMaker_AppMacro_h
#define MoneyMaker_AppMacro_h

//首次启动
#define First_Launched @"firstLaunch"

//系统版本
#define IsIos8 [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO

#define IsIos7 [[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO
#define IsIos6 [[[UIDevice currentDevice] systemVersion] floatValue] >=6.0 ? YES : NO

#define isRetina [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO

#define iPhone5 [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO

#define _iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define _iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define _iPhone6 ([UIScreen mainScreen].bounds.size.height == 667)

#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif
//占位图片

#define Account @"account"
#define Password @"password"
#define UserType @"userType"
#define quitLogin @"quitLogin"

#define placeHoderImage [UIImage imageNamed:@"default"]
#define placeHoderImage1 [UIImage imageNamed:@"homeMenu2S"]
#define placeHoderImage2 [UIImage imageNamed:@"loading_img2"]
#define placeHoderImage3 [UIImage imageNamed:@"loading_img3"]
#define placeHoderloading [UIImage imageNamed:@"loading"]

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"carMenu.data"]

#define kCarFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@carMenu.data",[[NSUserDefaults standardUserDefaults] objectForKey:Account]]];

//加载图片
//#define LOADIMAGE(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
//#define LOADPNGIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@"png"]]
#define LOADPNGIMAGE(file) [UIImage imageNamed:file]
#define Rect(x,y,width,height) CGRectMake(x, y, width, height)
//可拉伸的图片

#define ResizableImage(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define ResizableImageWithMode(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]

//App
#define kApp ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define kNav ((AppDelegate *)[UIApplication sharedApplication].delegate.navigationController)

#define DefaultAddressIdKey @"DefaultAddressId"
//color
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]//十六进制转换
#define RGBNAVbackGroundColor             [UIColor colorWithRed:(47.0 / 255.0) green:(138.0 / 255.0) blue:(201.0/ 255.0) alpha:1.0]//导航条的颜色

#define PxFont(px) (((float) px/96)*72)//字体大小转换
#define ButtonColor HexRGB(0x1c9c28)
//字体大小
#define Font18  18.0
#define Font22  22.0
#define Font36  36.0
#define Font20  20.0
#define Font24  24.0
#define Font26  26.0
#define Font28  28.0
#define Font30  30.0

//按钮背景色
#define KBtnSelectedValue 0xe5386b

#define KCellLineColor 0xdcdcdc

//设备屏幕尺寸
#define kHeight   [UIScreen mainScreen].bounds.size.height
#define kWidth    [UIScreen mainScreen].bounds.size.width

#define KAppHeight  [UIScreen mainScreen].applicationFrame.size.height
#define KAppNoTabHeight  [UIScreen mainScreen].applicationFrame.size.height - 44
//减去 状态栏，导航栏和tab的内容高度
#define KContentH   [UIScreen mainScreen].applicationFrame.size.height - 88
//拨打电话
#define canTel                 [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:"]
#define tel(phoneNumber)      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]]
#define telprompt(phoneNumber) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]]]

//打开URL
#define canOpenURL(appScheme) [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appScheme]]
#define openURL(appScheme) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appScheme]]
#endif
#define CORNERrADIUS 4
#define offline @"网络断开，请连网"
#define serviceWrong @"服务器故障，请稍后再试"
#define addAddressSuccess @"添加地址成功"
//判断字典dic中键key对应的值是否为空
#define isNull(dic,key) [[dic objectForKey:key] isKindOfClass:[NSNull class]]?YES:NO

//#define kUrl @"http://192.168.1.112/restaurant"
//#define kUrl @"http://192.168.0.126/restaurant"
//#define kUrl @"http://192.168.1.183/zlz/"
//#define kUrl @"http://192.168.1.122/zlz/"
#define kUrl @"http://120.24.77.104/zlz/"
// 2.日志输出宏定义
#ifdef DEBUG
// 调试状态
#define NSLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态
#define NSLog(...)
#endif


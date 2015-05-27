//
//  AppDelegate.m
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "NewfeatureController.h"
#import "SSKeychain.h"
#import "SystemConfig.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "HttpTool.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "ProAlertView.h"
#import "KeychainItemWrapper.h"
#import "UserItem.h"
#import "SystemConfig.h"

@interface AppDelegate ()<ProAlertViewDelegate>
@property (nonatomic,copy) NSString *download_link;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //获取用户uuid
    [self getUuid];
    NSString *key = @"CFBundleShortVersionString";
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (saveVersion)
    {
//        [self checkVersion];
    }
    
    if ([version isEqualToString:saveVersion]) { // 不是第一次使用这个版本
        // 显示状态栏
        application.statusBarHidden = YES;
        _mainCtl = [[MainController alloc] init];
        self.window.rootViewController = _mainCtl;
        
    } else { // 版本号不一样：第一次使用新版本
        // 将新版本号写入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //获得UID
        [self addUID];
        // 显示版本新特性界面
        application.statusBarHidden = YES;
        self.window.rootViewController = [[NewfeatureController alloc] init];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self shareRegister];
    [self autoLogin];
    
    [self.window makeKeyAndVisible];
    return YES;;
}

#pragma mark 自动登录 
-(void)autoLogin
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *account = [user objectForKey:Account];
    NSString *password = [user objectForKey:Password];
    NSString *type = [user objectForKey:UserType];
    NSInteger isQuit = [[user objectForKey:quitLogin] integerValue];
    if (account && password && isQuit == 1) {
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:account,@"phone_num",password,@"password",type,@"type", nil];
        [HttpTool postWithPath:@"login" params:param success:^(id JSON, int code) {
            NSLog(@"%@",JSON);
            NSDictionary *response = [JSON objectForKey:@"response"];
            if (code == 100) {
                UserItem *item = [[UserItem alloc] initWithDic:[response objectForKey:@"data"]];
                //单例存储用户相关信息
                [SystemConfig sharedInstance].userType = [type intValue];
                [SystemConfig sharedInstance].isUserLogin = YES;
//                [SystemConfig sharedInstance].uid = item.uid;
                [SystemConfig sharedInstance].user = item;
//                [SystemConfig sharedInstance].isUserLogin = NO;
            }
        } failure:^(NSError *error) {
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }
}

-(void)addUID{
    
//    [uidTool statusesWithSuccessUid:^(NSString *ID) {
//        //把UID写入沙盒
//        [[NSUserDefaults standardUserDefaults] setObject:ID forKey:@"uid"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    } failure:^(NSError *error) {
//        
//    }];
}

#pragma mark 检查更新
- (void)checkVersion
{
    [HttpTool postWithPath:@"getNewestVersion" params:nil success:^(id JSON, int code) {
        if (code == 100) {
            //当前版本
            NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
            float currentVersion_float = [currentVersion floatValue];
            //服务器存储版本
            NSString *version = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"version_code"];
            float version_float = [version floatValue];
            if (currentVersion_float<version_float) {
                _download_link = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"download_link"];
                ProAlertView *alertView = [[ProAlertView alloc] initWithTitle:@"温馨提示" withMessage:@"检测到新版本,是否前往更新" delegate:self cancleButton:@"取消" otherButton:@"前往更新", nil];
                alertView.tag = 1001;
                [alertView show];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}


//获取用户uuid

- (void)getUuid
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"JSTY" accessGroup:nil];
    
    
    NSString *strUUID = [keychainItem objectForKey:(__bridge id)kSecValueData];
    
    if ([strUUID isEqualToString:@""])
    {
        
        strUUID = [[NSUUID UUID] UUIDString];
        
        
        [keychainItem setObject:strUUID forKey:(__bridge NSString*)kSecValueData];
        
    }
    
    
    strUUID = [[keychainItem objectForKey:(__bridge NSString*)kSecValueData] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    [SystemConfig sharedInstance].uuidStr  = strUUID;
}
- (void)shareRegister
{
    //分享
    [ShareSDK registerApp:shareAppKey];
    //    2024920655    568898243
    //    991be92dac7972e18d426bd3a441ba3f    38a4f8204cc784f81f9f0daaf31e02e3
    //    http://www.baidu.com     http://www.sharesdk.cn
    
    //    2181797068
    //   a8b061a9844ddbd614c4c7d8a212d82d
    //    http://china-promote.com
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"2181797068"
                               appSecret:@"a8b061a9844ddbd614c4c7d8a212d82d"
                             redirectUri:@"http://china-promote.com"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"2181797068"
                                appSecret:@"a8b061a9844ddbd614c4c7d8a212d82d"
                              redirectUri:@"http://china-promote.com"
                              weiboSDKCls:[WeiboSDK class]];
    
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"1104005075"
                           appSecret:@"QFkbo0F8bS2OPaIP"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"1104005075"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:WXAppId
                           wechatCls:[WXApi class]];
    
    //短信分享
    [ShareSDK connectSMS];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (self.updateUrl&&self.updateUrl.length!=0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.updateUrl]];
        }
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [SystemConfig sharedInstance].isUserLogin = NO;
}

@end

//
//  AppDelegate.h
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainController.h"

#define QQAPPID @"1103300585"
#define QQAPPKEY @"0utta5zCiZfvGdDX"
#define shareAppKey @"7d2071a1aa60"
#define SinaAppKey @"531851719"
#define SinaAppSecret @"a3498ee96939375894170b4746f6d79b"
#define TencentAppKey @"1103300585"
#define TencentAppSecret @"0utta5zCiZfvGdDX"
#define RenrenAppId @"272485"
#define RenrenAppKey @"6789fb614d8941a1a64add0dbb8b70ae"
#define RenrenAppSecret @"3d2a59b71ad145e8b7a5f14256a3be55"
#define WXAppId @"wx99390fe5ca200bb6"
#define WXAppSecret @"054c98ca5301a653810570a908ea23a1"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSString *updateUrl;
@property (nonatomic,strong) MainController *mainCtl;
@end


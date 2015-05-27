//
//  HomeController.h
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KHomeMenu1 = 0,//店铺
    KHomeMenu2,    //个人
    KHomeMenu3
} HomemenuBtnType;

typedef enum
{
    KHomeMenu4 = 0,//财富圈
    KHomeMenu5,    //购物车
    KHomeMenu6,     //收支记录
    KHomeMenu7      //邀请好友
} HomeCateBtnType;

@interface HomeController : UIViewController

@end

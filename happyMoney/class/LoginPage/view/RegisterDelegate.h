//
//  RegisterDelegate.h
//  happyMoney
//
//  Created by promo on 15-4-21.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    KBuiness = 0,//店铺
    KPersonal    //个人
} menuBtnType;

@protocol RegisterDelegate <NSObject>
-(void) personRegist;
-(void) personUpLoad;
-(void) BusinessApply;
//-(void) applyRegist;
@end

//
//  BusineseRegister.h
//  happyMoney
//
//  Created by promo on 15-4-21.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterDelegate.h"
@class MDSTextField;

@interface BusineseRegister : UIView
@property (nonatomic, assign) id<RegisterDelegate> delegate;
@property (nonatomic, strong) MDSTextField *contact; //联系人
@property (nonatomic, strong) MDSTextField *businessName;//店铺名
@property (nonatomic, strong) MDSTextField *businessAddress;//店铺地址
@property (nonatomic, strong) MDSTextField *license;//营业执照编号;
@property (nonatomic, assign) CGFloat contentHeight;//动态高度
@end

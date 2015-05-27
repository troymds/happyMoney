//
//  CashMenuItem.h
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashMenuItem : UIView
-(id) initWithFrame:(CGRect)frame icon:(NSString *)icon title:(NSString *)title btnTag:(NSInteger)btnTag;

@property (nonatomic,copy) UILabel *money;
@end

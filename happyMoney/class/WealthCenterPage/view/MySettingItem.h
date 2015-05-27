//
//  MySettingItem.h
//  happyMoney
//
//  Created by promo on 15-4-22.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySettingItem : UIView
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIButton *ViewBtn;
- (instancetype)initWithFrame:(CGRect)frame hasRightArrow:(BOOL) hasRightArrow withTitle:(NSString *)title;
@end

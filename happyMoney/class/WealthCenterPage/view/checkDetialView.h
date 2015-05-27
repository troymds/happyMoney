//
//  checkDetialView.h
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KInfoStyleWuliu = 1,
    KInfoStyleSelf
} KInfoStyle;

@interface checkDetialView : UIView
@property (nonatomic,assign) KInfoStyle styler;
@property (nonatomic,strong) UILabel *tel;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UILabel *sty;
@end

//
//  CashMenuItem.m
//  happyMoney
//  提现菜单栏菜单
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CashMenuItem.h"

@implementation CashMenuItem

-(id) initWithFrame:(CGRect)frame icon:(NSString *)icon title:(NSString *)title btnTag:(NSInteger)btnTag
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat viewH = 0;
        UIImageView *iconview = [[UIImageView alloc] init];
        iconview.image = [UIImage imageNamed:icon];
        CGFloat iconWH = 50;
        CGFloat iconX = (kWidth/4 - iconWH)/2;
        CGFloat iconY = 20;
        iconview.frame = Rect(iconX, iconY, iconWH, iconWH);
        [self addSubview:iconview];
        
        UILabel *titleL = [[UILabel alloc] init];
        [self addSubview:titleL];
        titleL.text = title;
        titleL.textColor = HexRGB(0x808080);
        titleL.font = [UIFont systemFontOfSize:15.0];
        CGFloat titleLY = CGRectGetMaxY(iconview.frame);
        titleL.frame = Rect(iconX , titleLY, iconWH, 25);
        viewH = CGRectGetMaxY(titleL.frame) + iconY;
        
        CGFloat shuxianY = iconY + iconWH/2;
        UIView *shuxian = [[UIView alloc] init];
        shuxian.frame = Rect(kWidth/4 + 0, shuxianY, 1, iconWH/1.5);
        [self addSubview:shuxian];
        shuxian.backgroundColor = HexRGB(0xbebebe);
        
        UILabel *_mone = [[UILabel alloc] init];
        [self addSubview:_mone];
        CGFloat monX = CGRectGetMaxX(shuxian.frame) + 10;
        CGFloat monY = shuxianY + 4;
        _mone.text = @"¥ 800";
        _mone.textColor = HexRGB(0x808080);
        _mone.font = [UIFont systemFontOfSize:20.0];
        _mone.frame = Rect(monX, monY, 100, 30);
        _money = _mone;
        
        CGFloat shuxianSY = iconY/2;
        CGFloat shuxinSH = viewH - shuxianSY;
        UIView *shuxianS = [[UIView alloc] init];
        shuxianS.backgroundColor = HexRGB(0xbebebe);
        shuxianS.frame = Rect((kWidth/2 - 1), shuxianSY, 1, shuxinSH);
        [self addSubview:shuxianS];
        if (btnTag == 1) {
            shuxianS.hidden = YES;
        }
        shuxianS.backgroundColor = HexRGB(0xbebebe);
    }
    return self;
}

@end

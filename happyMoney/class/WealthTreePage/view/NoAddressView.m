//
//  NoAddressView.m
//  happyMoney
//
//  Created by promo on 15-5-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "NoAddressView.h"

@interface NoAddressView ()
{
    UIView *_bgView;
    UIView *_backGround;
}
@end
@implementation NoAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //1 背景
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth,kHeight)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.6;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//        [_bgView addGestureRecognizer:tap];
        //        [self addSubview:_bgView];
        //2
        CGFloat startX = 20;
        CGFloat backH = 230;
        CGFloat startY = (kHeight - backH ) / 2;
        CGFloat bacnW = kWidth - startX * 2;
        UIView *backGround = [[UIView alloc] initWithFrame:Rect(startX, startY, bacnW, backH)];
        //        [self addSubview:backGround];
        backGround.layer.masksToBounds = YES;
        backGround.layer.cornerRadius = 5.0;
        backGround.backgroundColor = [UIColor whiteColor];
        _backGround = backGround;
        
        //3 tishi
        UILabel *hit = [[UILabel alloc] initWithFrame:Rect(startX, startX, 100, 25)];
        hit.font = [UIFont systemFontOfSize:PxFont(Font26)];
        hit.textColor = HexRGB(0x3a3a3a);
        hit.text = @"温馨提示";
        [backGround addSubview:hit];
        hit.backgroundColor  = [UIColor clearColor];
        
        CGFloat lineW = bacnW - startX * 2;
        UIView *line = [[UIView alloc] initWithFrame:Rect(startX, CGRectGetMaxY(hit.frame) + startX, lineW, 0.5)];
        [backGround addSubview:line];
        line.backgroundColor = HexRGB(KCellLineColor);
        
        CGFloat contentY = CGRectGetMaxY(line.frame) + 5;
        CGFloat contentH = 25;
        UILabel *content = [[UILabel alloc] initWithFrame:Rect(startX, contentY, lineW, contentH)];
        content.font = [UIFont systemFontOfSize:PxFont(Font22)];
        content.textColor = HexRGB(0x3a3a3a);
        content.text = @"目前您还没有有效的收货地址，";
        [backGround addSubview:content];
        content.backgroundColor = [UIColor clearColor];
        
        CGFloat contY = CGRectGetMaxY(content.frame) + 10;
        
        UILabel *conte = [[UILabel alloc] initWithFrame:Rect(startX, contY, lineW, contentH)];
        conte.font = [UIFont systemFontOfSize:PxFont(Font22)];
        conte.textColor = HexRGB(0x3a3a3a);
        conte.text = @"是否立即添加收货地址?";
        [backGround addSubview:conte];
        conte.backgroundColor = [UIColor clearColor];
        
        CGFloat btnW = (bacnW - 10 - startX * 2) / 2;
        UIButton *later = [UIButton buttonWithType:UIButtonTypeCustom];
        later.frame = Rect(startX, CGRectGetMaxY(conte.frame) + 20, btnW, 40);
        [backGround addSubview:later];
        [later setTitle:@"稍后添加" forState:UIControlStateNormal];
        later.backgroundColor = [UIColor clearColor];
        later.layer.masksToBounds = YES;
        later.layer.cornerRadius = 5.0f;
        later.layer.borderColor = ButtonColor.CGColor;
        later.layer.borderWidth = 1.0;
        [later setTitleColor:ButtonColor forState:UIControlStateNormal];
        [later setTitleColor:ButtonColor forState:UIControlStateHighlighted];
        _later= later;
        [later addTarget:self action:@selector(deleteNoaddress) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
        add.frame = Rect(CGRectGetMaxX(later.frame) + 10, CGRectGetMaxY(conte.frame) + 20, btnW, 40);
        [backGround addSubview:add];
        [add setTitle:@"立即添加" forState:UIControlStateNormal];
        add.backgroundColor = ButtonColor;
        add.layer.masksToBounds = YES;
        add.layer.cornerRadius = 5.0f;
        add.layer.borderColor = ButtonColor.CGColor;
        add.layer.borderWidth = 1.0;
        [add setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [add addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
        _add= add;
        
    }
    return self;
}


-(void) show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [window addSubview:_bgView];
    [window addSubview:_backGround];
}

- (void) dismiss
{
    [_bgView removeFromSuperview];
    [_backGround removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark 回到自提页面
-(void)deleteNoaddress
{
    if ([self.delegate respondsToSelector:@selector(later)]) {
        [self.delegate later];
    }
}

#pragma mark 添加地址
-(void)addAddress
{
    if ([self.delegate respondsToSelector:@selector(add)]) {
        [self.delegate add];
    }
}

@end

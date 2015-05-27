//
//  UseStyleView.m
//  happyMoney
//  确认订单使用方式view
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UseStyleView.h"

#define UserItemH 30
#define BackViewW 160
#define KArrowStart 100
#define KBtnStart  10

@implementation UseStyleView
{
    UIButton *_arrow;
}

-(id) initWithFrame:(CGRect)frame userStyle:(NSInteger )count
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _count = count;
        
        UILabel *userName = [[UILabel alloc] init];
        userName.backgroundColor = [UIColor clearColor];
        userName.text = @"支付方式:";
        userName.frame = Rect(0, 0, 100, 30);
        [self addSubview:userName];
        
        CGFloat backViewH = UserItemH * count;
        UIView *backview  = [[UIView alloc] init];
        backview.frame = Rect(CGRectGetMaxX(userName.frame) + 5, 0, BackViewW, backViewH);
        [self addSubview:backview];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 5;
        backview.layer.borderWidth = 1.0;
        backview.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        
        //根据数据画btn
        NSArray *titles = @[@"微信支付",@"支付宝支付"];
        for (int i = 0; i < count; i++) {
            CGFloat btnY = UserItemH * i;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.backgroundColor = [UIColor redColor];
            
            btn.frame = Rect(0, btnY, BackViewW, UserItemH);
            [backview addSubview:btn];
            [btn addTarget:self action:@selector(btnClicke:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag = i + KBtnStart;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:HexRGB(0x3a3a3a) forState:UIControlStateNormal];
            if (i != count - 1) {
                CGFloat lineY = btnY + UserItemH;
                UIView *line = [[UIView alloc] initWithFrame:Rect(0, lineY, frame.size.width, 0.5)];
                [backview addSubview:line];
                line.backgroundColor = HexRGB(KCellLineColor);
            }
            CGFloat arrowHW = 25;
            CGFloat arrowX = BackViewW - 5 - arrowHW;
            CGFloat arrowY =  (UserItemH - arrowHW) / 2 + UserItemH * i;
            
            UIButton *arrow = [UIButton buttonWithType:UIButtonTypeCustom];
            arrow.frame = Rect(arrowX, arrowY, arrowHW, arrowHW);
            [backview addSubview:arrow];
            [arrow addTarget:self action:@selector(arrowclick:) forControlEvents:UIControlEventTouchUpInside];
            arrow.tag = KArrowStart + i;
//            arrow.backgroundColor = [UIColor redColor];
            [arrow setImage:LOADPNGIMAGE(@"首页2_05") forState:UIControlStateNormal];
            if (i != 0) {
//                arrow.hidden = YES;
                [arrow setImage:LOADPNGIMAGE(@"") forState:UIControlStateNormal];
//                arrow.backgroundColor = [UIColor greenColor];
//                btn.backgroundColor = [UIColor redColor];
            }
        }
    }
    return self;
}

-(void)arrowclick:(UIButton *)arrow
{
    _selectedIndex = arrow.tag - KArrowStart;
    [self changeArrowState];
}

-(void)btnClicke:(UIButton *)btn
{
    _selectedIndex = btn.tag - KBtnStart;
    if ([self.delegate respondsToSelector:@selector(UserStyleWithIndex:)]) {
        [self.delegate UserStyleWithIndex:_selectedIndex];
    }
    [self changeArrowState];
}

-(void) changeArrowState
{
    UIButton *arrow = nil;
    for (int i = 0; i < _count; i++) {
        arrow = (UIButton *) [self viewWithTag:i + KArrowStart];
        if (i + KArrowStart == _selectedIndex + KArrowStart) {
//            arrow.hidden = NO;
            [arrow setImage:LOADPNGIMAGE(@"首页2_05") forState:UIControlStateNormal];
        }else
        {
//            arrow.hidden = YES;
            [arrow setImage:LOADPNGIMAGE(@"") forState:UIControlStateNormal];
        }
    }
    
}

@end

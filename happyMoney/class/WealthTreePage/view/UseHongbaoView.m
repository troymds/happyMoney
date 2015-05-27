//
//  UseHongbaoView.m
//  happyMoney
//
//  Created by promo on 15-5-25.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UseHongbaoView.h"

#define UserItemH 30
#define BackViewW 160
#define KLineStart 100
#define KBtnStart  10

@implementation UseHongbaoView
{
    UIButton *_arrow;
    UIButton *_firstBtn;
    UIView *_backview;
}
-(id) initWithFrame:(CGRect)frame wihtData:(NSInteger )data
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = KUseing;
        _count = data;
        
        UIView *backview  = [[UIView alloc] init];
        CGFloat backViewH = UserItemH * data;
        backview.frame = Rect(0, 0, BackViewW, backViewH);
        [self addSubview:backview];
        backview.layer.borderWidth = 1.0;
        backview.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 5;
        _backview = backview;
        
        //根据数据画btn
        for (int i = 0; i < data; i++) {
            CGFloat btnY = UserItemH * i;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = Rect(0, btnY, backview.frame.size.width, UserItemH);
            [backview addSubview:btn];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag = i + KBtnStart;
            [btn setTitle:[NSString stringWithFormat:@"¥ %d",i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:HexRGB(0x3a3a3a) forState:UIControlStateNormal];
            if (i != data - 1) {
                CGFloat lineY = btnY + UserItemH;
                UIView *line = [[UIView alloc] initWithFrame:Rect(0, lineY, frame.size.width, 0.5)];
                [backview addSubview:line];
                line.tag = KLineStart + i;
                line.backgroundColor = HexRGB(KCellLineColor);
            }
            if (i == 0) {
                [btn setTitle:@"不使用优惠卷 " forState:UIControlStateNormal];
                _firstBtn = btn;
                CGFloat arrowHW = 25;
                CGFloat arrowX = BackViewW - 5 - arrowHW;
                CGFloat arrowY =  (UserItemH - arrowHW) / 2;
                UIButton *arrow = [UIButton buttonWithType:UIButtonTypeCustom];
                arrow.frame = Rect(arrowX, arrowY, arrowHW, arrowHW);
                _arrow = arrow;
                [arrow addTarget:self action:@selector(arrowclick) forControlEvents:UIControlEventTouchUpInside];
                [backview addSubview:arrow];
                [arrow setImage:LOADPNGIMAGE(@"确认订单2") forState:UIControlStateNormal];
            }
        }
    }
    return self;
}

-(void)arrowclick
{
    if (self.type == KUseing) {
        self.type = KNoUse;
    }else
    {
        self.type = KUseing;
    }
    if (self.type == KUseing) {
        [_firstBtn setTitle:@"不使用优惠卷 " forState:UIControlStateNormal];
        [_arrow setImage:LOADPNGIMAGE(@"确认订单2") forState:UIControlStateNormal];
    }else
    {
        [_firstBtn setTitle:@"使用优惠卷 " forState:UIControlStateNormal];
        [_arrow setImage:LOADPNGIMAGE(@"确认订单") forState:UIControlStateNormal];
    }
    
    [self hideOrShow];
}

-(void)btnClicked:(UIButton *)btn
{
    // 1 通知主视图 改变frame
    if ([self.delegate respondsToSelector:@selector(useHongBaoClicked:)]) {
        [self.delegate useHongBaoClicked:btn.tag - KBtnStart];
    }
    
    // 2 改变状态
    if (self.type == KUseing) {
        self.type = KNoUse;
    }else
    {
        self.type = KUseing;
    }
    
    if (btn.tag == 0 + KBtnStart) {
        if (self.type == KUseing) {
            [btn setTitle:@"不使用优惠卷 " forState:UIControlStateNormal];
            [_arrow setImage:LOADPNGIMAGE(@"确认订单2") forState:UIControlStateNormal];
           
        }else
        {
            [btn setTitle:@"使用优惠卷 " forState:UIControlStateNormal];
            [_arrow setImage:LOADPNGIMAGE(@"确认订单") forState:UIControlStateNormal];
            
        }
    }else
    {
        //选中点击的按钮，隐藏除了第一个的所有btn
        if (self.type == KUseing) {
            [_firstBtn setTitle:[NSString stringWithFormat:@"¥ %ld",btn.tag - KBtnStart] forState:UIControlStateNormal];
            [_arrow setImage:LOADPNGIMAGE(@"确认订单2") forState:UIControlStateNormal];
            
        }else
        {
            [_firstBtn setTitle:[NSString stringWithFormat:@"¥ %ld",btn.tag - KBtnStart] forState:UIControlStateNormal];
            [_arrow setImage:LOADPNGIMAGE(@"确认订单") forState:UIControlStateNormal];
            
        }
        
    }
    [self hideOrShow];
}

#pragma mark 隐藏或显示按钮和线
-(void) hideOrShow
{
    if (self.type == KUseing) {
        //全部显示
        for (int i = 0; i < _count; i++) {
            if (i != 0) {
                UIButton *btn = (UIButton *)[self viewWithTag:i + KBtnStart];
                btn.hidden = NO;
                
                if (i != _count - 1) {
                    UIView *line = (UIView *)[self viewWithTag:i + KLineStart];
                    line.hidden = NO;
                }
            }
        }
        
        CGRect backRect = _backview.frame;
        backRect.size.height = UserItemH * _count;
        _backview.frame = backRect;
        
    }else
    {
        // 1 隐藏除了第一个的所有btn和线
        for (int i = 0; i < _count; i++) {
            if (i != 0) {
                UIButton *btn = (UIButton *)[self viewWithTag:i + KBtnStart];
                btn.hidden = YES;
                
                if (i != _count - 1) {
                    UIView *line = (UIView *)[self viewWithTag:i + KLineStart];
                    line.hidden = YES;
                }
            }
        }
        // 2 改变backview的frame
        CGRect backRect = _backview.frame;
        backRect.size.height = UserItemH;
        _backview.frame = backRect;
        
    }
}

@end

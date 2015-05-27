//
//  ServerHitView.m
//  happyMoney
//  代理商提示页面
//  Created by promo on 15-5-6.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ServerHitView.h"

@interface ServerHitView()
{
    UIView *_bgView;
    UIView *_backGround;
}

@end

@implementation ServerHitView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //1 背景
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth,kHeight)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.6;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
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
        
        CGFloat lineW = bacnW - startX * 2 + 10;
        UIView *line = [[UIView alloc] initWithFrame:Rect(startX, CGRectGetMaxY(hit.frame) + 10, lineW, 0.5)];
        [backGround addSubview:line];
        line.backgroundColor = HexRGB(KCellLineColor);
        
        CGFloat contentY = CGRectGetMaxY(line.frame) + 10;
        CGFloat contentH = backH - contentY - startX - 40;
        UILabel *content = [[UILabel alloc] initWithFrame:Rect(startX, contentY, lineW, contentH)];
        content.font = [UIFont systemFontOfSize:PxFont(Font22)];
        content.textColor = HexRGB(0x3a3a3a);
        content.numberOfLines = 0;
        content.text = @"您的申请已提交，我们会在7个工作日内进行审核，审核结果将发送到您的手机。";
        [backGround addSubview:content];
        content.backgroundColor = [UIColor clearColor];
        
        NSString *labelText = @"您的申请已提交，我们会在7个工作日内进行审核，审核结果将发送到您的手机。";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:15];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        content.attributedText = attributedString;
        [content sizeToFit];
        
        
        UIButton *OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        OKBtn.frame = Rect(startX, CGRectGetMaxY(content.frame) + 20, lineW, 40);
        [backGround addSubview:OKBtn];
        [OKBtn setTitle:@"好的，返回首页" forState:UIControlStateNormal];
        OKBtn.backgroundColor = [UIColor clearColor];
        OKBtn.layer.masksToBounds = YES;
        OKBtn.layer.cornerRadius = 5.0f;
        OKBtn.layer.borderColor = ButtonColor.CGColor;
        OKBtn.layer.borderWidth = 1.0;
        [OKBtn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [OKBtn setTitleColor:ButtonColor forState:UIControlStateHighlighted];
        _okBtn = OKBtn;
        
    }
    return self;
}

- (void)butn
{
    NSLog(@"butn");
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
@end

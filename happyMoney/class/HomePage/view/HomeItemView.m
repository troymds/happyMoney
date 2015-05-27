//
//  HomeItemView.m
//  happyMoney
//
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "HomeItemView.h"

@implementation HomeItemView

-(id) initWithFrame:(CGRect)frame icon:(NSString *)icon title:(NSString *)title num:(NSString *)num btnTag:(NSInteger )btnTag
{
    self = [super initWithFrame:frame];
    if (self) {
        //1 背景框
        UIView *roundFrame = [[UIView alloc] initWithFrame:Rect(0, 0, frame.size.width, frame.size.height)];
        roundFrame.layer.borderColor = HexRGB(0x77c116).CGColor;
        roundFrame.layer.borderWidth = 1.0;
        roundFrame.layer.masksToBounds = YES;
        roundFrame.layer.cornerRadius = 10.0;
        [self addSubview:roundFrame];
        
        CGFloat topSpace = 5;
        CGFloat iconW = frame.size.width / 2;
        CGFloat leftSpace = (frame.size.width - iconW)/2;
        
        //2 icom
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:iconView];
        [iconView setImage:[UIImage imageNamed:icon]];
        
        CGFloat iconX = frame.size.width / 2 - iconW/2;
        iconView.frame = Rect(iconX, topSpace, iconW, iconW);
//        iconView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        
        CGFloat titleH = iconW / 2;
        //3 title
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
        titleLabel.frame = Rect(leftSpace - 8, CGRectGetMaxY(iconView.frame), 100, titleH);
        titleLabel.textColor = HexRGB(0x3a3a3a);
        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.center = CGPointMake(iconView.center.x, iconView.center.y);
        
        titleLabel.text = title;
        [self addSubview:titleLabel];
        
        //4 number
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
        numLabel.textColor = HexRGB(0x3a3a3a);
        numLabel.frame = Rect(frame.size.width/2 - 8, CGRectGetMaxY(titleLabel.frame) - 5, 60, titleH);
//        numLabel.center = CGPointMake(iconView.center.x, iconView.center.y);
        numLabel.text = num;
        numLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:numLabel];
        
        //5 button
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:backBtn];
        
        backBtn.tag = btnTag;
        [backBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = roundFrame.frame;
        
    }
    return self;
}

-(void)btnClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(homeItemBtnClieked:clickedBtnTag:)]) {
        [self.delegate homeItemBtnClieked:self clickedBtnTag:btn.tag];
    }
}

@end

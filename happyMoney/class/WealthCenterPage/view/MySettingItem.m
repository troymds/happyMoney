//
//  MySettingItem.m
//  happyMoney
//
//  Created by promo on 15-4-22.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MySettingItem.h"

@implementation MySettingItem

- (instancetype)initWithFrame:(CGRect)frame hasRightArrow:(BOOL) hasRightArrow withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = HexRGB(0xf3f3f3);
        
        CGFloat height = frame.size.height;
        CGFloat Width = frame.size.width;
        CGFloat startXY = 20;
        CGFloat imgWH = (height - startXY)/2;
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Width,height)];
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        
        if (hasRightArrow) {
            UIImageView *soreImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,25,25)];
            soreImg.image = [UIImage imageNamed:@"rightSore"];
            soreImg.center = CGPointMake(bgView.frame.size.width-soreImg.frame.size.width/2,bgView.frame.size.height/2);
            [bgView addSubview:soreImg];
        }
        
        UILabel *_title = [[UILabel alloc] initWithFrame:CGRectMake(startXY,startXY,200,imgWH)];
        _title.backgroundColor = [UIColor clearColor];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textColor = HexRGB(0x808080);
        [bgView addSubview:_title];
        _title.text = title;
        
        UIView *line = [[UIView alloc] initWithFrame:Rect(0, height - 0.6, Width, 0.6)];
        [bgView addSubview:line];
        line.backgroundColor = HexRGB(KCellLineColor);
        _line = line;
        
        UIButton *_cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cellBtn.frame = CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height);
        [bgView addSubview:_cellBtn];
        _ViewBtn = _cellBtn;
    }
    return self;
}

@end

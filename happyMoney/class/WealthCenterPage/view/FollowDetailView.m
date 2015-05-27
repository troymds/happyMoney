//
//  FollowDetailView.m
//  happyMoney
//  物流跟踪详细页面
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "FollowDetailView.h"
#import "FollowData.h"

@implementation FollowDetailView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //1 icon
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_icon];
        _icon.backgroundColor = [UIColor clearColor];
        
        //2 line
        _line = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_line];
        _line.image = LOADPNGIMAGE(@"shuxian");
        //3 title
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_title];
        _title.font = [UIFont systemFontOfSize:16.0];
        _title.textColor = HexRGB(0x57910a);
        
        //4 date
        _date = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_date];
        _date.font = [UIFont systemFontOfSize:14.0];
        _date.textColor = HexRGB(0x57910a);
        
        UIView *lineEnd = [[UIView alloc] initWithFrame:Rect(43, self.frame.size.height - 1, kWidth - 43 , 1)];
        [self addSubview:lineEnd];
        lineEnd.backgroundColor = HexRGB(0xbebebe);
        
    }
    return self;
}

-(void)setData:(FollowData *)data
{
    // 1 如果是唯一的一个或者最后签收，图片是circleGreen，线条在图片的下面
    CGFloat startY = 10;
    CGFloat iconWH = 13;
    _icon.frame = Rect(startY, startY, iconWH, iconWH);
    
    CGFloat lineX = _icon.center.x;
    CGFloat lineY = CGRectGetMaxY(_icon.frame);
    CGFloat lineH = self.frame.size.height - lineY;
    _line.frame = Rect(lineX, lineY, 1, lineH);
    
    if (data.isLast) {
        _icon.image = LOADPNGIMAGE(@"circleGreen");
        _title.textColor = HexRGB(0x57910a);
        _date.textColor =  HexRGB(0x57910a);
    }else
    {
        _icon.image = LOADPNGIMAGE(@"circle_gray");
        _title.textColor = [UIColor blackColor];
        _date.textColor =  [UIColor blackColor];
        
        
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:Rect(lineX, 0, 1, startY)];
        [self addSubview:topLine];
        topLine.image = LOADPNGIMAGE(@"shuxian");
        topLine.image = LOADPNGIMAGE(@"shuxian");
    }
    //2
    CGFloat titleX = CGRectGetMaxX(_icon.frame) + startY * 2;
    CGFloat space = 4;
    CGFloat titleH = (self.frame.size.height - startY * 2 - space )/2;
    CGFloat titleW = kWidth - titleX;
    _title.frame = Rect(titleX, startY, titleW, titleH);
    _title.text = data.title;
    
    _date.frame  = Rect(titleX, CGRectGetMaxY(_title.frame) + space, titleW, titleH);
    _date.text = data.date;
}

@end

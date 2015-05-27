//
//  HMSettingCell.m
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "HMSettingCell.h"
#import "ShadowView.h"

@implementation HMSettingCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = HexRGB(0xf3f3f3);
        
        CGFloat height = 45;
        CGFloat imgWidth = 25;
        CGFloat imgHeight = 25;
        
        ShadowView *bgView = [[ShadowView alloc] initWithFrame:CGRectMake(15,15,kWidth-30,height)];
        [self.contentView addSubview:bgView];
        
        UIImageView *soreImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,25,25)];
        soreImg.image = [UIImage imageNamed:@"rightSore"];
        soreImg.center = CGPointMake(bgView.frame.size.width-soreImg.frame.size.width/2,bgView.frame.size.height/2);
        [bgView addSubview:soreImg];
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,imgWidth,imgHeight)];
        _icon.center = CGPointMake(10+_icon.frame.size.width/2,bgView.frame.size.height/2);
        [bgView addSubview:_icon];
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(5+imgWidth+20,0,150,height)];
        _title.backgroundColor = [UIColor clearColor];
        _title.font = [UIFont systemFontOfSize:22];
        _title.textColor = HexRGB(0x808080);
        [bgView addSubview:_title];
        
        _cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cellBtn.frame = CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height);
        [bgView addSubview:_cellBtn];
    }
    return self;
}
@end

//
//  InOutRecordsCell.m
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "InOutRecordsCell.h"
#import "flowRecordModel.h"
#import "SystemConfig.h"
#import "UserItem.h"
#import "Tool.h"

@implementation InOutRecordsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _icon.backgroundColor  = [UIColor clearColor];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = 5.0;
        
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.backgroundColor = [UIColor clearColor];
        _title.font = [UIFont systemFontOfSize:PxFont(Font24)];
        _title.textColor = HexRGB(0x3a3a3a);
        [self.contentView addSubview:_title];
        
        
        _date = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _date.backgroundColor = [UIColor clearColor];
        _date.font = [UIFont systemFontOfSize:PxFont(Font24)];
        _date.textColor = HexRGB(0x808080);
        [self.contentView addSubview:_date];
        
        _money = [[UILabel alloc] initWithFrame:CGRectZero];
        _money.backgroundColor = [UIColor clearColor];
        _money.font = [UIFont systemFontOfSize:PxFont(Font28)];
        _money.textColor = HexRGB(0x3a3a3a);
        [self.contentView addSubview:_money];
    }
    return self;
}

-(void)setType:(recordType )type
{
    CGFloat startX = 15;
    CGFloat startY = 15;
    CGFloat imgHW = 50;
    CGFloat cellH = startX * 2 + imgHW;
    CGFloat spaceBteweenTitle = 8;
    CGFloat titleH = (imgHW - spaceBteweenTitle)/2;
    
    CGFloat titleX;
    if (type == KRecordIn) {
        //收入
        _icon.frame  = CGRectMake(startX,startY,imgHW,imgHW);
        [self.contentView addSubview:_icon];
        NSString *img = [SystemConfig sharedInstance].user.avatar == nil ? @"default": [SystemConfig sharedInstance].user.avatar;
        [_icon setImageWithURL:[NSURL URLWithString:img] placeholderImage:placeHoderImage];
        _icon.hidden = NO;
        titleX = CGRectGetMaxX(_icon.frame) + 5;
        _money.text = @"+200";
        _title.text = @"转乐赚";
        
    }else
    {
        titleX = startX;
        _title.text = @"提现";
        _money.text = @"-200";
        _icon.hidden = YES;
    }
    _title.frame = CGRectMake(titleX,startY,200,titleH);
    CGFloat dateY = CGRectGetMaxY(_title.frame) + spaceBteweenTitle;
    _date.frame = CGRectMake(titleX,dateY,200,titleH);
    _date.text = @"2015-01-02";
    CGFloat moneyW = 100;
    CGFloat moneyX = kWidth - moneyW;
    CGFloat moneyY = dateY - 5;
    _money.frame = CGRectMake(moneyX,moneyY,moneyW,titleH);
    
    UIView *line = [[UIView alloc] initWithFrame:Rect(0, cellH - 0.5, kWidth, 0.5)];
    [self.contentView addSubview:line];
    line.backgroundColor = HexRGB(KCellLineColor);
    
    
}

-(void)setData:(flowRecordModel *)data
{
    _data = data;
    CGFloat startX = 15;
    CGFloat startY = 15;
    CGFloat imgHW = 50;
    CGFloat cellH = startX * 2 + imgHW;
    CGFloat spaceBteweenTitle = 8;
    CGFloat titleH = (imgHW - spaceBteweenTitle)/2;
    
    CGFloat titleX;
    //收入是1
    if ([data.direction intValue] == KRecordIn) {
        //收入
        _icon.frame  = CGRectMake(startX,startY,imgHW,imgHW);
        [self.contentView addSubview:_icon];
        NSString *img = [SystemConfig sharedInstance].user.avatar == nil ? @"default": [SystemConfig sharedInstance].user.avatar;
        [_icon setImageWithURL:[NSURL URLWithString:img] placeholderImage:placeHoderImage];
        _icon.hidden = NO;
        titleX = CGRectGetMaxX(_icon.frame) + 5;
        _money.text = [NSString stringWithFormat:@"+%@",data.money];
        _title.text = @"转乐赚";
        
    }else
    {
        titleX = startX;
        _title.text = @"提现";
        _money.text = [NSString stringWithFormat:@"%@",data.money];
        _icon.hidden = YES;
    }
    _title.frame = CGRectMake(titleX,startY,200,titleH);
    CGFloat dateY = CGRectGetMaxY(_title.frame) + spaceBteweenTitle;
    _date.frame = CGRectMake(titleX,dateY,200,titleH);
    _date.text = [NSString stringWithFormat:@"%@",[Tool getShortTimeFrom:data.time]];
    CGFloat moneyW = 100;
    CGFloat moneyX = kWidth - moneyW + 30;
    CGFloat moneyY = dateY - 5;
    _money.frame = CGRectMake(moneyX,moneyY,moneyW,titleH);
    
    UIView *line = [[UIView alloc] initWithFrame:Rect(0, cellH - 0.5, kWidth, 0.5)];
    [self.contentView addSubview:line];
    line.backgroundColor = HexRGB(KCellLineColor);
}
@end

//
//  EditBuyCarCell.m
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "EditBuyCarCell.h"

@implementation EditBuyCarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        CGFloat startXY = 20;
        CGFloat imgWH = 60;
        CGFloat bottomSpace = 30;
        
        UIView *backGround = [[UIView alloc] initWithFrame:Rect(0, 0, kWidth, 146)];
        [self.contentView addSubview:backGround];
        backGround.backgroundColor = [UIColor whiteColor];
        //1 check box
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backGround addSubview:checkBtn];
        [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [checkBtn setImage:[UIImage imageNamed:@"check_selected"] forState:UIControlStateSelected];
        CGFloat checkWH = 25;
        CGFloat checkY = startXY + (imgWH - checkWH)/2;
        checkBtn.frame  =  Rect(startXY, checkY, checkWH, checkWH);
        [checkBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectedBtn = checkBtn;
        
        //2 img
        CGFloat iconX = CGRectGetMaxX(checkBtn.frame) + startXY;
        UIImageView *icon  = [[UIImageView alloc] initWithFrame:Rect(iconX, startXY, imgWH, imgWH)];
        [backGround addSubview:icon];
        _img = icon;
        icon.backgroundColor  = [UIColor clearColor];
        
        //3 title
        CGFloat titleX = CGRectGetMaxX(icon.frame) + 5;
        CGFloat space = 2;
        CGFloat titleH = (imgWH - space)/3;
        UILabel *title = [[UILabel alloc] initWithFrame:Rect(titleX, startXY, 100, titleH)];
        [backGround addSubview:title];
        _title  = title;
        title.textColor = HexRGB(0x000000);
        title.font = [UIFont systemFontOfSize:18.0];
        title.text = @"标题";
        //4 now price
        UILabel *newPrice = [[UILabel alloc] initWithFrame:Rect(titleX, CGRectGetMaxY(title.frame) + space, 100, titleH)];
        [backGround addSubview:newPrice];
        _newprice  = newPrice;
        newPrice.text = @"¥ 108";
        newPrice.textColor = HexRGB(0xff7c70);
        newPrice.font = [UIFont systemFontOfSize:18.0];
        //5 old price
        UILabel *oldPrice = [[UILabel alloc] initWithFrame:Rect(titleX, CGRectGetMaxY(newPrice.frame) + space, 100, titleH)];
        [backGround addSubview:oldPrice];
        _oldPrice  = oldPrice;
        oldPrice.textColor = HexRGB(0x808080);
        oldPrice.font = [UIFont systemFontOfSize:14.0];
        oldPrice.text = @"660";
        //6 line
        CGFloat lineXX = startXY - 5;
        UIView *line = [[UIView alloc] initWithFrame:Rect(lineXX, CGRectGetMaxY(icon.frame) + startXY, kWidth - lineXX * 2, 1)];
        [backGround addSubview:line];
        line.backgroundColor = [UIColor grayColor];
        
        //7 total price
        CGFloat totalLBW = 120;
        CGFloat actualW  = 80;
        CGFloat actuaY = CGRectGetMaxY(line.frame) + bottomSpace/3;
        CGFloat add = 60;
        UILabel *actual = [[UILabel alloc] initWithFrame:Rect(kWidth + add*1.5 - totalLBW - actualW, actuaY, actualW, 25)];
        [backGround addSubview:actual];
        actual.text = @"实付：";
        actual.font = [UIFont systemFontOfSize:15.0];
        actual.textColor = HexRGB(0x808080);
        
        UILabel *totalNum = [[UILabel alloc] initWithFrame:Rect(actual.frame.origin.x - 150, actuaY, 100, 25)];
        [backGround addSubview:totalNum];
        totalNum.text = @"共1件";
        totalNum.font = [UIFont systemFontOfSize:15.0];
        totalNum.textColor = HexRGB(0x808080);
        
        
        UILabel *total = [[UILabel alloc] initWithFrame:Rect(kWidth + add - totalLBW, actuaY, totalLBW, 25)];
        [backGround addSubview:total];
        _totla = total;
        total.font = [UIFont systemFontOfSize:15.0];
        total.textColor = HexRGB(0x000000);
        total.text = @"¥ 108";
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:Rect(0, CGRectGetMaxY(total.frame) + 10, kWidth, 1)];
        [backGround addSubview:bottomLine];
        bottomLine.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}


-(void)checkBtnClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

@end

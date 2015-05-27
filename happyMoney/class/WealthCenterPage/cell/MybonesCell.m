//
//  MybonesCell.m
//  happyMoney
//
//  Created by promo on 15-5-12.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MybonesCell.h"
#import "MyboneData.h"

@implementation MybonesCell
{
    UILabel *_title;
    UILabel *_date;
    UILabel *_money;
    UILabel *_overDate;
    UIView *_rightView;
    BOOL isOverDate;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = HexRGB(0xeeeeee);
        
        CGFloat startX = 10;
        CGFloat backW = kWidth - startX * 2;
        CGFloat cellH = 80;
        CGFloat cellSpace = 10;
        CGFloat backH = cellH - cellSpace;
        
        UIView *back = [[UIView alloc] initWithFrame:Rect(startX, 0, backW, backH)];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 5.0;
        [self.contentView addSubview:back];
        
        CGFloat bagWH = backH - startX * 2;
        UIImageView *bagImg = [[UIImageView alloc] initWithFrame:CGRectMake(startX, startX,bagWH,bagWH)];
        bagImg.image = [UIImage imageNamed:@"bones"];
        [back addSubview:bagImg];
        bagImg.backgroundColor = [UIColor clearColor];
        
        CGFloat rightW = 80;
        
        CGFloat titleSpace = 10;
        CGFloat upAndDown = 8;
        CGFloat titleH = (bagWH - titleSpace - upAndDown * 2) / 2;
        CGFloat titleX = CGRectGetMaxX(bagImg.frame) + startX;
        
        CGFloat titleY = startX + upAndDown;
        CGFloat titleW = backW - titleX - rightW;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX,titleY,titleW,titleH)];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:PxFont(Font24)];
        title.textColor = HexRGB(0x3a3a3a);
        [back addSubview:title];
        title.text = @"面膜世家";
        _title = title;
        
        
        UILabel *useDate  = [[UILabel alloc] initWithFrame:CGRectMake(titleX,CGRectGetMaxY(title.frame) + titleSpace,titleW,titleH)];
        useDate.backgroundColor = [UIColor clearColor];
        useDate.font = [UIFont systemFontOfSize:PxFont(18.0)];
        useDate.textColor = HexRGB(0x666666);
        [back addSubview:useDate];
        useDate.text = @"使用期限2015.1.22-2015.2.22";
        _date = useDate;
        
        UIView *rightView = [[UIView alloc] initWithFrame:Rect(backW - rightW, 0, rightW, backH)];
        [back addSubview:rightView];
        rightView.backgroundColor = HexRGB(0xeae554);
        _rightView = rightView;
        

        UILabel *money = [[UILabel alloc] initWithFrame:CGRectZero];
        money.backgroundColor = [UIColor clearColor];
        money.font = [UIFont boldSystemFontOfSize:PxFont(35.0)];
        money.textColor = HexRGB(0xf84034);
        [rightView addSubview:money];
        money.text = @"¥ 100";
        _money = money;
        
        UILabel *overDate = [[UILabel alloc] initWithFrame:CGRectZero];
        overDate.textColor = [UIColor blackColor];
        [_rightView addSubview:overDate];
        overDate.text = @"(已过期)";
        overDate.font = [UIFont systemFontOfSize:PxFont(Font18)];
        _overDate = overDate;
    }
    return self;
}

-(void)setData:(MyboneData *)data
{
    _data = data;
    
    CGFloat cellH = 80;
    CGFloat cellSpace = 10;
    CGFloat backH = cellH - cellSpace;
    
    CGFloat moneyX = 5;
    CGFloat rightW = 80;
    CGFloat moneyW = rightW - moneyX;
    CGFloat moneyH = 30;
    CGFloat moneyY = (backH - moneyH) / 2;
    
   CGRect moenyRect = CGRectMake(moneyX,moneyY,moneyW,moneyH);
    
    if (isOverDate) {
        
        moenyRect.origin.y -= 10;
        _money.frame = moenyRect;
        _money.textColor = [UIColor whiteColor];
        CGFloat xx = 9;
        
        _overDate.frame = Rect(moenyRect.origin.x + xx, CGRectGetMaxY(_money.frame), 60, 20);
        _overDate.hidden = NO;
    }else
    {
        moenyRect = CGRectMake(moneyX,moneyY,moneyW,moneyH);
        _money.frame = moenyRect;
        _rightView.backgroundColor = HexRGB(0xeae554);
        _overDate.hidden = YES;
    }
}

- (void)setBoneType:(BonesType )boneType
{
    if (boneType == KBonesNow) {
        isOverDate = NO;
    }else
    {
        isOverDate = YES;
    }
}
@end

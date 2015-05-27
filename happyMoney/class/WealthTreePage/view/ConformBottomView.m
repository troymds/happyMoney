//
//  ConformBottomView.m
//  happyMoney
//  确认支付下面导航条
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ConformBottomView.h"
#import "ProductDetailModel.h"

@implementation ConformBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat startX = kWidth / 4 - 20;
        CGFloat startY = 10;
        
        UILabel *total = [[UILabel alloc] initWithFrame:Rect(startX, startY, 60, 30)];
        [self addSubview:total];
        total.text = @"总计：";
        total.textColor = HexRGB(0x808080);
        total.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
        
        UILabel *price = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(total.frame), startY, 80, 30)];
        [self addSubview:price];
        price.text = @"¥ 495";
        price.textColor = HexRGB(0x3a3a3a);
        price.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
        _price = price;
        
        CGFloat confromW = 100;
        UIButton *confrmoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:confrmoBtn];
        confrmoBtn.layer.masksToBounds  = YES;
        confrmoBtn.layer.cornerRadius = 5.0;
        confrmoBtn.frame = Rect(kWidth - 15 - confromW, startY, confromW, 30);
        [confrmoBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        confrmoBtn.backgroundColor  = HexRGB(0x1c9c28);
        _conformBtn = confrmoBtn;
    }
    return self;
}

-(void)setData:(ProductDetailModel *)data
{
    _data = data;
    CGFloat price = [data.price floatValue] * data.productCount;
    _price.text = [NSString stringWithFormat:@"¥ %.1f",price];
}

-(void)setTotalPrice:(CGFloat)totalPrice
{
    _price.text = [NSString stringWithFormat:@"¥ %.1f",totalPrice];
}
@end

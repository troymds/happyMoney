//
//  ConformProductItemView.m
//  happyMoney
//  确认订单中的订单view
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ConformProductItemView.h"
#import "ProductDetailModel.h"

@implementation ConformProductItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat startX = 10;
        CGFloat iconW = 80;
        CGFloat iconH = frame.size.height - startX * 2;
        // 1 icon
        _icon = [[UIImageView alloc] init];
        _icon.frame = Rect(startX, startX, iconW, iconH);
        [self addSubview:_icon];
        _icon.backgroundColor = [UIColor clearColor];
        
        // product name
        _productName = [[UILabel alloc] init];
        CGFloat priceX = frame.size.width - 70;
        
        [self addSubview:_productName];
        CGFloat productNameX = CGRectGetMaxX(_icon.frame) + 5;
        CGFloat productW = priceX - productNameX;
        CGFloat labelH = iconH/2;
        _productName.frame  = Rect(productNameX, startX, productW, labelH );
        _productName.font = [UIFont systemFontOfSize:PxFont(Font24)];
        _productName.textColor = HexRGB(0x3a3a3a);
        _productName.numberOfLines = 2;
        _productName.adjustsFontSizeToFitWidth = YES;
        // buy num
        
        _buyNum = [[UILabel alloc] init];
        [self addSubview:_buyNum];
        CGFloat buyNumY = CGRectGetMaxY(_productName.frame);
        _buyNum.frame  = Rect(productNameX, buyNumY, 100, labelH);
        [self addSubview:_buyNum];
        _buyNum.font = [UIFont systemFontOfSize:PxFont(Font24)];
        _buyNum.textColor = HexRGB(0x808080);
        
        // price
        _price= [[UILabel alloc] init];
        [self addSubview:_price];
        
        _price.frame  = Rect(priceX, startX, 100, labelH);
        _price.font = [UIFont systemFontOfSize:PxFont(Font24)];
        _price.textColor = HexRGB(0x808080);
        
        [self addSubview:_price];
        
        UIView *line = [[UIView alloc] init];
        line.frame = Rect(startX / 2, frame.size.height - 0.5, kWidth - startX, 0.5);
        line.backgroundColor = HexRGB(KCellLineColor);
        [self addSubview:line];
        
    }
    return self;
}

-(void)setData:(ProductDetailModel *)data
{
    
    _productName.text  = data.name;
    _buyNum.text  = [NSString stringWithFormat:@"购买量：%d",data.productCount];
    _price.text  = [NSString stringWithFormat:@"¥ %@",data.price];
    [_icon setImageWithURL:[NSURL URLWithString:data.image] placeholderImage:[UIImage imageNamed:@""]];
}
@end

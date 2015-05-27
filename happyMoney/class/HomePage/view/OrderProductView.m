//
//  OrderProductView.m
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderProductView.h"
#import "OrderListProduct.h"
#import "UIImageView+WebCache.h"
#import "OrderDetailModel.h"

@implementation OrderProductView
{
    UIView *_line;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_icon];
        CGFloat leftDistence = 10;
        CGFloat imgW = 80;
        CGFloat imgH = 80;
        _icon.frame = Rect(leftDistence, leftDistence, imgW, imgH);
        _icon.backgroundColor = [UIColor clearColor];
        
        //2 product name
        _productName = [[UILabel alloc] init];
        [self addSubview:_productName];
        CGFloat productNameX = CGRectGetMaxX(_icon.frame) + 5;
        CGFloat space = 5;
        CGFloat labelH = (imgH - space)/2;
        _productName.frame  = Rect(productNameX, leftDistence, 100, labelH);
//        _productName.text  = @"面膜世家";
        _productName.textColor = HexRGB(0x3a3a3a);
        _productName.font = [UIFont systemFontOfSize:PxFont(Font24)];
        
        //3 product price
        _price = [[UILabel alloc] init];
        [self addSubview:_price];
        CGFloat priceY = leftDistence;
        CGFloat priceW = 80;
        CGFloat priceX = kWidth - 10 - priceW + 40;
        _price.frame  = Rect(priceX, priceY, priceW, labelH);
//        _price.text  = @"¥ 699";
        _price.textColor = HexRGB(0x808080);
        _price.font = [UIFont systemFontOfSize:PxFont(Font22)];
        //4 product saleNum
        _saleNum = [[UILabel alloc] init];
        [self addSubview:_saleNum];
        CGFloat saley = CGRectGetMaxY(_productName.frame) + space;
        _saleNum.frame  = Rect(productNameX, saley, 100, labelH);
//        _saleNum.text  = @"销售量：500";
        _saleNum.textColor = HexRGB(0x808080);
        _saleNum.font = [UIFont systemFontOfSize:PxFont(Font22)];
        
//        CGFloat endLineY = CGRectGetMaxY(_icon.frame) + leftDistence;
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:line];
        line.backgroundColor = HexRGB(KCellLineColor);
        _line = line;
    }
    return self;
}

- (void)setData:(OrderListProduct *)data
{
    _data = data;
    
    _productName.text  = data.name;
    _price.text = [NSString stringWithFormat:@"¥ %@",data.price];
    _saleNum.text = data.num;
    [_icon setImageWithURL:[NSURL URLWithString:data.image] placeholderImage:placeHoderImage];
    _line.frame =  Rect(0, 100 - 0.5, kWidth, 0.5);
}

-(void)setDetailData:(OrderDetailModel *)detailData
{
    _detailData = detailData;
    OrderListProduct *data = [[OrderListProduct alloc] initWithDictionaryForGategory: detailData.products[_tagNum]];
        _productName.text  = data.name;
        _price.text = [NSString stringWithFormat:@"¥ %@",data.price];
        _saleNum.text = [NSString stringWithFormat:@"购买量:%ld",(long)[data.num integerValue]] ;
    [_icon setImageWithURL:[NSURL URLWithString:data.image] placeholderImage:placeHoderImage];
    _line.frame =  Rect(0, 100 - 0.5, kWidth, 0.5);
}
@end
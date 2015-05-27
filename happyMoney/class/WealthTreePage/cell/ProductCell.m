//
//  ProductCell.m
//  happyMoney
//  产品cell
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ProductCell.h"
#import "Product.h"
#import "UIButton+WebCache.h"

@implementation ProductCell
{
    CGFloat _cellH;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = HexRGB(0xeeeeee);
        
        //1 product img
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_icon];
        _icon.contentMode = UIViewContentModeScaleToFill;
        _icon.backgroundColor = [UIColor clearColor];
        //2 product name
        _productName = [[UILabel alloc] init];
        [self.contentView addSubview:_productName];
        _productName.text  = @"面膜世家";
        _productName.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
        _productName.textColor = HexRGB(0x3a3a3a);
        _productName.backgroundColor = [UIColor clearColor];
        
        //3 product price
        _price = [[UILabel alloc] init];
        [self.contentView addSubview:_price];
        _price.text = @"¥ 566";
        _price.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _price.textColor = HexRGB(0x808080);
        _price.backgroundColor  = [UIColor clearColor];
        
        //4 product saleNum
        _saleNum = [[UILabel alloc] init];
        [self.contentView addSubview:_saleNum];
        _saleNum.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _saleNum.textColor = HexRGB(0x808080);
        _saleNum.text = @"900";
        _saleNum.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setData:(Product *)data
{
    CGFloat leftDistence = 10;
    CGFloat imgW = 80;
    CGFloat imgH = 0;
//    CGFloat cellH = 80;
    _cellH = 80;
//    
//    __block CGFloat imgWHR = 0;
//    [self.icon setImageWithURL:[NSURL URLWithString:data.image] placeholderImage:[UIImage imageNamed:@"user_default"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        CGFloat h = image.size.height;
//        CGFloat w = image.size.width;
//        imgWHR = image.size.width/image.size.height;
//    }];
    [self.icon setImageWithURL:[NSURL URLWithString:data.image] placeholderImage:[UIImage imageNamed:@"user_default"]];
    
    imgH = imgW / 2;
    imgH = imgW ;
    _icon.frame = Rect(leftDistence, leftDistence, imgW, imgH);
    CGFloat space = 3;
    
    CGFloat productNameX = CGRectGetMaxX(_icon.frame) + 10;
    CGFloat labelH = (imgH - space)/3;
    _productName.frame  = Rect(productNameX, leftDistence, 100, labelH);
    
    CGFloat priceY = CGRectGetMaxY(_productName.frame) + space;
    _price.frame  = Rect(productNameX, priceY, 100, labelH);
    
    CGFloat saley = CGRectGetMaxY(_price.frame) +space;
    _saleNum.frame  = Rect(productNameX, saley, 100, labelH);
    
    CGFloat endLineY = CGRectGetMaxY(_icon.frame) + leftDistence;
    UIView *line = [[UIView alloc] initWithFrame:Rect(leftDistence, endLineY - 0.5, kWidth - leftDistence * 2, 0.5)];
    [self.contentView addSubview:line];
    line.backgroundColor = HexRGB(KCellLineColor);
    
    _cellH = endLineY;
    
    _icon.backgroundColor = [UIColor clearColor];
    _productName.text = data.name;
    _price.text = [NSString stringWithFormat:@"¥ %@",data.price];
    _saleNum.text = [NSString stringWithFormat:@"销售量：%@",data.sell_num];
    
}

-(CGFloat) getCellH
{
    return _cellH;
}
@end

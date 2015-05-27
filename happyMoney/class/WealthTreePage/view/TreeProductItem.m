//
//  TreeProductItem.m
//  happyMoney
//   财富树产品item
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "TreeProductItem.h"
#import "ProductButton.h"
#import "CategoryModel.h"
#import "UIImageView+WebCache.h"

#define space 9       //边距

@implementation TreeProductItem
{
    UIImageView *_imgview;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1 btn
        _findBtn = [ProductButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnH = frame.size.height - space * 2;
        CGFloat btnW = frame.size.width - space * 2;
        _findBtn.frame = CGRectMake(space, space+5, btnW, btnH);
        [self addSubview:_findBtn];
        
        // top line
        _topLine = [[UIView alloc] init];
        CGFloat bottomLineW = frame.size.width;
        CGFloat bottomLineH = 1;
        _topLine.frame = CGRectMake(0, 0, bottomLineW, bottomLineH);
        _topLine.backgroundColor =HexRGB(0xffffff);
        [self addSubview:_topLine];
        
        // right line
        _rightLine = [[UIView alloc] init];
        CGFloat rightLineW = 0.8;
        CGFloat rightLineH = frame.size.height;
        _rightLine.frame = CGRectMake(frame.size.width - rightLineW, 0, rightLineW, rightLineH);
        _rightLine.backgroundColor =HexRGB(0xffffff);
        [self addSubview:_rightLine];
        
        _imgview= [[UIImageView alloc] init];
        [self addSubview:_imgview];
        _imgview.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setData:(CategoryModel *)data
{
    _data = data;
    __weak ProductButton * productBtn = _findBtn;
    __weak UIImageView *imgview = _imgview;
    [_imgview setImageWithURL:[NSURL URLWithString:data.icon] placeholderImage:[UIImage imageNamed:@"find_fail.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [productBtn setImage:imgview.image forState:UIControlStateNormal];
    }];
    [_findBtn setTitle:data.name forState:UIControlStateNormal];
}

-(void)setImg
{
    [_findBtn setImage:_imgview.image forState:UIControlStateNormal];
}

@end

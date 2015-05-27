//
//  ProductButton.m
//  happyMoney
//  财富树产品按钮
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ProductButton.h"

// 图像高度占按钮的比例
#define kImagePercent 0.7

@implementation ProductButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置按钮的显示
        // 1. 设置文字的属性
        // 1）颜色
        [self setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
        // 2）文字对齐方式
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        // 3) 文字的字体
        [self.titleLabel setFont:[UIFont systemFontOfSize:PxFont(Font24)]];
        
        // 2. 设置图片的属性
        // 设置图片的等比例显示
//        self.imageView.backgroundColor = [UIColor redColor];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    return self;
}

#pragma mark 设置按钮文本的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageHeight = contentRect.size.height * kImagePercent;
    CGFloat height = contentRect.size.height - imageHeight;
    
    return CGRectMake(0, imageHeight, contentRect.size.width, height);
}

#pragma mark 设置按钮图像的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageHeight = contentRect.size.height * kImagePercent;
    
    return CGRectMake(0, 0, contentRect.size.width, imageHeight);
}
@end

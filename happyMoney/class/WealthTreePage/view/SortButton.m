//
//  SortButton.m
//  happyMoney
//
//  Created by promo on 15-4-17.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "SortButton.h"
// 文字的高度比例
#define kTitleRatio 0.5
#define KImgWH 30
#define KTitleW 40

@implementation SortButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = [UIColor whiteColor];
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font24)];
//        self.titleLabel.backgroundColor = [UIColor redColor];
        [self setTitleColor:HexRGB(0x3a3a3a) forState:UIControlStateNormal];
        [self setTitleColor:HexRGB(0x56b001) forState:UIControlStateHighlighted];
        // 3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        
        CGFloat iconX = frame.size.width - 20 - KImgWH;
        CGFloat iconY = (frame.size.height - KImgWH)/2;
        _icon = [[UIImageView alloc] initWithFrame:Rect(iconX, iconY, KImgWH, KImgWH)];
        [self addSubview:_icon];
    }
    return self;
}

// 销量是由高到低，价格是由低到高
- (void)setBtnTag:(NSInteger)btnTag
{
    _btnTag = btnTag;
    if (_btnTag == KSaleNum) {
        _icon.image = LOADPNGIMAGE(@"downArrow");
        _sortStatus = upTodown;
        
    }else
    {
        _icon.image = LOADPNGIMAGE(@"upArrow");
        _sortStatus = downToup;
    }
}

-(void) changeStatus
{
    if (_sortStatus == upTodown) {
        //上次是到低，点击后为到高
        _icon.image = LOADPNGIMAGE(@"upArrow");
        _sortStatus = downToup;
    }else
    {
        _icon.image = LOADPNGIMAGE(@"downArrow");
        _sortStatus = upTodown;
    }
    if ([self.delegate respondsToSelector:@selector(sort)]) {
        [self.delegate sort];
    }
    
}

#pragma mark 改变排序状态
-(void) changeArrowStatus
{
    if (_btnTag == KSaleNum) {
        //判断改变状态
        [self changeStatus];
    }else
    {
        [self changeStatus];
    }
    
}

#pragma mark 旋转剪头
-(void) rotateIcon;
{
//    _icon.transform = CGAffineTransformMakeRotation(M_PI);
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 0.3;
    rotationAnimation.RepeatCount = 1;//你可以设置到最大的整数值
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [_icon.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

#pragma mark 覆盖父类在highlighted时的所有操作
- (void)setHighlighted:(BOOL)highlighted {
    //    [super setHighlighted:highlighted];
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = (contentRect.size.width - KImgWH - KTitleW)/2;
    CGFloat imageY = (contentRect.size.height - KImgWH)/2;
    return CGRectMake(imageX, imageY, KImgWH, KImgWH);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = (contentRect.size.width - KImgWH - KTitleW)/2 + KImgWH;
    CGFloat titleY = (contentRect.size.height - KImgWH)/2;
    return CGRectMake(titleX, titleY, KTitleW, KImgWH);
}
@end

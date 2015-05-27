//
//  MDSBtn.m
//  happyMoney
//
//  Created by promo on 15-5-12.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MDSBtn.h"

@implementation MDSBtn
{
    UIView *_line;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.文字大小
//        self.titleLabel.font = [UIFont systemFontOfSize:PxFont(14)];
//        
//        [self setTitleColor:HexRGB(0x3a3a3a) forState:UIControlStateNormal];
//        [self setTitleColor:HexRGB(0x56b001) forState:UIControlStateSelected];
        // 3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //右侧的竖线
        UIView *line = [[UIView alloc] initWithFrame:Rect(frame.size.width - 1, 0, 1, frame.size.height)];
        line.backgroundColor = ButtonColor;
        _line = line;
        [self addSubview:line];
    }
    return self;
}

#pragma mark 覆盖父类在highlighted时的所有操作
- (void)setHighlighted:(BOOL)highlighted {
    //    [super setHighlighted:highlighted];
}

- (void)setNum:(NSInteger)num
{
    //如果是最后一个，则隐藏右侧的竖线
    if (self.tag == num - 1) {
        _line.hidden = YES;
    }
}
@end

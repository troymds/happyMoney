//
//  TGCenterLineLabel.m
//  团购
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "TGCenterLineLabel.h"

@implementation TGCenterLineLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.设置颜色
    [self.textColor setStroke];
    // 3.画线
    CGFloat y = rect.size.height * 0.5;
    CGContextMoveToPoint(ctx, 0, y);
    CGFloat endX = [self.text sizeWithFont:self.font].width;
    CGContextAddLineToPoint(ctx, endX, y);
    
    // 4.渲染
    CGContextStrokePath(ctx);
}
@end

//
//  ShadowView.m
//  Manicure
//
//  Created by tianj on 14-12-23.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HexRGB(0xffffff);
        
        UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
        
        self.layer.masksToBounds = NO;
        
        self.layer.shadowColor = HexRGB(0xc3c3c3).CGColor;
        
        self.layer.shadowOffset = CGSizeMake(1.0,1.0);
        
        self.layer.shadowOpacity = 0.6f;
        
        self.layer.shadowPath = shadowPath.CGPath;
        
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = HexRGB(0xe6e3e4).CGColor;

    }
    return self;
}

- (void)setShadow
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = HexRGB(0xc3c3c3).CGColor;
    
    self.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    self.layer.shadowOpacity = 0.6f;
    
    self.layer.shadowPath = shadowPath.CGPath;
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = HexRGB(0xe6e3e4).CGColor;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = HexRGB(0xc3c3c3).CGColor;
    
    self.layer.shadowOffset = CGSizeMake(1.0,1.0);
    
    self.layer.shadowOpacity = 0.6f;
    
    self.layer.shadowPath = shadowPath.CGPath;
    
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = HexRGB(0xe6e3e4).CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

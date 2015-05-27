//
//  MDSTextField.m
//  happyMoney
//
//  Created by promo on 15-3-30.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MDSTextField.h"
#import "ImageTextView.h"

@implementation MDSTextField


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark 初始化编辑框
- (id) initWithFrame:(CGRect)frame placeHold:(NSString *)placeHoldString leftImg:(NSString *)leftImg index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.placeholder = placeHoldString;
//        self.delegate = self;
//        self.borderStyle = UITextBorderStyleNone;
//        UIColor *color = [UIColor grayColor];
//        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHoldString attributes:@{NSForegroundColorAttributeName: color}];
        
        CGFloat startY = KMDSTextFieldY;
        CGFloat textW = frame.size.width;
        CGFloat textH = KMDSTextH;
//        CGFloat textH = 50;
        ImageTextView *text = [[ImageTextView alloc] initWithFrame:Rect(0, startY, textW, textH)];
        text.layer.masksToBounds = YES;
        text.imageView.image = [UIImage imageNamed:leftImg];
        text.textField.placeholder = placeHoldString;
        text.textField.tag = index;
//        text.textField.keyboardType = UIKeyboardTypeNumberPad;
        text.layer.cornerRadius = 4.0f;
        text.layer.borderWidth = 1.0f;
        text.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        [self addSubview:text];
        _imgField = text;
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame placeHold:(NSString *)placeHoldString index:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat startY = KMDSTextFieldY;
        CGFloat textW = frame.size.width;
        CGFloat textH = KMDSTextH;
        ImageTextView *text = [[ImageTextView alloc] initWithFrame:Rect(0, startY, textW, textH)];
        text.layer.masksToBounds = YES;
        //    text.imageView.image = [UIImage imageNamed:leftImg];
        text.textField.placeholder = placeHoldString;
        text.textField.keyboardType = UIKeyboardTypeNumberPad;
        text.layer.cornerRadius = 4.0f;
        text.layer.borderWidth = 1.0f;
        text.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        [self addSubview:text];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame placeHold:(NSString *)placeHoldString leftImg:(NSString *)leftImg index:(NSInteger)index hasLeftImg:(BOOL )hasLeftImg
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.placeholder = placeHoldString;
        //        self.delegate = self;
        //        self.borderStyle = UITextBorderStyleNone;
        //        UIColor *color = [UIColor grayColor];
        //        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHoldString attributes:@{NSForegroundColorAttributeName: color}];
        
        CGFloat startY = KMDSTextFieldY;
        CGFloat textW = frame.size.width;
        CGFloat textH = KMDSTextH;
        ImageTextView *text = [[ImageTextView alloc] initWithFrame:Rect(0, startY, textW, textH) hasLeftImg:hasLeftImg];
        text.layer.masksToBounds = YES;
        text.imageView.image = [UIImage imageNamed:leftImg];
        text.textField.placeholder = placeHoldString;
        text.textField.tag = index;
        //        text.textField.keyboardType = UIKeyboardTypeNumberPad;
        text.layer.cornerRadius = 4.0f;
        text.layer.borderWidth = 1.0f;
        text.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        [self addSubview:text];
        _imgField = text;
    }
    return self;
}
@end

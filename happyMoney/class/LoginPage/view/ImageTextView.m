//
//  ImageTextView.m
//  Manicure
//
//  Created by tianj on 14-12-17.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import "ImageTextView.h"

@implementation ImageTextView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0f;
        self.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        self.layer.borderWidth = 1.0f;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.height,frame.size.height)];
        leftView.backgroundColor = HexRGB(0xdddada);
        [self addSubview:leftView];

        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _imageView.center = leftView.center;
        [leftView addSubview:_imageView];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 0, frame.size.width - 60,frame.size.height)];
        _textField.delegate = self;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self addSubview:_textField];
    }
    return self;
}

#pragma mark 左边分有图和没有图的情况
- (id)initWithFrame:(CGRect)frame hasLeftImg:(BOOL )has
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0f;
        self.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        self.layer.borderWidth = 1.0f;
        
        CGFloat leftW = 43;
        CGFloat textX;
        
        if (has) {
            UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,leftW,frame.size.height)];
            leftView.backgroundColor = HexRGB(0xdddada);
            [self addSubview:leftView];
            
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
            _imageView.center = leftView.center;
            [leftView addSubview:_imageView];
            textX = 60;
        }else
        {
            textX = 5;   
        }
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(textX, 0, frame.size.width-60,frame.size.height)];
        _textField.delegate = self;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self addSubview:_textField];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}

@end

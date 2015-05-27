//
//  MDSTextField.h
//  happyMoney
//  编辑框
//  Created by promo on 15-3-30.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KMDSTextFieldY  5
#define KMDSTextH 40

@class ImageTextView;

@interface MDSTextField : UIView
@property (nonatomic,strong) ImageTextView *imgField;

- (id) initWithFrame:(CGRect)frame placeHold:(NSString *)placeHoldString leftImg:(NSString *)leftImg index:(NSInteger)index;

- (id) initWithFrame:(CGRect)frame placeHold:(NSString *)placeHoldString index:(NSInteger)index;

- (id) initWithFrame:(CGRect)frame placeHold:(NSString *)placeHoldString leftImg:(NSString *)leftImg index:(NSInteger)index hasLeftImg:(BOOL )hasLeftImg;
@end

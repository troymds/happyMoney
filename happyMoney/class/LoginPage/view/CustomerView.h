//
//  CustomerView.h
//  Manicure
//
//  Created by tianj on 14-12-11.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTextView.h"


#define loseTag 1999
#define registerTag 2000
#define loginTag 2001

@class CustomerView;
@protocol CustomerViewDelegate <NSObject>

@optional

- (void)customerBtnClick:(UIButton *)btn view:(CustomerView *)view;

@end

@interface CustomerView : UIView

@property (nonatomic,strong) ImageTextView *accountView;
@property (nonatomic,strong) ImageTextView *passWordView;
@property (nonatomic,weak) id<CustomerViewDelegate> delegate;

@end

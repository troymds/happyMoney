//
//  ConformBottomView.h
//  happyMoney
//
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailModel;

@interface ConformBottomView : UIView
@property (nonatomic,strong) UIButton *conformBtn;
@property (nonatomic,strong) UILabel *price;
@property (nonatomic,assign) CGFloat totalPrice;
@property (nonatomic,strong) ProductDetailModel *data;
@end

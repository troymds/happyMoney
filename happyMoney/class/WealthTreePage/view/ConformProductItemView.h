//
//  ConformProductItemView.h
//  happyMoney
//
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductDetailModel;

@interface ConformProductItemView : UIView
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *productName;
@property (nonatomic,strong) UILabel *price;
@property (nonatomic,strong) UILabel *buyNum;
@property (nonatomic,strong) ProductDetailModel *data;
@end

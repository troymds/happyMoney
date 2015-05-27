//
//  OrderProductView.h
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderListProduct;
@class OrderDetailModel;

@interface OrderProductView : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *saleNum;
@property (nonatomic, assign) int tagNum;
@property (nonatomic,strong) OrderListProduct *data;
@property (nonatomic,strong) OrderDetailModel *detailData;
@end

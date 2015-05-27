//
//  ConformOrderController.h
//  happyMoney
//
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//
#import "HMBaseController.h"
#import <UIKit/UIKit.h>
@class ProductDetailModel;
@class DefaultAddressModel;

typedef enum {
   kziti = 0,
   kwuliu
}btnStyle;

@interface ConformOrderController : HMBaseController
@property (nonatomic,strong) ProductDetailModel *data;
@property (nonatomic,strong) DefaultAddressModel *address;
@property (nonatomic, strong) NSArray *OrderDataList;
@end

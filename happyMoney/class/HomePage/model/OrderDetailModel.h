//
//  OrderDetailModel.h
//  happyMoney
//
//  Created by promo on 15-5-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderListAddressModel;
@class OrderListProduct;
@class Coupon;

@interface OrderDetailModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *order_price;
@property (nonatomic,copy) NSString *post_time;
@property (nonatomic,copy) NSString *real_pay;
@property (nonatomic,copy) NSString *express;
@property (nonatomic,copy) NSString *pay_method;
@property (nonatomic,copy) NSString *address_id;
@property (nonatomic,copy) NSString *coupon_id;
@property (nonatomic,copy) NSString *total_num;
@property (nonatomic,copy) NSDictionary *address;
@property (nonatomic,copy) NSArray *products;
@property (nonatomic,copy) Coupon *coupon;

- (id)initWithDictionary:(NSDictionary *)dic;
@end

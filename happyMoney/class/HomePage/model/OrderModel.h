//
//  OrderModel.h
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderListAddressModel;
@class OrderListProduct;

@interface OrderModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *order_price;
@property (nonatomic,copy) NSString *post_time;
@property (nonatomic,copy) NSString *real_pay;
@property (nonatomic,copy) NSString *express;
@property (nonatomic,copy) NSString *address_id;
@property (nonatomic,copy) NSDictionary *address;
@property (nonatomic,copy) NSArray *products;
@property (nonatomic,copy) NSString *agent_address;
@property (nonatomic,copy) NSString *agent_phone;
- (id)initWithDictionary:(NSDictionary *)dic;
@end

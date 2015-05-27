//
//  OrderListModel.h
//  happyMoney
//
//  Created by promo on 15-5-4.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderListAddressModel;
@class OrderListProduct;

@interface OrderListModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *order_price;
@property (nonatomic,copy) NSString *post_time;
@property (nonatomic,copy) NSString *real_pay;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *address_id;
@property (nonatomic,copy) OrderListAddressModel *address;
@property (nonatomic,copy) OrderListProduct *products;
- (id)initWithDictionary:(NSDictionary *)dic;
@end

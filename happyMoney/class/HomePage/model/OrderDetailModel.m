//
//  OrderDetailModel.m
//  happyMoney
//
//  Created by promo on 15-5-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel

- (id)initWithDictionary:(NSDictionary *)dic;
{
    if (self = [super init]) {
        
        self.ID = [dic objectForKey:@"id"];
        self.uid = [dic objectForKey:@"uid"];
        self.status = [dic objectForKey:@"status"];
        self.order_price = [dic objectForKey:@"order_price"];
        self.post_time = [dic objectForKey:@"post_time"];
        self.real_pay = [dic objectForKey:@"real_pay"];
        self.express = [dic objectForKey:@"express"];
        self.address_id = [dic objectForKey:@"address_id"];
        self.address = [dic objectForKey:@"address"];
        self.products = [dic objectForKey:@"products"];
        self.pay_method = [dic objectForKey:@"pay_method"];
        self.total_num = [dic objectForKey:@"total_num"];
        self.coupon_id = [dic objectForKey:@"coupon_id"];
    }
    return self;
}

@end

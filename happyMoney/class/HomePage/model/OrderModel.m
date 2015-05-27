//
//  OrderModel.m
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
- (id)initWithDictionary:(NSDictionary *)dic;
{
    if (self = [super init]) {
        
        self.ID = [dic objectForKey:@"id"];
        self.status = [dic objectForKey:@"status"];
        self.order_price = [dic objectForKey:@"order_price"];
        self.post_time = [dic objectForKey:@"post_time"];
        self.real_pay = [dic objectForKey:@"real_pay"];
        self.express = [dic objectForKey:@"express"];
        self.address_id = [dic objectForKey:@"address_id"];
        self.address = [dic objectForKey:@"address"];
        self.products = [dic objectForKey:@"products"];
        self.agent_address = [dic objectForKey:@"agent_address"];
        self.agent_phone = [dic objectForKey:@"agent_phone"];
    }
    return self;
}
@end

//
//  OrderListModel.m
//  happyMoney
//  订单列表model
//  Created by promo on 15-5-4.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderListModel.h"

@implementation OrderListModel

- (id)initWithDictionary:(NSDictionary *)dic;
{
    if (self = [super init]) {
        
        self.ID = [dic objectForKey:@"ID"];
        self.status = [dic objectForKey:@"status"];
        self.order_price = [dic objectForKey:@"order_price"];
        self.post_time = [dic objectForKey:@"post_time"];
        self.real_pay = [dic objectForKey:@"real_pay"];
        self.type = [dic objectForKey:@"type"];
        self.address_id = [dic objectForKey:@"address_id"];
        self.address = [dic objectForKey:@"address"];
        self.products = [dic objectForKey:@"products"];
    }
    return self;
}
@end

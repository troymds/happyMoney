//
//  OrderListAddressModel.m
//  happyMoney
//
//  Created by promo on 15-5-4.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderListAddressModel.h"

@implementation OrderListAddressModel

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.contact = dict[@"contact"];
        self.address = dict[@"address"];
        self.phone_num = dict[@"phone_num"];
    }
    return self;
}
@end

//
//  DefaultAddressModel.m
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "DefaultAddressModel.h"

@implementation DefaultAddressModel

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.uid = dict[@"uid"];
        self.contact = dict[@"contact"];
        self.address = dict[@"address"];
        self.phone_num = dict[@"phone_num"];
    }
    return self;
}
@end

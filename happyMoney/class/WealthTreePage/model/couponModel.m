//
//  couponModel.m
//  happyMoney
//  优惠券
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "couponModel.h"

@implementation couponModel

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.uid = dict[@"uid"];
        self.title = dict[@"title"];
        self.value = dict[@"value"];
        self.is_delete = dict[@"is_delete"];
        self.is_used = dict[@"is_used"];
        self.over_date = dict[@"over_date"];
    }
    return self;
}
@end

//
//  Coupon.m
//  happyMoney
//
//  Created by promo on 15-5-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "Coupon.h"

@implementation Coupon
- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict
{
    if ([super self])
    {
        self.title = dict[@"title"];
        self.ID = dict[@"id"];
    }
    
    return self;
}
@end

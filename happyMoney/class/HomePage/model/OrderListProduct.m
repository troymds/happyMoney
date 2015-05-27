//
//  OrderListProduct.m
//  happyMoney
//
//  Created by promo on 15-5-4.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderListProduct.h"

@implementation OrderListProduct
- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict{
    if ([super self])
    {
        self.image = dict[@"image"];
        self.name = dict[@"name"];
        self.ID = dict[@"id"];
        self.price = dict[@"price"];
        self.num = dict[@"num"];
    }
    
    return self;
}
@end

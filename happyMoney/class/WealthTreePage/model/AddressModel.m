//
//  AddressModel.m
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

- (instancetype) initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        self.name =dic[@"name"];
        self.phone =dic[@"id"];
        self.address = dic[@""];
    }
    return self;
}

@end

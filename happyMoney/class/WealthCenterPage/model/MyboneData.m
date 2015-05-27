//
//  MyboneData.m
//  happyMoney
//
//  Created by promo on 15-5-12.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MyboneData.h"

@implementation MyboneData

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict{
    if ([super self])
    {
        self.title = dict[@"icon"];
        self.date = dict[@"name"];
    }
    
    return self;
}

@end

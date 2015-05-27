//
//  CategoryModel.m
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
- (instancetype) initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        self.name =dic[@"name"];
        self.icon =dic[@"icon"];
        self.ID = dic[@"id"];
    }
    return self;
}

@end

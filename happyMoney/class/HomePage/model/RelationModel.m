//
//  RelationModel.m
//  happyMoney
//
//  Created by promo on 15-4-14.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "RelationModel.h"

@implementation RelationModel

- (id)initWithDictionary:(NSDictionary *)dic;
{
    if (self = [super init]) {
        
        self.first_num = [dic objectForKey:@"first_num"];
        self.second_num = [dic objectForKey:@"second_num"];
        self.profit = [dic objectForKey:@"profit"];
        if ([self.profit isKindOfClass:[NSNull class]]) {
            self.profit = @"0";
        }
    }
    return self;
}
@end

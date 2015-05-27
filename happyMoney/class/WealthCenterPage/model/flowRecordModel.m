//
//  flowRecordModel.m
//  happyMoney
//
//  Created by promo on 15-5-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "flowRecordModel.h"

@implementation flowRecordModel

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict
{
    if ([super self])
    {
        self.ID = dict[@"id"];
        self.uid = dict[@"uid"];
        self.direction = dict[@"direction"];
        self.time = dict[@"time"];
        self.order_id = dict[@"order_id"];
        self.money = dict[@"money"];
        self.status = dict[@"status"];
    }
    
    return self;
}
@end

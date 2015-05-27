//
//  TreeProductModel.m
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "TreeProductModel.h"

@implementation TreeProductModel

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict{
    if ([super self])
    {
        self.imageName = dict[@"icon"];
        self.name = dict[@"name"];
    }
    
    return self;
}
@end

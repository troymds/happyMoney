//
//  AdsItem.m
//  happyMoney
//
//  Created by promo on 15-4-14.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "AdsItem.h"

@implementation AdsItem

- (id)initWithDictionary:(NSDictionary *)dic;
{
    if (self = [super init]) {
        self.ID = [dic objectForKey:@"id"];
        self.imgUrl = [dic objectForKey:@"image"];
        self.link = [dic objectForKey:@"link"];
    }
    return self;
}
@end

//
//  ProductDetailModel.m
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.image = dict[@"image"];
        self.name = dict[@"name"];
        self.ID = dict[@"id"];
        self.price = dict[@"price"];
        self.old_price = dict[@"old_price"];
        self.view_num = dict[@"view_num"];
        self.sell_num = dict[@"sell_num"];
        self.Description = dict[@"description"];
        self.category_id = dict[@"category_id"];
        self.collection_id = dict[@"collection_id"];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_image forKey:@"_image"];
    [encoder encodeObject:_name forKey:@"_name"];
    [encoder encodeObject:_ID forKey:@"_ID"];
    [encoder encodeObject:_price forKey:@"_price"];
    [encoder encodeObject:_old_price forKey:@"_old_price"];
    [encoder encodeObject:_view_num forKey:@"_view_num"];
    [encoder encodeInt:_productCount forKey:@"_productCount"];
    [encoder encodeBool:_isChosen forKey:@"_isChosen"];
    [encoder encodeObject:_sell_num forKey:@"_sell_num"];
    [encoder encodeObject:_Description forKey:@"_Description"];
    [encoder encodeObject:_category_id forKey:@"_category_id"];
    [encoder encodeBool:_collection_id forKey:@"_collection_id"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.image = [decoder decodeObjectForKey:@"_image"];
        self.name = [decoder decodeObjectForKey:@"_name"];
        self.ID = [decoder decodeObjectForKey:@"_ID"];
        self.price = [decoder decodeObjectForKey:@"_price"];
        self.old_price = [decoder decodeObjectForKey:@"_old_price"];
        self.view_num = [decoder decodeObjectForKey:@"_view_num"];
        self.productCount = [decoder decodeIntForKey:@"_productCount"];
        self.isChosen = [decoder decodeBoolForKey:@"_isChosen"];
        self.sell_num = [decoder decodeObjectForKey:@"_sell_num"];
        self.Description = [decoder decodeObjectForKey:@"_Description"];
        self.category_id = [decoder decodeObjectForKey:@"_category_id"];
        self.collection_id = [decoder decodeObjectForKey:@"_collection_id"];
    }
    return self;
}

@end

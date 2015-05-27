//
//  Product.m
//  happyMoney
//  财富树产品model
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "Product.h"

@implementation Product
+ (id)productWithName:(NSString *)name productImage:(NSString*)image
{
    Product *p = [[Product alloc]init];
    [p setName:name];
    
    [p setImage:image];
    return p;
}

+ (id)productWithName:(NSString *)name
{
    Product *p = [[Product alloc]init];
    [p setName:name];
    return p;
}

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict{
    if ([super self])
    {
        self.image = dict[@"image"];
        self.name = dict[@"name"];
        self.ID = dict[@"id"];
        self.price = dict[@"price"];
        self.old_price = dict[@"old_price"];
        self.view_num = dict[@"view_num"];
        self.sell_num = dict[@"sell_num"];
    }
    
    return self;
}

@end

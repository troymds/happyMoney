//
//  OrderListProduct.h
//  happyMoney
//
//  Created by promo on 15-5-4.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListProduct : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *num;
@property (strong, nonatomic) NSString *ID;

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict;
@end

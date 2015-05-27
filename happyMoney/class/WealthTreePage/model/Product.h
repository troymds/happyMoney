//
//  Product.h
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
+ (id)productWithName:(NSString *)name productImage:(NSString*)image;
+ (id)productWithName:(NSString *)name;
- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *old_price;
@property (strong, nonatomic) NSString *view_num;
@property (strong, nonatomic) NSString *sell_num;
@property (strong, nonatomic) NSString *ID;
@end

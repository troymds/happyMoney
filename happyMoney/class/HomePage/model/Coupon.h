//
//  Coupon.h
//  happyMoney
//
//  Created by promo on 15-5-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coupon : NSObject
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *title;

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict;
@end

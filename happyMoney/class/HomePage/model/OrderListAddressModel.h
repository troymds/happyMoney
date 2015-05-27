//
//  OrderListAddressModel.h
//  happyMoney
//
//  Created by promo on 15-5-4.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListAddressModel : NSObject
@property (strong, nonatomic) NSString *contact;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *phone_num;
- (id)initWithDictionary:(NSDictionary *)dict;
@end

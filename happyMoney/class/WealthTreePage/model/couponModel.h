//
//  couponModel.h
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface couponModel : NSObject
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *is_delete;
@property (strong, nonatomic) NSString *is_used;
@property (strong, nonatomic) NSString *over_date;
- (id)initWithDictionary:(NSDictionary *)dict;
@end

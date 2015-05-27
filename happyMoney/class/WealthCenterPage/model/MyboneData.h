//
//  MyboneData.h
//  happyMoney
//
//  Created by promo on 15-5-12.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyboneData : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *date;
- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict;
@end

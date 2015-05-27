//
//  AdsItem.h
//  happyMoney
//
//  Created by promo on 15-4-14.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsItem : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *link;

- (id)initWithDictionary:(NSDictionary *)dic;
@end

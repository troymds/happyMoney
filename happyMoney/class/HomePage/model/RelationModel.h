//
//  RelationModel.h
//  happyMoney
//
//  Created by promo on 15-4-14.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RelationModel : NSObject
@property (nonatomic,copy) NSString *first_num;
@property (nonatomic,copy) NSString *second_num;
@property (nonatomic,copy) NSString *profit;

- (id)initWithDictionary:(NSDictionary *)dic;
@end

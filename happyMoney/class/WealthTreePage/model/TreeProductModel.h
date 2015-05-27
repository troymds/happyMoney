//
//  TreeProductModel.h
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeProductModel : NSObject
- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;
@end

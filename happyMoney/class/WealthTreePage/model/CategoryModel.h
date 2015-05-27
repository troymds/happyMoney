//
//  CategoryModel.h
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property (nonatomic,strong)NSString *name ;
@property (nonatomic,strong)NSString *icon ;
@property (nonatomic,strong)NSString *ID ;

- (instancetype) initWithDic:(NSDictionary *)dic;
@end

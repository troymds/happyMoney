//
//  AddressModel.h
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic,strong)NSString *name ;
@property (nonatomic,strong)NSString *phone ;
@property (nonatomic,strong)NSString *address ;

- (instancetype) initWithDic:(NSDictionary *)dic;
@end

//
//  UserItem.h
//  happyMoney
//
//  Created by promo on 15-4-17.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DefaultAddressModel;

@interface UserItem : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *invite_code;
@property (nonatomic,copy) NSString *grandpa_id;
@property (nonatomic,copy) NSString *root_id;
@property (nonatomic,copy) NSString *father_id;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *alipay;
- (id)initWithDic:(NSDictionary *)dict;
@end

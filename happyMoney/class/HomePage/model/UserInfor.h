//
//  UserInfor.h
//  happyMoney
//
//  Created by promo on 15-4-14.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfor : NSObject
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *invite_code;
@property (nonatomic,copy) NSString *father_id;
@property (nonatomic,copy) NSString *grandpa_id;
@property (nonatomic,copy) NSString *root_id;
@property (nonatomic,copy) NSString *avatar;
- (id)initWithDictionary:(NSDictionary *)dic;
@end

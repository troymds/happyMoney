//
//  UserItem.m
//  happyMoney
//
//  Created by promo on 15-4-17.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UserItem.h"

@implementation UserItem
- (id)initWithDic:(NSDictionary *)dict
{
    if ([super self])
    {
        self.userName = dict[@"username"];
        self.type = dict[@"type"];
        self.ID = dict[@"id"];
        self.avatar = dict[@"avatar"];
        self.invite_code = dict[@"invite_code"];
        self.grandpa_id = dict[@"grandpa_id"];
        self.root_id = dict[@"root_id"];
        self.father_id = dict[@"father_id"];
        self.address = dict[@"address"];
        self.alipay = dict[@"alipay"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.father_id forKey:@"father_id"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.root_id forKey:@"root_id"];
    [aCoder encodeObject:self.userName forKey:@"user_name"];
    [aCoder encodeObject:self.grandpa_id forKey:@"grandpa_id"];
    [aCoder encodeObject:self.invite_code forKey:@"invite_code"];
    [aCoder encodeObject:self.ID forKey:@"id"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.alipay forKey:@"alipay"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.father_id = [aDecoder decodeObjectForKey:@"father_id"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.root_id = [aDecoder decodeObjectForKey:@"root_id"];
        self.userName = [aDecoder decodeObjectForKey:@"user_name"];
        self.grandpa_id = [aDecoder decodeObjectForKey:@"grandpa_id"];
        self.invite_code = [aDecoder decodeObjectForKey:@"invite_code"];
        self.ID = [aDecoder decodeObjectForKey:@"id"];
        self.type = [aDecoder decodeObjectForKey:@"type"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.alipay = [aDecoder decodeObjectForKey:@"alipay"];
    }
    return self;
}

@end

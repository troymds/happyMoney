//
//  UserInfor.m
//  happyMoney
//
//  Created by promo on 15-4-14.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UserInfor.h"

@implementation UserInfor

- (id)initWithDictionary:(NSDictionary *)dic;
{
    if (self = [super init]) {
        self.username = [dic objectForKey:@"username"];
        self.type = [dic objectForKey:@"type"];
        self.invite_code = [dic objectForKey:@"invite_code"];
        self.father_id = [dic objectForKey:@"father_id"];
        self.grandpa_id = [dic objectForKey:@"grandpa_id"];
        self.root_id = [dic objectForKey:@"root_id"];
        self.avatar = [dic objectForKey:@"avatar"];
    }
    return self;
}
@end

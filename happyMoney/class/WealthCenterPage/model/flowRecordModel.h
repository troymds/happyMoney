//
//  flowRecordModel.h
//  happyMoney
//
//  Created by promo on 15-5-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface flowRecordModel : NSObject
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *direction;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *status;

- (instancetype)initWithDictionaryForGategory:(NSDictionary *)dict;
@end

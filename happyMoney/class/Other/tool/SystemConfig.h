//
//  SystemConfig.h
//  PEM
//
//  Created by tianj on 14-8-29.
//  Copyright (c) 2014年 ___普尔摩___. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserItem;
@class DefaultAddressModel;

@interface SystemConfig : NSObject
@property (nonatomic,strong) UserItem *user;
@property (nonatomic,copy) NSString *uuidStr;        //设备uuid
@property (nonatomic,assign) BOOL isUserLogin;       //是否登录
@property (nonatomic,assign) NSString * uid;       //用户uid
@property (nonatomic, assign) int userType;         //1 普通用户 ，2 商家
@property (nonatomic,assign) NSInteger selectedIndex;         //tap 将要选择的index
@property (nonatomic, assign) BOOL isFormConformOrder; //  是否从订单页面进入增加地址页面 
@property (nonatomic,strong) DefaultAddressModel *defaultAddress;
+ (SystemConfig *)sharedInstance;

@end

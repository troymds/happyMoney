//
//  Tool.h
//  Manicure
//
//  Created by tianj on 14-12-15.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

//根据颜色返回一张该颜色的图片
+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;

+ (UIButton *)getButtonWithFrame:(CGRect)rect title:(NSString *)title titleColor:(UIColor *)titleColor backgroundImg:(UIImage *)image delegate:(id)delegate action:(SEL)action;


+ (UIImage *)imageWithImage:(UIImage *)image;

//获取预约的某个时间块的时间
+ (NSString *)getBlockTime:(int)index;
//检查phone 号码
+ (BOOL)isValidPhoneNum:(NSString *)phoneNum;

+ (NSString *) getShortTimeFrom:(NSString *)string;
@end

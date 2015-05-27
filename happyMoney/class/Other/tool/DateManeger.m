//
//  DateManeger.m
//  PEM
//
//  Created by tianj on 14-8-29.
//  Copyright (c) 2014年 ___普尔摩___. All rights reserved.
//

#import "DateManeger.h"

@implementation DateManeger


// 返回当前时间戳 
+ (NSString *)getCurrentTimeStamps{
    
    NSDate *now = [NSDate date];
//    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
//    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
//    NSString *dateStr = [dateFormatter1 stringFromDate:now];
//    
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//
//    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSString *currentTime = [NSString stringWithFormat:@"%ld",(long)[now timeIntervalSince1970]];
    return currentTime;
}


@end

//
//  Tool.m
//  Manicure
//
//  Created by tianj on 14-12-15.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import "Tool.h"

@implementation Tool


+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context,rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

+ (UIButton *)getButtonWithFrame:(CGRect)rect title:(NSString *)title titleColor:(UIColor *)titleColor backgroundImg:(UIImage *)image delegate:(id)delegate action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:delegate action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


+ (UIImage *)imageWithImage:(UIImage *)image
{
    UIImage *newImage;
    UIGraphicsBeginImageContext(image.size);
    return newImage;
}

+ (NSString *)getBlockTime:(int)index
{
    NSArray *array = [NSArray arrayWithObjects:@"09:00~11:00",@"11:00~13:00",@"13:00~15:00",@"15:00~17:00",@"17:00~19:00",@"19:00~21:00", nil];
    return [array objectAtIndex:index];
}

+ (BOOL)isValidPhoneNum:(NSString *)phoneNum{
    NSString *phoneRegex  =  @"((0\\d{2,3}-\\d{7,8})|(^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNum];
}

+ (NSString *) getShortTimeFrom:(NSString *)string
{
    NSString *space = @" ";
    NSRange range = [string rangeOfString:space];
    NSString *returnStr = [string substringToIndex:range.location];
    return returnStr;
}
@end

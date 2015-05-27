//
//  NewBroadCastController.m
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "NewBroadCastController.h"
#import "AdaptationSize.h"

@interface NewBroadCastController ()

@end

@implementation NewBroadCastController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新公告";
    
    CGFloat startXY = 12;
    //1 back
    UIView *back = [[UIView alloc] initWithFrame:Rect(startXY, startXY, kWidth - startXY * 2, 300)];
    [self.view addSubview:back];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 8;
    back.layer.backgroundColor = [UIColor whiteColor].CGColor;
    
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    CGFloat titleW = 200;
    title.center = CGPointMake(back.frame.size.width/2, back.frame.size.height/2);
    title.frame =  Rect((back.frame.size.width - titleW)/2, startXY, 200, 25 );
    [back addSubview:title];
    title.text = @"收益规则变化";
    title.textColor = HexRGB(0x3a3a3a);
    title.font = [UIFont boldSystemFontOfSize:PxFont(Font36)];
    
    CGFloat dateX = 30;
    CGFloat dateY = CGRectGetMaxY(title.frame) + 5;
    UILabel *date = [[UILabel alloc] initWithFrame:Rect(dateX, dateY, 150, 20)];
    [back addSubview:date];
    date.text = @"发布时间：2015-1-7 ";
    date.textColor = HexRGB(0x808080);
    date.font = [UIFont boldSystemFontOfSize:PxFont(Font20)];
    
    CGFloat personX = CGRectGetMaxX(date.frame);
    UILabel *person = [[UILabel alloc] initWithFrame:Rect(personX, dateY, 120, 20)];
    [back addSubview:person];
    person.text = @"发布人：转乐赚 ";
    person.textColor = HexRGB(0x808080);
    person.font = [UIFont boldSystemFontOfSize:PxFont(Font20)];
    
    UIView *line = [[UIView alloc] initWithFrame:Rect(startXY + 2, CGRectGetMaxY(date.frame) + 5, back.frame.size.width - startXY * 2 + 2, 1)];
    [back addSubview:line];
    line.backgroundColor = [UIColor grayColor];
    
    CGFloat detailY = CGRectGetMaxY(line.frame) + startXY;
    NSString *str = @"    本人负责并参与开发过多款应用项目，对知识点具有良好的组织并能够熟练的使用编程工具。同时熟悉版本控制，具备扎实的编程基础和良好的编程习惯；自学能力较强；性格开朗，善于交流，易于沟通；为人老实忠厚，责任心强，能吃苦耐劳，能承受较强的工作压力";
    CGFloat detailH = [AdaptationSize getSizeFromString:str Font:[UIFont systemFontOfSize:PxFont(Font24)] withHight:CGFLOAT_MAX withWidth:line.frame.size.width].height;
    
    UILabel *detail = [[UILabel alloc] initWithFrame:Rect(startXY, detailY, line.frame.size.width, detailH)];
    [back addSubview:detail];
    detail.numberOfLines  = 0;
    detail.font = [UIFont systemFontOfSize:PxFont(Font24)];
    detail.textColor = HexRGB(0x666666);
    detail.text = str;
}


@end

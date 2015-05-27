//
//  MybonesCell.h
//  happyMoney
//
//  Created by promo on 15-5-12.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyboneData;

typedef enum
{
    KBonesNow,//当前
    KBonesHistory
} BonesType;

@interface MybonesCell : UITableViewCell
@property (nonatomic,strong) MyboneData *data;
@property (nonatomic,assign) BonesType boneType;
@end

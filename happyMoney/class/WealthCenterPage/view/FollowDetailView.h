//
//  FollowDetailView.h
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FollowData;

@interface FollowDetailView : UIView
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *date;
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) FollowData *data;
@end

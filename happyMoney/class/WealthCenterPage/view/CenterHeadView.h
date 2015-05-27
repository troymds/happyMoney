//
//  CenterHeadView.h
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserItem;

@protocol UserItemDelegate <NSObject>
-(void) readToLogin;
@end
@interface CenterHeadView : UIView
@property (nonatomic,strong) UIButton *apply;
@property (nonatomic,strong) UserItem *item;

@property (nonatomic,weak) id<UserItemDelegate> delegate;
-(void) reloadData;

@end

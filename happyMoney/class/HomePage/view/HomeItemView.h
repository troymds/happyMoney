//
//  HomeItemView.h
//  happyMoney
//
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeItemView;

typedef enum
{
    HomeClose = 0, //收益结算
    HomeDirect,     //直接会员
    HomeSubDirect   //间接会员
} homeItemType;

@protocol HomeItemDelegate <NSObject>
- (void) homeItemBtnClieked:(HomeItemView *)view clickedBtnTag:(NSInteger )tag;
@end

@interface HomeItemView : UIView

-(id) initWithFrame:(CGRect)frame icon:(NSString *)icon title:(NSString *)title num:(NSString *)num btnTag:(NSInteger )btnTag;

@property (nonatomic,assign) id<HomeItemDelegate> delegate;
@end

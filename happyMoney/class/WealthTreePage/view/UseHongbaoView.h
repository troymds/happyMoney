//
//  UseHongbaoView.h
//  happyMoney
//
//  Created by promo on 15-5-25.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KUseing,
    KNoUse
}HBUseTYpe;

@class couponModel;

@protocol UseHongbaoDelegate <NSObject>
- (void)useHongBaoClicked:(NSInteger )tag;
@end

@interface UseHongbaoView : UIView
-(id) initWithFrame:(CGRect)frame wihtData:(NSInteger )data;
@property (nonatomic, weak) id<UseHongbaoDelegate>delegate;
@property (nonatomic, strong) couponModel *Data;
@property (nonatomic, assign) HBUseTYpe type;
@property (nonatomic, assign) NSInteger count;
@end

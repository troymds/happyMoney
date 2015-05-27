//
//  NoAddressView.h
//  happyMoney
//
//  Created by promo on 15-5-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NoAddressLaterBlock)(void);
typedef void (^NoAddressAddBlock)(void);

@protocol NoAddressViewDelegate <NSObject>

-(void) later;
-(void) add;
@end
@interface NoAddressView : UIView
@property (nonatomic,strong) UIButton *later;
@property (nonatomic,strong) UIButton *add;
@property (nonatomic,weak) id<NoAddressViewDelegate>delegate;
-(void) show;
- (void) dismiss;
@end

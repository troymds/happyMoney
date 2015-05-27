//
//  LoginController.h
//  happyMoney
//
//  Created by promo on 15-3-30.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

@optional
- (void)loginSucessWithType:(NSInteger)type;

@end

@interface LoginController : UIViewController
@property (nonatomic,weak) id<LoginDelegate> delegate;
@property  (nonatomic,assign) NSInteger type;
@end

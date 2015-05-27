//
//  PersonRegister.h
//  happyMoney
//
//  Created by promo on 15-4-21.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterDelegate.h"

@class MDSTextField;

@interface PersonRegister : UIView
@property (nonatomic, assign) id<RegisterDelegate> delegate;
@property (nonatomic, strong) MDSTextField *contact; //联系人
@property (nonatomic, strong) MDSTextField *unickNum;//身份证
@end

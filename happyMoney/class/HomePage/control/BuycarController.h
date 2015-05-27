//
//  BuycarController.h
//  happyMoney
//
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeControllerDelegate.h"

@interface BuycarController : UIViewController<ChangeControllerDelegate>
@property (nonatomic,weak) id <ChangeControllerDelegate> delegate;
@end

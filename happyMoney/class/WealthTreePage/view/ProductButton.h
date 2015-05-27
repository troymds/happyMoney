//
//  ProductButton.h
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductButton : UIButton
@property (nonatomic, strong) NSIndexPath *indexPath; //记录button属于哪个cell
@end

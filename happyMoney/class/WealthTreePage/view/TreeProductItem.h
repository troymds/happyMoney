//
//  TreeProductItem.h
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryModel;
@class ProductButton;

@interface TreeProductItem : UIView
@property (nonatomic, strong) ProductButton *findBtn;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) CategoryModel *data;
@end

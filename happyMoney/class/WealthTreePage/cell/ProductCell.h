//
//  ProductCell.h
//  happyMoney
//
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface ProductCell : UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *productName;
@property (nonatomic, strong) UILabel *saleNum;
@property (nonatomic, strong) Product *data;

-(CGFloat) getCellH;
@end

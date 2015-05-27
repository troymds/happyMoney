//
//  ProductDetailModel.h
//  happyMoney
//
//  Created by promo on 15-4-15.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *old_price;
@property (strong, nonatomic) NSString *view_num;
@property (strong, nonatomic) NSString *sell_num;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *Description;
@property (strong, nonatomic) NSString *category_id;
@property (strong, nonatomic) NSString *collection_id;
@property (nonatomic, assign) int productCount;//数量
@property (nonatomic, assign) bool isChosen;//是否被选中
- (id)initWithDictionary:(NSDictionary *)dict;
@end

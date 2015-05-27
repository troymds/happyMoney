//
//  CarTool.h
//  happyMoney
//
//  Created by promo on 15-4-22.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class ProductDetailModel;

@interface CarTool : NSObject
singleton_interface(CarTool)

@property (nonatomic, strong) NSMutableArray *totalCarMenu; // 所有的购物车里的数据

-(void)addMenu:(ProductDetailModel *) menu;
-(void)plusMenu:(ProductDetailModel *) menu;
- (void)joinCar:(ProductDetailModel *) menu withProductNum:(int )count;
-(void)clear;
-(void)deleteDataWithArray:(NSArray *)array;
@end

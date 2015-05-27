//
//  CarTool.m
//  happyMoney
//  
//  Created by promo on 15-4-22.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CarTool.h"
#import "ProductDetailModel.h"

@implementation CarTool
singleton_implementation(CarTool)

- (id)init
{
    if (self = [super init]) {
        // 1.加载沙盒中的购物车数据
        _totalCarMenu = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        // 2.第一次没有购物车数据
        if (_totalCarMenu == nil) {
            _totalCarMenu = [NSMutableArray array];
        }
    }
    return self;
}

#pragma mark 加入购物车
- (void)joinCar:(ProductDetailModel *) menu withProductNum:(int)count
{
    if (_totalCarMenu) {
        BOOL alreadyExist = NO;
        for (int i = 0; i < _totalCarMenu.count; i++) {
            ProductDetailModel *data = _totalCarMenu[i];
            if ([menu.ID isEqualToString:data.ID]) {
                //如果找到了
                data.productCount += count;
                //                NSLog(@"已经存在的增加的ID为%@的数量%d",data.ID,data.foodCount);
                alreadyExist = YES;
            }
        }
        if (!alreadyExist) {
            menu.productCount = count;
            menu.isChosen = YES;
            //            NSLog(@"第一次增加的ID为%@的数量%d",menu.ID,menu.foodCount);
            [_totalCarMenu addObject:menu];
        }
        
        [NSKeyedArchiver archiveRootObject:_totalCarMenu toFile:kFilePath];
    }
}

#pragma mark 增加购物车菜品
-(void)addMenu:(ProductDetailModel *) menu
{
    if (_totalCarMenu) {
        BOOL alreadyExist = NO;
        for (int i = 0; i < _totalCarMenu.count; i++) {
            ProductDetailModel *data = _totalCarMenu[i];
            if ([menu.ID isEqualToString:data.ID]) {
                //如果找到了，直接把数量＋1
                data.productCount ++;
                //NSLog(@"已经存在的增加的ID为%@的数量%d",data.ID,data.foodCount);
                alreadyExist = YES;
            }
        }
        if (!alreadyExist) {
            menu.productCount++;
            menu.isChosen = YES;
            //NSLog(@"第一次增加的ID为%@的数量%d",menu.ID,menu.foodCount);
            [_totalCarMenu addObject:menu];
        }
        
        [NSKeyedArchiver archiveRootObject:_totalCarMenu toFile:kFilePath];
    }
}

#pragma mark 减少购物车菜品
-(void)plusMenu:(ProductDetailModel *) menu
{
    if (_totalCarMenu) {
        
        BOOL alreadyExist = NO;
        for (int i = 0; i < _totalCarMenu.count; i++) {
            ProductDetailModel *data = _totalCarMenu[i];
            if ([menu.ID isEqualToString:data.ID]) {//注意，减少的一定是_totalCarMenu里面的data，不然就歇菜拉拉
                alreadyExist = YES;
                data.productCount--;
                //                NSLog(@"已经存在的减完后ID%@的数量%d",menu.ID,menu.foodCount);
                if (data.productCount == 0) {
                    //                   NSLog(@"已经存在的减完后ID为0%@的数量%d",menu.ID,menu.foodCount);
                    [_totalCarMenu removeObject:data];
                }
            }
        }
        [NSKeyedArchiver archiveRootObject:_totalCarMenu toFile:kFilePath];
    }
}

#pragma mark 点击next时，删除购物车没有选中的数据
-(void)deleteDataWithArray:(NSArray *)array
{
    NSUInteger count = array.count;
    for (int i = 0; i < count; i++) {
        ProductDetailModel *deleteData = array[i];
        for (int j = 0; j < _totalCarMenu.count; j++) {
            ProductDetailModel *carData = _totalCarMenu[j];
            if (deleteData.ID == carData.ID) {
                [_totalCarMenu removeObject:carData];
                break;
            }
        }
    }
    [NSKeyedArchiver archiveRootObject:_totalCarMenu toFile:kFilePath];
}

#pragma mark 清除购物车
-(void)clear
{
    if (_totalCarMenu) {
        [_totalCarMenu removeAllObjects];
        [NSKeyedArchiver archiveRootObject:_totalCarMenu toFile:kFilePath];
    }
}

#pragma mark 计算
- (NSMutableArray *)totalCarMenu
{
    
    return _totalCarMenu;
}

@end

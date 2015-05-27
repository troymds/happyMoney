//
//  MemoryClearController.m
//  happyMoney
//  清除缓存
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MemoryClearController.h"

@interface MemoryClearController ()

@end

@implementation MemoryClearController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"清除缓存";
}

@end

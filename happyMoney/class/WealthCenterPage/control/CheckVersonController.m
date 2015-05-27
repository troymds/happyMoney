//
//  CheckVersonController.m
//  happyMoney
//  检查更新
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CheckVersonController.h"

@interface CheckVersonController ()

@end

@implementation CheckVersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"检查更新";
}

@end

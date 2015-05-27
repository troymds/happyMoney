//
//  HMBaseController.m
//  happyMoney
//
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "HMBaseController.h"

@interface HMBaseController ()

@end

@implementation HMBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    
}

@end

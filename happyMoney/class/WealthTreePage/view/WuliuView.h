//
//  WuliuView.h
//  happyMoney
//
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefaultAddressModel.h"

typedef void(^WuliuViewClickedBlock)(void);

@interface WuliuView : UIView

- (id)initWithFrame:(CGRect)frame withBlock:(WuliuViewClickedBlock)block;
@property (nonatomic,strong) UILabel *receiver;
@property (nonatomic,strong) UILabel *phone;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) DefaultAddressModel *data;
@end

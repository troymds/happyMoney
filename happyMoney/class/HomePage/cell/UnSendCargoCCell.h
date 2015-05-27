//
//  UnSendCargoCCell.h
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CargoBaseCell.h"
#import "OrderModel.h"
#import "OrderProductView.h"

@interface UnSendCargoCCell : CargoBaseCell

@property (nonatomic,strong) UILabel *typeLb;
@property (nonatomic,strong) OrderModel *data;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(OrderModel *) data;
@end

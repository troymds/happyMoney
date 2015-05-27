//
//  SendIngCCell.h
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CargoBaseCell.h"
#import "OrderModel.h"
#import "OrderProductView.h"

@interface SendIngCCell : CargoBaseCell
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nickName;
@property (nonatomic,strong) UILabel *dateLB;
@property (nonatomic,strong) OrderProductView *productView;
@property (nonatomic,strong) UILabel *totalLB;
@property (nonatomic,strong) UILabel *telLB;
@property (nonatomic,strong) UILabel *shipping;//货运号
@property (nonatomic,strong) OrderModel *data;

@end

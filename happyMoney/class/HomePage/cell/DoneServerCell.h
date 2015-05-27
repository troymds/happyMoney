//
//  DoneServerCell.h
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CargoBaseCell.h"
#import "OrderProductView.h"
#import "OrderModel.h"

@interface DoneServerCell : CargoBaseCell
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *nickName;
@property (nonatomic,strong) UILabel *dateLB;
@property (nonatomic,strong) OrderProductView *productView;
@property (nonatomic,strong) UILabel *totalLB;
@property (nonatomic,strong) UILabel *telLB;
@property (nonatomic,strong) UILabel *addressLB;
@property (nonatomic,strong) OrderModel *data;

@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UILabel *total;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UILabel *typeLB;
@property (nonatomic,strong) UIView *line3;
@property (nonatomic,strong) UIView *line4;

- (CGFloat) getCellHeight;
@end

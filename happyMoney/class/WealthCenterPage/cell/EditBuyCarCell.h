//
//  EditBuyCarCell.h
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditBuyCarCell : UITableViewCell
@property (nonatomic, strong) UIButton *selectedBtn;//选中按钮
@property (nonatomic, strong) UILabel *title; //
@property (nonatomic, strong) UILabel *newprice;//价格
@property (nonatomic, strong) UIButton *plusBtn;//减号按钮
@property (nonatomic, strong) UIButton *addBun;//加号按钮
@property (nonatomic, strong) UIButton *foodConnt;//数量
@property (nonatomic, strong) UILabel *oldPrice;//美元
@property (nonatomic, strong) UILabel *totla;//元
@property (nonatomic, strong) UIImageView *img;//菜品图片
//@property (nonatomic, strong) MenuModel *data;
@property (nonatomic, assign) int count;
@property (nonatomic, assign)NSInteger indexPath; //哪一个cell
@property (nonatomic, assign)BOOL isSelected; //是否被选中
@end

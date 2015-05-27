//
//  CargoBaseCell.h
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tool.h"

#define firstViewH  40
#define startXY  10
#define proH 100
#define  btnH 28
#define  spaace 10
typedef enum
{
    KTTypeZiti,
    KTTypeWuliu
} transeType;

typedef enum OrderBtnClickedType
{
    KOrderBtnClickedTypeDetal = 0,//订单详情
    KOrderBtnClickedTypeConform,//确认订单
    kOrderBtnClickedTypeWuliu
}OrderBtnClickedType;

@protocol OrderCellDelegate <NSObject>
@optional
-(void)OrderCellBtnCliked:(OrderBtnClickedType )type;
-(void)OrderCellBtnCliked:(OrderBtnClickedType )type withOrderID:(NSString *)orderID;
@end

@interface CargoBaseCell : UITableViewCell

@property (nonatomic,assign) transeType type;
@property (nonatomic,assign) id<OrderCellDelegate> delegate;
@end

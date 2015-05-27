//
//  UnSendCargoCCell.m
//  happyMoney
//  未发货订单
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UnSendCargoCCell.h"
#import "OrderProductView.h"
#import "OrderListAddressModel.h"
#import "OrderListProduct.h"

#define KTag 100000000
#define KBtnTag 1000
#define LWUiu 50

@implementation UnSendCargoCCell
{
    CGFloat _viewH ;
    UILabel *_time;
    UIView *_line1;
    UILabel *_tel;
    UILabel *_total;
    UILabel *_money;
    UIView *_line2;
    UIView *_line3;
    UIView *_oldLine;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withData:(OrderModel *) data
{
    _data = data;
    NSLog(@"%@",data);
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1 time
        CGFloat timeH = (firstViewH - startXY )/2;
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:time];
        time.textColor = HexRGB(0x808080);
        time.font = [UIFont systemFontOfSize:PxFont(Font22)];
        time.text = @"下单时间: 2014.05.01";
        _time = time;
        _time.frame = Rect(startXY, startXY, 260, timeH);
        _time.text = [NSString stringWithFormat:@"下单时间：%@",data.post_time];
        
        CGFloat typeX = kWidth - startXY - 60;
        
        UILabel *transType = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:transType];
        transType.textColor = HexRGB(0x808080);
        transType.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _typeLb = transType;
        _typeLb.frame = Rect(typeX, startXY, 60, timeH);
        
        CGFloat linxX = 3;
        CGFloat linxY = CGRectGetMaxY(_time.frame) + startXY - 0.5;
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line1];
        line1.backgroundColor = HexRGB(KCellLineColor);
        _line1 = line1;
        _line1.frame = Rect(linxX, linxY, kWidth - linxX * 2, 0.5);
        
        _viewH = CGRectGetMaxY(_line1.frame);
        
        //3 product
        NSUInteger count = data.products.count;
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in data.products)
        {
            [array addObject:dic];
        }
        NSUInteger o = array.count;
        for (int i = 0; i < count; i++) {
            OrderProductView *pro = [[OrderProductView alloc] init];
            CGFloat proY = CGRectGetMaxY(_line1.frame);
            OrderListProduct *proD = [[OrderListProduct alloc] initWithDictionaryForGategory:array[i]];
//            pro.frame = CGRectZero;
            pro.data = proD;
            pro.frame = Rect(0, proY + proH * i, kWidth, proH);
            pro.tag = KTag + i;
            [self.contentView addSubview:pro];
            if (i == count - 1) {
                _viewH = CGRectGetMaxY(pro.frame);
            }
        }
        
        //4
        OrderListAddressModel *addrsssModel = [[OrderListAddressModel alloc] initWithDictionary:_data.address];
        
        CGFloat telY = _viewH + startXY;
        UILabel *tel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:tel];
        tel.frame = Rect(startXY, telY, 200, timeH);
        tel.textColor = HexRGB(0x808080);
        tel.font = [UIFont systemFontOfSize:PxFont(Font22)];
        tel.text = @"联系电话：13989878987";
        _tel = tel;
        _tel.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel.phone_num];
        
        UILabel *total = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:total];
        total.text = @"总计：";
        total.textColor = HexRGB(0x808080);
        total.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _total = total;
        _total.frame = Rect(CGRectGetMaxX(_tel.frame) + 20, telY, 55, timeH);
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:money];
        money.text = @" ¥ 2136";
        money.textColor = HexRGB(0x3a3a3a);
        money.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _money = money;
        _money.frame = Rect(CGRectGetMaxX(_total.frame), telY, 60, timeH);
        _money.text = [NSString stringWithFormat:@"¥ %@",data.order_price];
        
        CGFloat oX = 0;
        CGFloat oldLineX = _money.frame.origin.x - oX;
        CGFloat oldLineY = _money.frame.origin.y + timeH/2;
        CGFloat oldLineW = [_money.text sizeWithFont:[UIFont systemFontOfSize:PxFont(Font22)]].width + 4;
        
        UIView *oldLine = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:oldLine];
        oldLine.backgroundColor = HexRGB(KCellLineColor);
        _oldLine = oldLine;
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line2];
        line2.backgroundColor = HexRGB(KCellLineColor);
        _line2 = line2;
        
        _oldLine.frame = Rect(oldLineX, oldLineY, oldLineW, 0.8);
        
        _line2.frame = Rect(linxX, _viewH + firstViewH, kWidth - linxX * 2, 0.5);
        
        _viewH = _viewH + firstViewH;
        
        CGFloat btnGroupY = _viewH + startXY;
        
        CGFloat btnW = 90;
        
        if (self.type == KTTypeWuliu) {
            _typeLb.text = @"物流";
            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:btn];
            btn.tag = LWUiu;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5.0;
            btn.layer.borderWidth = 1.0;
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"查看订单" forState:UIControlStateNormal];
            [btn setTitle:@"查看订单" forState:UIControlStateSelected];
            [btn setTitle:@"查看订单" forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(wuliuClicked) forControlEvents:UIControlEventTouchUpInside];
            btn.frame  = Rect(kWidth - 10 - btnW, btnGroupY, btnW, btnH);
        }else
        {
            _typeLb.text = @"自提";
            //有 查看订单喝确认收获
            CGFloat btnXX = kWidth - (10 + btnW) * 2;
            
            NSArray *btns = @[@"查看订单",@"确认收货"];
            for (int i = 0; i < 2; i++) {
                UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
                [self.contentView addSubview:btn];
                btn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
                btn.tag = i + KBtnTag;
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 5.0;
                btn.layer.borderWidth = 1.0;
                [btn setBackgroundColor:[UIColor clearColor]];
                [btn setTitle:btns[i] forState:UIControlStateNormal];
                [btn setTitle:btns[i] forState:UIControlStateSelected];
                [btn setTitle:btns[i] forState:UIControlStateHighlighted];
                [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                [btn addTarget:self action:@selector(selfClicked:) forControlEvents:UIControlEventTouchUpInside];
                //                btn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
            }
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line3];
        line3.frame  = Rect(0, btnGroupY + btnH + startXY + 5, kWidth, 0.5);
        
        line3.backgroundColor = HexRGB(KCellLineColor);
        _line3 = line3;
        
        _viewH = CGRectGetMaxY(line3.frame);
    }
    return self;
}

-(void)setData:(OrderModel *)data
{
    //1 time
    _data = data;
    
    CGFloat timeH = (firstViewH - startXY )/2;
    
//    _time.frame = Rect(startXY, startXY, 260, timeH);
    _time.text = [NSString stringWithFormat:@"下单时间：%@",data.post_time];
    CGFloat typeX = kWidth - startXY - 60;
//    _typeLb.frame = Rect(typeX, startXY, 60, timeH);
    
    CGFloat linxX = 3;
    CGFloat linxY = CGRectGetMaxY(_time.frame) + startXY - 0.5;
//    _line1.frame = Rect(linxX, linxY, kWidth - linxX * 2, 0.5);
    
//    _viewH = CGRectGetMaxY(_line1.frame);
    //3 product
    
    NSUInteger count = data.products.count;
        int i = -1;
        OrderProductView *oView = nil;
        for (NSDictionary *dic in data.products) {
            i++;
            oView = (OrderProductView *)[self.contentView viewWithTag:KTag + i];
            OrderListProduct *pro = [[OrderListProduct alloc] initWithDictionaryForGategory:dic];
//            oView.data = pro;
//            CGFloat proY = CGRectGetMaxY(_line1.frame);
//            oView.frame = Rect(0, proY + proH * i, kWidth, proH);
            NSLog(@"%@",NSStringFromCGRect(oView.frame));
//            if (i == count - 1) {
//                _viewH = CGRectGetMaxY(oView.frame);
//            }
        }
    
    //4
    OrderListAddressModel *addrsssModel = [[OrderListAddressModel alloc] initWithDictionary:_data.address];
//    CGFloat telY = _viewH + startXY;
//    _tel.frame = Rect(startXY, telY, 200, timeH);
    
    _tel.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel.phone_num];
    
//    _total.frame = Rect(CGRectGetMaxX(_tel.frame) + 20, telY, 55, timeH);

    
//    _money.frame = Rect(CGRectGetMaxX(_total.frame), telY, 60, timeH);
    _money.text = [NSString stringWithFormat:@"¥ %@",data.order_price];
    
//    CGFloat oX = 0;
//    CGFloat oldLineX = _money.frame.origin.x - oX;
//    CGFloat oldLineY = _money.frame.origin.y + timeH/2;
//    CGFloat oldLineW = [_money.text sizeWithFont:[UIFont systemFontOfSize:PxFont(Font22)]].width + 4;
//    _oldLine.frame = Rect(oldLineX, oldLineY, oldLineW, 0.8);
//    
//    _line2.frame = Rect(linxX, _viewH + firstViewH, kWidth - linxX * 2, 0.5);
//    
//    _viewH = _viewH + firstViewH;
//    
//    CGFloat btnGroupY = _viewH + startXY;
//    
//    CGFloat btnW = 90;
    
    if (self.type == KTTypeWuliu) {
        _typeLb.text = @"物流";
        UIButton *btn  = (UIButton *)[self.contentView viewWithTag:LWUiu];
//        if (btn == nil) {
//            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
//            [self.contentView addSubview:btn];
//            btn.tag = LWUiu;
//            btn.layer.masksToBounds = YES;
//            btn.layer.cornerRadius = 5.0;
//            btn.layer.borderWidth = 1.0;
//            [btn setBackgroundColor:[UIColor clearColor]];
//            [btn setTitle:@"查看订单" forState:UIControlStateNormal];
//            [btn setTitle:@"查看订单" forState:UIControlStateSelected];
//            [btn setTitle:@"查看订单" forState:UIControlStateHighlighted];
//            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//            [btn addTarget:self action:@selector(wuliuClicked) forControlEvents:UIControlEventTouchUpInside];
//            btn.frame  = Rect(kWidth - 10 - btnW, btnGroupY, btnW, btnH);
//        }
//        else
//        {
//            btn.frame  = Rect(kWidth - 10 - btnW, btnGroupY, btnW, btnH);
//        }
        
    }else
    {
        _typeLb.text = @"自提";
        //有 查看订单喝确认收获
//        CGFloat btnXX = kWidth - (10 + btnW) * 2;
        UIButton *btn;
        NSArray *btns = @[@"查看订单",@"确认收货"];
        for (int i = 0; i < 2; i++) {
            btn  = (UIButton *)[self.contentView viewWithTag:KBtnTag + i];
//            if (btn == nil) {
//                UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
//                [self.contentView addSubview:btn];
//                btn.tag = i + KBtnTag;
//                btn.layer.masksToBounds = YES;
//                btn.layer.cornerRadius = 5.0;
//                btn.layer.borderWidth = 1.0;
//                [btn setBackgroundColor:[UIColor clearColor]];
//                [btn setTitle:btns[i] forState:UIControlStateNormal];
//                [btn setTitle:btns[i] forState:UIControlStateSelected];
//                [btn setTitle:btns[i] forState:UIControlStateHighlighted];
//                [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//                [btn addTarget:self action:@selector(selfClicked:) forControlEvents:UIControlEventTouchUpInside];
//                btn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
//            }
//            else
//            {
//                btn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
//            }
            
        }
    }
    
//    _line3.frame  = Rect(0, btnGroupY + btnH + startXY + 5, kWidth, 0.5);
    
    _viewH = CGRectGetMaxY(_line3.frame);
    
}

- (void)selfClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(OrderCellBtnCliked: withOrderID:)]) {
        if (btn.tag == KBtnTag) {
            [self.delegate OrderCellBtnCliked:KOrderBtnClickedTypeDetal withOrderID:_data.ID ];
        }else
        {
            [self.delegate OrderCellBtnCliked:KOrderBtnClickedTypeConform withOrderID:_data.ID];
        }
    }
}

-(void)wuliuClicked
{
    if ([self.delegate respondsToSelector:@selector(OrderCellBtnCliked:)]) {
        [self.delegate OrderCellBtnCliked:KOrderBtnClickedTypeDetal];
    }
}

//- (CGFloat) getCellHeight
//{
//    return _viewH;
//}
@end

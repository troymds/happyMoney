//
//  DoneCCell.m
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "DoneCCell.h"
#import "OrderListAddressModel.h"
#import "OrderListProduct.h"

#define KTag 100
#define KBtnTag 1000
#define KProCount 10

@implementation DoneCCell
{
    CGFloat _viewH ;
    UILabel *_time;
    UILabel *_typeLb;
    UILabel *_total;
    UILabel *_money;
    UIView *_line1;
    UIView *_line2;
    UIView *_line3;
    UIButton *_wuliuBtn;
    UIButton *_checkBtn;
    UIView *_bottomView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ;
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1 time
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor = HexRGB(0xeeeeee);
        _bottomView = bottomView;
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:time];
        time.textColor = HexRGB(0x808080);
        time.font = [UIFont systemFontOfSize:PxFont(Font20)];
        time.text = @"下单时间: 2014.05.01";
        time.backgroundColor = [UIColor clearColor];
        _time = time;
        
        UILabel *transType = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:transType];
        transType.textColor = HexRGB(0x808080);
        transType.font = [UIFont systemFontOfSize:PxFont(Font20)];
        transType.backgroundColor = [UIColor clearColor];
        _typeLb = transType;
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line1];
        line1.backgroundColor = HexRGB(KCellLineColor);
        _viewH = CGRectGetMaxY(line1.frame);
        _line1 = line1;
        
        //3 product
        
        for (int i = 0; i < KProCount; i++) {
            OrderProductView *pro = [[OrderProductView alloc] init];
            pro.frame = CGRectZero;
            pro.tag = KTag + i;
            [self.contentView addSubview:pro];
        }
        //4
        
        _shipping = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_shipping];
        _shipping.textColor = HexRGB(0x808080);
        _shipping.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _shipping.text = @"货运号：1535352535253";
        
        UILabel *tel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:tel];
        _telLB = tel;
        tel.textColor = HexRGB(0x808080);
        tel.backgroundColor = [UIColor clearColor];
        tel.font = [UIFont systemFontOfSize:PxFont(Font20)];
        tel.text = @"联系电话：13989878987";
        
        UILabel *total = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:total];
        total.text = @"总计：";
        total.backgroundColor = [UIColor clearColor];
        total.textColor = HexRGB(0x808080);
        total.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _total = total;
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:money];
        money.text = @"¥ 216";
        money.backgroundColor = [UIColor clearColor];
        money.textColor = HexRGB(0x3a3a3a);
        money.font  = [UIFont systemFontOfSize:PxFont(Font20)];
        _money = money;
        
        _viewH = CGRectGetMaxY(tel.frame) + startXY;
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line2];
        line2.backgroundColor = HexRGB(KCellLineColor);
        _line2 = line2;
        
        transType.text = @"自提";
        //有 查看订单喝确认收获
        NSArray *btns = @[@"查看订单",@"查看物流"];
        for (int i = 0; i < btns.count; i++) {
            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:btn];
            btn.tag = i + KBtnTag;
            if (i == 0) {
                _checkBtn = btn;
            }else
            {
                _wuliuBtn = btn;
            }
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5.0;
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = ButtonColor.CGColor;
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:btns[i] forState:UIControlStateNormal];
            [btn setTitle:btns[i] forState:UIControlStateSelected];
            [btn setTitle:btns[i] forState:UIControlStateHighlighted];
            [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
            [btn setTitleColor:ButtonColor forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(DoneCCell:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line3];
        line3.backgroundColor = HexRGB(KCellLineColor);
        _line3 = line3;

    }
    return self;
}

-(void)setData:(OrderModel *)data
{
    _data = data;
    //1 time
    CGFloat bottomH = 15;
    _bottomView.frame = Rect(0, 0, kWidth, bottomH);
    
    CGFloat timeH = (firstViewH - startXY)/2;
    CGFloat timeY = bottomH + startXY;
    _time.frame = Rect(startXY, timeY, 250, timeH);
    _time.text = [NSString stringWithFormat:@"下单时间：%@",[Tool getShortTimeFrom:data.post_time]];
    
    CGFloat typeX = kWidth - startXY - 60;
    _typeLb.frame = Rect(typeX, timeY, 60, timeH);
    
    CGFloat linxX = 3;
    CGFloat linxY = CGRectGetMaxY(_time.frame) + startXY - 0.5;
    _line1.frame = Rect(linxX, linxY, kWidth - linxX * 2, 0.5);
    
    _viewH = CGRectGetMaxY(_line1.frame);
    
    //3 product
    NSMutableArray *proDataArray = [NSMutableArray array];
    for (NSDictionary *dic in data.products)
    {
        [proDataArray addObject:dic];
    }
    
    for (int j = 0; j < KProCount; j++) {
        NSInteger proCount = data.products.count;
        if (j < proCount) {
            OrderProductView *pro  = (OrderProductView *)[self.contentView viewWithTag:KTag + j];
            NSDictionary *dic =(NSDictionary *)proDataArray[j];
            OrderListProduct *prodata = [[OrderListProduct alloc] initWithDictionaryForGategory:dic];
            pro.data = prodata;
            pro.hidden = NO;
            CGFloat proY = _viewH;
            pro.frame = Rect(0, proY + proH * j, kWidth, proH);
            if (j == proCount - 1) {
                _viewH = CGRectGetMaxY(pro.frame);
            }
        }else
        {
            OrderProductView *pro  = (OrderProductView *)[self.contentView viewWithTag:KTag + j];
            pro.hidden = YES;
        }
    }
    
    //4
    CGFloat thirdViewY = _viewH + startXY;
    CGFloat titleH = 15;
    CGFloat telY = 0;
    CGFloat space = 5;
    CGFloat thirdH = 0;
    CGFloat totalX = kWidth - 110;
    if (self.type == KTTypeWuliu) {
        //客运号和 联系电话都有，否则只有联系电话
        _shipping.hidden = NO;
        _shipping.frame = Rect(startXY, thirdViewY, 200, titleH);
//        _shipping.text = data.address_id;
        telY = CGRectGetMaxY(_shipping.frame) + space;
        _telLB.frame = Rect(startXY, telY, 200, titleH);
        
        _total.frame = Rect(totalX, thirdViewY + 5, 55, titleH);
        
        _money.frame = Rect(CGRectGetMaxX(_total.frame) - 5, thirdViewY + 5, 60, titleH);
        thirdH = 55;
    }else
    {
        _shipping.hidden = YES;
        
        telY = thirdViewY;
        _telLB.frame = Rect(startXY, telY, 200, titleH);
        
        _total.frame = Rect(totalX, telY, 55, titleH);
        
        _money.frame = Rect(CGRectGetMaxX(_total.frame) - 5, telY, 60,titleH);
        thirdH = 35;
    }
    
    _viewH += thirdH;
    
    OrderListAddressModel *addrsssModel = nil;
    if (![_data.address isKindOfClass:[NSNull class]]) {
        addrsssModel = [[OrderListAddressModel alloc] initWithDictionary:_data.address];
    }
    
    _telLB.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel != nil ? addrsssModel.phone_num : @""];
    
    _money.text = [NSString stringWithFormat:@"¥ %@",data.order_price];
    
//    _viewH = CGRectGetMaxY(_telLB.frame) + startXY;
    
    _line2.frame = Rect(linxX, _viewH - 0.5, kWidth - linxX * 2, 0.5);

    CGFloat btnGroupY = _viewH + startXY;
    
    CGFloat btnW = 90;
    
    _typeLb.text = @"自提";
    //有 查看订单喝确认收获
    NSArray *btns = @[@"查看订单",@"查看物流"];
    CGFloat btnXX = kWidth - (10 + btnW) * btns.count;
    UIButton *btn;
    for (int i = 0; i < btns.count; i++) {
        btn  = (UIButton *)[self.contentView viewWithTag:KBtnTag + i];
        btn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
    }
    
    if (self.type == KTTypeWuliu) {
        //只有查看订单按钮
        _typeLb.text = @"物流";
        _wuliuBtn.hidden = NO;
        
    }else
    {
        _typeLb.text = @"自提";
        
        //有 查看订单喝确认收获,没有物流
        _checkBtn.frame = _wuliuBtn.frame;
        _wuliuBtn.hidden = YES;
    }
    
    CGFloat line3Y = CGRectGetMaxY(_checkBtn.frame) + startXY;
    _line3.frame = Rect(0, line3Y, kWidth, 0.5);
    
    _viewH = CGRectGetMaxY(_line3.frame);
    
}

- (CGFloat) getCellHeight
{
    return _viewH;
}

-(void)DoneCCell:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(OrderCellBtnCliked:withOrderID:)]) {
        if (btn.tag == KBtnTag) {
            [self.delegate OrderCellBtnCliked:KOrderBtnClickedTypeDetal withOrderID:_data.ID ];
        }else
        {
            [self.delegate OrderCellBtnCliked:kOrderBtnClickedTypeWuliu withOrderID:_data.ID ];
        }
    }
}
@end

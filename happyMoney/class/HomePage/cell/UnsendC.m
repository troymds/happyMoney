//
//  UnsendC.m
//  happyMoney
//
//  Created by promo on 15-5-18.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UnsendC.h"
#import "OrderProductView.h"
#import "OrderListAddressModel.h"
#import "OrderListProduct.h"

#define KTag 100000000
#define KBtnTag 1000
#define LWUiu 50

#define KProCount 10
@implementation UnsendC
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
    NSMutableArray *_proArray;
    UIButton *_wuliuBtn;
    UIButton *_checkBtn;
    UIButton *_conformBtn;
    UIView *_bottomView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1 time
//        self.backgroundColor = HexRGB(0xeeeeee);
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:bottomView];
        bottomView.backgroundColor = HexRGB(0xeeeeee);
        _bottomView = bottomView;
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:time];
        time.textColor = HexRGB(0x808080);
        time.font = [UIFont systemFontOfSize:PxFont(Font20)];
        time.text = @"下单时间: 2014.05.01";
        _time = time;
        
        UILabel *transType = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:transType];
        transType.textColor = HexRGB(0x808080);
        transType.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _typeLb = transType;

        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line1];
        line1.backgroundColor = HexRGB(KCellLineColor);
        _line1 = line1;
        
        //3 product
        
        for (int i = 0; i < KProCount; i++) {
            OrderProductView *pro = [[OrderProductView alloc] init];
            pro.frame = CGRectZero;
            pro.tag = KTag + i;
            [_proArray addObject:pro];
            [self.contentView addSubview:pro];
        }


        UILabel *tel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:tel];
        tel.textColor = HexRGB(0x808080);
        tel.font = [UIFont systemFontOfSize:PxFont(Font20)];
        tel.text = @"联系电话：13989878987";
        _tel = tel;
        
        UILabel *total = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:total];
        total.text = @"总计：";
        total.textColor = HexRGB(0x808080);
        total.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _total = total;
        
        UILabel *money = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:money];
        money.text = @" ¥ 2136";
        money.textColor = HexRGB(0x3a3a3a);
        money.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _money = money;

        UIView *oldLine = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:oldLine];
        oldLine.backgroundColor = HexRGB(KCellLineColor);
        _oldLine = oldLine;
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line2];
        line2.backgroundColor = HexRGB(KCellLineColor);
        _line2 = line2;
        
        //只有查看订单和确认订单
        
        NSArray *btns = @[@"查看订单",@"确认收货"];
        for (int i = 0; i < 2; i++) {
            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:btn];
            btn.tag = i + KBtnTag;
            if (i == 0) {
                _checkBtn = btn;
            }else
            {
                _conformBtn = btn;
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
            [btn addTarget:self action:@selector(selfClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = CGRectZero;
        }
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line3];
        line3.frame = CGRectZero;
        
        line3.backgroundColor = HexRGB(KCellLineColor);
        _line3 = line3;
//        _viewH = CGRectGetMaxY(line3.frame);
    }
    return self;
}

-(void)setData:(OrderModel *)data
{
    //1 time
    _data = data;
    
    CGFloat bottomH = 15;
    _bottomView.frame = Rect(0, 0, kWidth, bottomH);
    
    CGFloat timeH = (firstViewH - startXY )/2;
    
    CGFloat timeY = bottomH + startXY;
    _time.frame = Rect(startXY, timeY, 260, timeH);
    _time.text = [NSString stringWithFormat:@"下单时间：%@",[Tool getShortTimeFrom:data.post_time]];
    
    CGFloat typeX = kWidth - startXY - 60;
    _typeLb.frame = Rect(typeX, timeY, 60, timeH);
    
    CGFloat linxX = 3;
    CGFloat linxY = CGRectGetMaxY(_time.frame) + startXY - 0.5;
    _line1.frame = Rect(linxX, linxY, kWidth - linxX * 2, 0.5);
    _viewH = CGRectGetMaxY(_line1.frame);;
    
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
    OrderListAddressModel *addrsssModel = nil;
    if (![_data.address isKindOfClass:[NSNull class]]) {
        addrsssModel = [[OrderListAddressModel alloc] initWithDictionary:_data.address];
    }

    CGFloat telY = _viewH + startXY;
    CGFloat totalX = kWidth - 110;
    
    _tel.frame = Rect(startXY, telY, 200, timeH);
    _tel.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel != nil ? addrsssModel.phone_num : @""];
    
    _total.frame = Rect(totalX , telY, 55, timeH);


    _money.frame = Rect(CGRectGetMaxX(_total.frame) - 5, telY, 60, timeH);
    _money.text = [NSString stringWithFormat:@"¥ %@",data.order_price];

    CGFloat line2Y = CGRectGetMaxY(_tel.frame) + startXY;
    _line2.frame = Rect(linxX,line2Y, kWidth - linxX * 2, 0.5);

    _viewH = CGRectGetMaxY(_line2.frame);

    CGFloat btnGroupY = _viewH + startXY;

    CGFloat btnW = 90;
    
    CGFloat btnXX = kWidth - (10 + btnW) * 2;
    for (int i = 0; i < 2; i++) {
        if (i == 0) {
            _checkBtn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
        }else
        {
            _conformBtn.frame = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
        }
    }
    _viewH += 48;
    if (self.type == KTTypeWuliu) {
        //只有查看订单按钮
        _typeLb.text = @"物流";
        _conformBtn.hidden = YES;
        _checkBtn.frame = Rect(btnXX + (btnW + 10) * 1, btnGroupY, btnW, btnH);
//        _wuliuBtn.frame  = Rect(kWidth - 10 - btnW, btnGroupY, btnW, btnH);
        
    }else
    {
        _typeLb.text = @"自提";
        //有 查看订单喝确认收获
        _conformBtn.hidden = NO;
    }
    CGFloat line3Y = CGRectGetMaxY(_checkBtn.frame) + startXY;
    _line3.frame  = Rect(0, line3Y, kWidth, 0.5);
    
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
@end

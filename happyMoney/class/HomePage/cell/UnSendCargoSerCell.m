//
//  UnSendCargoSerCell.m
//  happyMoney
//  未发货代理商cell
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "UnSendCargoSerCell.h"
#import "OrderListAddressModel.h"
#import "OrderListProduct.h"
#import "SystemConfig.h"
#import "UserItem.h"

#define KTag 100
#define KBtnTag 1000
#define KProCount 10

@implementation UnSendCargoSerCell
{
    CGFloat _viewH;
    UIButton *_checkBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 1 icon
        CGFloat iconX = startXY/2 ;
        CGFloat iconWH = firstViewH - iconX * 2;
        _icon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_icon];
        _icon.backgroundColor = [UIColor clearColor];
        _icon.layer.masksToBounds = YES;
        _icon.layer.cornerRadius = iconWH/2;
        [_icon setImageWithURL:[NSURL URLWithString:[SystemConfig sharedInstance].user.avatar] placeholderImage:placeHoderImage];
        //2 nick name
        
        _nickName = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nickName];
        _nickName.textColor = HexRGB(0x808080);
        _nickName.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _nickName.text = [SystemConfig sharedInstance].user.userName;
        
        //3 time
        _dateLB = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_dateLB];
        _dateLB.textColor = HexRGB(0x808080);
        _dateLB.font = [UIFont systemFontOfSize:PxFont(Font20)];
        _dateLB.text = @"2013.08.98";
        
        //4 first line
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line1];
        line1.backgroundColor = HexRGB(KCellLineColor);
        _line1 = line1;
        
        //5 product view
        for (int i = 0; i < KProCount; i++) {
            OrderProductView *pro = [[OrderProductView alloc] init];
            pro.frame = CGRectZero;
            pro.tag = KTag + i;
            [self.contentView addSubview:pro];
        }
        
        //6 total
        UILabel *total = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:total];
        total.text = @"总计：";
        total.textColor = HexRGB(0x808080);
        total.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _total = total;
        
        _totalLB = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:_totalLB];
        _totalLB.text = @"¥ 216";
        _totalLB.textColor = HexRGB(0x808080);
        _totalLB.font = [UIFont systemFontOfSize:PxFont(Font22)];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line2];
        line2.backgroundColor = HexRGB(KCellLineColor);
        _line2 = line2;
        
        UILabel *typeLB = [[UILabel alloc] initWithFrame:CGRectZero];
        typeLB.textColor = HexRGB(0x808080);
        typeLB.font = [UIFont systemFontOfSize:PxFont(Font22)];
        [self.contentView addSubview:typeLB];
        _typeLB = typeLB;
        
        _telLB = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_telLB];
        _telLB.textColor = HexRGB(0x808080);
        _telLB.font = [UIFont systemFontOfSize:PxFont(Font22)];
        
        _addressLB = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_addressLB];
        _addressLB.textColor = HexRGB(0x808080);
        _addressLB.font = [UIFont systemFontOfSize:PxFont(Font22)];
        
        [self addSubview:_telLB];

        if (self.type == KTTypeWuliu) {
            typeLB.text = @"物流";
            _addressLB.hidden = NO;
            _addressLB.text = @"收货地址：南京市情怀去新街口国际大厦XXX";
            _addressLB.numberOfLines = 0;
        }else
        {
            _addressLB.hidden = YES;
        }
        _telLB.text = @"联系电话：13987898767";
        
        //line3
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line3];
        line3.backgroundColor = HexRGB(KCellLineColor);
        _line3 = line3;

        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        btn.tag = KBtnTag;
        _checkBtn = btn;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5.0;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = ButtonColor.CGColor;
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitle:@"查看订单" forState:UIControlStateNormal];
        [btn setTitle:@"查看订单" forState:UIControlStateSelected];
        [btn setTitle:@"查看订单" forState:UIControlStateHighlighted];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn setTitleColor:ButtonColor forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(selClicked) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectZero;

        UIView *line4 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:line4];
        line4.backgroundColor = HexRGB(KCellLineColor);
        _line4 = line4;

    }
    return self;
}

-(void)setData:(OrderModel *)data
{
    _data = data;
    
    // 1 icon
    CGFloat iconX = startXY/2 ;
    CGFloat iconWH = firstViewH - iconX * 2;
    _icon.frame = Rect(iconX, iconX, iconWH, iconWH);
    _icon.backgroundColor = [UIColor clearColor];
    _icon.layer.masksToBounds = YES;
    _icon.layer.cornerRadius = iconWH/2;
    
    //2 nick name
    CGFloat nickX = CGRectGetMaxX(_icon.frame) + 10;
    CGFloat timeH = (firstViewH - startXY)/2;
    _nickName.frame = Rect(nickX, startXY + 3 , 200, timeH);
    _nickName.textColor = HexRGB(0x808080);
    _nickName.font = [UIFont systemFontOfSize:PxFont(Font20)];
//    _nickName.text = @"会呼吸的痛";
    
    //3 time
    CGFloat timeW = 120;
    CGFloat timeX = kWidth - startXY - timeW + 10;
    _dateLB.frame = Rect(timeX, startXY + 3, timeW, timeH);
    _dateLB.textColor = HexRGB(0x808080);
    _dateLB.font = [UIFont systemFontOfSize:PxFont(Font20)];
    
    _dateLB.text = [NSString stringWithFormat:@"%@",[Tool getShortTimeFrom:data.post_time]];
    
    //4 first line
    CGFloat linxX = 3;
    _line1.frame = Rect(linxX, firstViewH - 0.5, kWidth - linxX * 2, 0.5);
    _line1.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = firstViewH;
    //5 product view
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
 
    //6 total
    CGFloat moneyW = 60;
    CGFloat toX = kWidth - 10 - moneyW - moneyW;
    _total.frame = Rect(toX, _viewH + startXY, moneyW, timeH);
    _total.text = @"总计：";
    _total.textColor = HexRGB(0x808080);
    _total.font = [UIFont systemFontOfSize:PxFont(Font22)];
    
    _totalLB.frame = Rect(CGRectGetMaxX(_total.frame) - 10, _total.frame.origin.y, moneyW, timeH);
    _totalLB.text = [NSString stringWithFormat:@"¥ %@",data.order_price];
    _totalLB.textColor = HexRGB(0x808080);
    _totalLB.font = [UIFont systemFontOfSize:PxFont(Font22)];
    
    _line2.frame = Rect(linxX, _viewH + firstViewH - 0.5, kWidth - linxX * 2, 0.5);
    _line2.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = CGRectGetMaxY(_line2.frame) + 1;
    
    //  电话 收货地址
    CGFloat telY = 0;

    _typeLB.textColor = HexRGB(0x808080);
    _typeLB.font = [UIFont systemFontOfSize:PxFont(Font22)];

    _telLB.textColor = HexRGB(0x808080);
    _telLB.font = [UIFont systemFontOfSize:PxFont(Font22)];

    _addressLB.textColor = HexRGB(0x808080);
    _addressLB.font = [UIFont systemFontOfSize:PxFont(Font22)];
    
    [self addSubview:_telLB];
    CGFloat telH;
    CGFloat telAddVH;

    if (self.type == KTTypeWuliu) {
        telY = _viewH + spaace;
        telAddVH = 50;
        CGFloat space = 15;
         telH = (telAddVH - startXY * 2 - space)/2;
        _telLB.frame = Rect(startXY, telY, 200, telH);
        _typeLB.text = @"物流";
        _addressLB.hidden = NO;
        _addressLB.text = [NSString stringWithFormat:@"收货地址：%@",addrsssModel != nil ? addrsssModel.address : @""];
        _addressLB.numberOfLines = 0;
        _addressLB.frame = Rect(startXY, CGRectGetMaxY(_telLB.frame) + space, kWidth - 30, telH);
        _viewH += telAddVH;
    }else
    {
        telY = _viewH + spaace;
        _typeLB.text = @"自提";
        telAddVH = 30;
        telH = telAddVH - startXY * 2;
        _telLB.frame = Rect(startXY, telY, 200, telH);
        _addressLB.hidden = YES;
        _viewH += telAddVH;
    }
    _telLB.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel != nil ? addrsssModel.phone_num : @""];
    _typeLB.frame = Rect(kWidth - 10 - 60, telY, 60, telH);
    
    //line3
    _line3.frame = Rect(linxX, _viewH - 0.5, kWidth - linxX * 2, 0.5);
    _line3.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = CGRectGetMaxY(_line3.frame) + 1;
    
    // btn
    CGFloat btnGroupY = _viewH + startXY;
    
    CGFloat btnW = 90;
    _checkBtn.frame  = Rect(kWidth - 10 - btnW, btnGroupY, btnW, btnH);

    
    _line4.frame = Rect(0, btnGroupY + btnH + startXY, kWidth, 0.5);
    _line4.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = CGRectGetMaxY(_line4.frame);
}

- (CGFloat) getCellHeight
{
    return _viewH;
}

-(void)selClicked
{
    if ([self.delegate respondsToSelector:@selector(OrderCellBtnCliked: withOrderID:)]) {
        [self.delegate OrderCellBtnCliked:KOrderBtnClickedTypeDetal withOrderID:_data.ID ];
    }
}

@end

//
//  OrderDetailController.m
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderProductView.h"
#import "OrderDetailModel.h"
#import "OrderListAddressModel.h"
#import "SystemConfig.h"
#import "UserItem.h"


@interface OrderDetailController ()
{
    UIScrollView *_backScroll;
    CGFloat _viewH;
    OrderDetailModel *_data;
    UILabel *_time;
    UILabel *_transType;
    UILabel *_totalNum;
    UILabel *_mone;
    UILabel *_tel;
    UILabel *_address;
    UILabel *_nickName;
    UILabel *_dateLB;
    UILabel *_totalLB;
    UILabel *_telLB;
    UILabel *_addressLB;
    UIImageView *_icon;
}
@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    
    [self initBackView];
    [self loadData];
}

-(void) buildUI
{
    if ([[SystemConfig sharedInstance].user.type isEqualToString:@"1"]) {
        
        [self buildServerUI];
    }else
    {
        [self buildCustomUI];
    }
}

-(void)loadData
{
    //收支记录(getFlowRecord)
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;

    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:_orderID,@"order_id", nil];

    [HttpTool postWithPath:@"getOrderDetailInfo" params:parms success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            if (![data isKindOfClass:[NSNull class]]) {
                _data = [[OrderDetailModel alloc] initWithDictionary:data];
                [self buildUI];
            }else
            {
                
            }
        }else
        {

        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 底部scrollview
-(void) initBackView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:scroll];
    scroll.backgroundColor  = [UIColor whiteColor];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
}

-(void)buildCustomUI
{
    //1 time
    CGFloat startXY = 10;
    CGFloat firstViewH = 40;
    CGFloat timeH = (firstViewH - startXY)/2;
    
    UILabel *time = [[UILabel alloc] initWithFrame:Rect(startXY, startXY, 250, timeH)];
    [_backScroll addSubview:time];
    time.textColor = HexRGB(0x808080);
    time.font = [UIFont systemFontOfSize:14.0];
    time.text = [NSString stringWithFormat:@"下单时间：%@",_data.post_time];
    _time = time;
    
    CGFloat typeX = kWidth - startXY - 60;
    UILabel *transType = [[UILabel alloc] initWithFrame:Rect(typeX, startXY, 60, timeH)];
    [_backScroll addSubview:transType];
    transType.textColor = HexRGB(0x808080);
    transType.font = [UIFont systemFontOfSize:14.0];
    _transType = transType;
    
    CGFloat linxX = 3;
    UIView *line1 = [[UIView alloc] initWithFrame:Rect(linxX, CGRectGetMaxY(time.frame) + startXY - 1, kWidth - linxX * 2, 1)];
    [_backScroll addSubview:line1];
    line1.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = CGRectGetMaxY(line1.frame);
    //3 product
    NSUInteger count = _data.products.count;
    CGFloat proH = 100;
    for (int i = 0; i < count; i++) {
        OrderProductView *pro = [[OrderProductView alloc] init];
        pro.tagNum = i;
        pro.detailData = _data;
        CGFloat proY = CGRectGetMaxY(line1.frame);
        pro.frame = Rect(0, proY + proH * i, kWidth, proH);
        [_backScroll addSubview:pro];
        if (i == count - 1) {
            _viewH = CGRectGetMaxY(pro.frame);
        }
    }
    
    //3 middle view
    CGFloat bottomH = 40;
    UIView *bottomView = [[UIView alloc] initWithFrame:Rect(0, _viewH , kWidth, bottomH)];
    [_backScroll addSubview:bottomView];
    //    bottomView.backgroundColor = HexRGB(0xeeeeee);
    _viewH += bottomH;
    
    CGFloat totalX = 80;
    CGFloat totalY = 10;
    CGFloat totalH = bottomH - totalY * 2;
    UILabel *totalNum = [[UILabel alloc] initWithFrame:Rect(totalX, totalY, 120, totalH)];
    [bottomView addSubview:totalNum];
    totalNum.textColor = HexRGB(0x808080);
    totalNum.font = [UIFont systemFontOfSize:PxFont(Font20)];
    totalNum.text = [NSString stringWithFormat:@"共%@件",_data.total_num];
    _totalNum = totalNum;
    
    UILabel *totalCount = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(totalNum.frame) + 20, totalY, 60, totalH)];
    [bottomView addSubview:totalCount];
    totalCount.textColor = HexRGB(0x808080);
    totalCount.font = [UIFont systemFontOfSize:PxFont(Font20)];
    totalCount.text = @"总计： ";
    
    UILabel *mone = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(totalCount.frame) - 5, totalY, 90, totalH)];
    [bottomView addSubview:mone];
    mone.textColor = HexRGB(0x3a3a3a);
    mone.font = [UIFont systemFontOfSize:PxFont(Font24)];
    mone.text = [NSString stringWithFormat:@"¥ %@",_data.order_price];
    _mone = mone;
    
    UIView *line2 = [[UIView alloc] initWithFrame:Rect(linxX, _viewH - 1, kWidth - linxX * 2, 1)];
    [_backScroll addSubview:line2];
    line2.backgroundColor = HexRGB(KCellLineColor);
    
    CGFloat shippingY = _viewH + startXY;
    CGFloat vH = 45;
    CGFloat space = 5;
    CGFloat titleH = (vH - startXY * 2 - space);
    
    UILabel *tel = [[UILabel alloc] initWithFrame:Rect(startXY, shippingY, 200, titleH)];
    [_backScroll addSubview:tel];
    tel.textColor = HexRGB(0x808080);
    tel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    
    OrderListAddressModel *addrsssModel = nil;
    if (![_data.address isKindOfClass:[NSNull class]]) {
        addrsssModel = [[OrderListAddressModel alloc] initWithDictionary:_data.address];
    }
    
    tel.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel != nil ? addrsssModel.phone_num : @""];
    _tel = tel;
    
    CGFloat telY = CGRectGetMaxY(tel.frame) + space;
    UILabel *address = [[UILabel alloc] initWithFrame:Rect(startXY, telY, 200, titleH)];
    [_backScroll addSubview:address];
    address.textColor = HexRGB(0x808080);
    address.font = [UIFont systemFontOfSize:PxFont(Font20)];
    _address = address;
    
//    BOOL isWuliu = NO;
    if ([_data.express isEqualToString:@"1"]) {
        
        address.text = [NSString stringWithFormat:@"收货地址：%@",addrsssModel != nil ? addrsssModel.address : @""];
        transType.text = @"物流";
    }else
    {
        address.text = [NSString stringWithFormat:@"提货地址：%@",addrsssModel != nil ? addrsssModel.address : @""];
        transType.text = @"自提";
    }
    
    _viewH = CGRectGetMaxY(address.frame) + startXY;
    
    UIView *line3 = [[UIView alloc] initWithFrame:Rect(linxX, _viewH - 1, kWidth - linxX * 2, 1)];
    [_backScroll addSubview:line3];
    line3.backgroundColor = HexRGB(KCellLineColor);
    
    _backScroll.contentSize = CGSizeMake(kWidth, _viewH);
}

-(void)buildServerUI
{
    CGFloat startXY = 10;
    CGFloat firstViewH = 40;
    
    // 1 icon
    CGFloat iconX = startXY/2 ;
    CGFloat iconWH = firstViewH - iconX * 2;
    UIImageView *icon = [[UIImageView alloc] initWithFrame:Rect(iconX, iconX, iconWH, iconWH)];
    [_backScroll addSubview:icon];
    icon.backgroundColor = [UIColor clearColor];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = iconWH/2;
    _icon = icon;
    [_icon setImageWithURL:[NSURL URLWithString:[SystemConfig sharedInstance].user.avatar] placeholderImage:placeHoderImage];
    
    //2 nick name
    CGFloat nickX = CGRectGetMaxX(icon.frame) + 10;
    CGFloat timeH = (firstViewH - startXY)/2;
    UILabel *nickName = [[UILabel alloc] initWithFrame:Rect(nickX, startXY, 200, timeH)];
    [_backScroll addSubview:nickName];
    nickName.textColor = HexRGB(0x808080);
    nickName.font = [UIFont systemFontOfSize:14.0];
    nickName.text = [SystemConfig sharedInstance].user.userName;
    _nickName = nickName;
    
    //3 time
    CGFloat timeW = 170;
    CGFloat timeX = kWidth - startXY - timeW;
    UILabel *dateLB = [[UILabel alloc] initWithFrame:Rect(timeX, startXY, timeW, timeH)];
    [_backScroll addSubview:dateLB];
    dateLB.textColor = HexRGB(0x808080);
    dateLB.font = [UIFont systemFontOfSize:14.0];
    dateLB.text = [NSString stringWithFormat:@"%@",_data.post_time];
    _dateLB = dateLB;
    
    //4 first line
    CGFloat linxX = 3;
    UIView *line1 = [[UIView alloc] initWithFrame:Rect(linxX, firstViewH - 1, kWidth - linxX * 2, 1)];
    [_backScroll addSubview:line1];
    line1.backgroundColor = HexRGB(KCellLineColor);
    
    //5 product view
    int count = 2;
    CGFloat proH = 100;
    for (int i = 0; i < count; i++) {
        OrderProductView *pro = [[OrderProductView alloc] init];
        CGFloat proY = CGRectGetMaxY(line1.frame);
        pro.tagNum = i;
        pro.detailData = _data;
        pro.frame = Rect(0, proY + proH * i, kWidth, proH);
        [_backScroll addSubview:pro];
        if (i == count - 1) {
            _viewH = CGRectGetMaxY(pro.frame);
        }
    }
    
    //6 total
    CGFloat moneyW = 60;
    CGFloat toX = kWidth - 10 - moneyW - moneyW;
    UILabel *total = [[UILabel alloc] initWithFrame:Rect(toX, _viewH + startXY, moneyW, timeH)];
    [_backScroll addSubview:total];
    total.text = @"总计：";
    total.textColor = HexRGB(0x808080);
    total.font = [UIFont systemFontOfSize:14.0];
    
    UILabel  *totalLB = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(total.frame), total.frame.origin.y, moneyW, timeH)];
    [_backScroll addSubview:totalLB];
    totalLB.text = [NSString stringWithFormat:@"¥ %@",_data.order_price];
    totalLB.textColor = HexRGB(0x808080);
    totalLB.font = [UIFont systemFontOfSize:14.0];
    _totalLB = totalLB;
    
    UIView *line2 = [[UIView alloc] initWithFrame:Rect(linxX, _viewH + firstViewH - 1, kWidth - linxX * 2, 1)];
    [_backScroll addSubview:line2];
    line2.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = CGRectGetMaxY(line2.frame) + 1;
    
    //  电话 收货地址
    CGFloat telY = 0;
    
    UILabel *typeLB = [[UILabel alloc] initWithFrame:CGRectZero];
    typeLB.textColor = HexRGB(0x808080);
    typeLB.font = [UIFont systemFontOfSize:14.0];
    [_backScroll addSubview:typeLB];
    
    UILabel *telLB = [[UILabel alloc] initWithFrame:CGRectZero];
    [_backScroll addSubview:telLB];
    telLB.textColor = HexRGB(0x808080);
    telLB.font = [UIFont systemFontOfSize:14.0];
    _telLB = telLB;
    
    UILabel *addressLB = [[UILabel alloc] initWithFrame:CGRectZero];
    [_backScroll addSubview:addressLB];
    addressLB.textColor = HexRGB(0x808080);
    addressLB.font = [UIFont systemFontOfSize:14.0];
    _addressLB = addressLB;
    
    [_backScroll addSubview:telLB];
    
    OrderListAddressModel *addrsssModel = nil;
    if (![_data.address isKindOfClass:[NSNull class]]) {
        addrsssModel = [[OrderListAddressModel alloc] initWithDictionary:_data.address];
    }
    
    CGFloat telH;
    CGFloat telAddVH;
//    BOOL isWuliu = NO;
    if ([_data.express isEqualToString:@"1"]) {
        telY = _viewH + startXY;
        telAddVH = 50;
        CGFloat space = 15;
        telH = (telAddVH - startXY * 2 - space)/2;
        telLB.frame = Rect(startXY, telY, 200, telH);
        typeLB.text = @"物流";
        addressLB.hidden = NO;
        addressLB.text = [NSString stringWithFormat:@"收货地址：%@",addrsssModel != nil ? addrsssModel.address : @""];

        addressLB.numberOfLines = 0;
        addressLB.frame = Rect(startXY, CGRectGetMaxY(telLB.frame) + space, kWidth - 30, telH);
        _viewH += telAddVH;
    }else
    {
        telY = _viewH + startXY;
        typeLB.text = @"自提";
        telAddVH = 30;
        telH = telAddVH - startXY * 2;
        telLB.frame = Rect(startXY, telY, 200, telH);
        addressLB.hidden = YES;
        _viewH += telAddVH;
    }
    telLB.text = [NSString stringWithFormat:@"联系电话：%@",addrsssModel != nil ? addrsssModel.phone_num : @""];

    typeLB.frame = Rect(kWidth - 10 - 60, telY, 60, telH);
    
    //line3
    UIView *line3 = [[UIView alloc] initWithFrame:Rect(linxX, _viewH - 1, kWidth - linxX * 2, 1)];
    [_backScroll addSubview:line3];
    line3.backgroundColor = HexRGB(KCellLineColor);
    
    _viewH = CGRectGetMaxY(line3.frame) + 1;
    
    // btn
    if ([_data.express isEqualToString:@"1"]) {
        CGFloat btnGroupY = _viewH + startXY;
        CGFloat btnW = 90;
        CGFloat btnH = 28;
        NSArray *titles = @[@"确认发货"];
        CGFloat btnXX = kWidth - (10 + btnW) * titles.count;
        for (int i = 0; i < titles.count; i++) {
            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [_backScroll addSubview:btn];
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5.0;
            btn.layer.borderWidth = 1.0;
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitle:titles[i] forState:UIControlStateSelected];
            [btn setTitle:titles[i] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(DoneConform) forControlEvents:UIControlEventTouchUpInside];
            btn.frame  = Rect(btnXX + (btnW + 10) * i, btnGroupY, btnW, btnH);
        }
        
        UIView *line4 = [[UIView alloc] initWithFrame:Rect(0, btnGroupY + btnH + startXY, kWidth, 1)];
        [_backScroll addSubview:line4];
        line4.backgroundColor = HexRGB(KCellLineColor);
        
        _viewH = CGRectGetMaxY(line4.frame);
    }
    _backScroll.contentSize = CGSizeMake(kWidth, _viewH);
}

-(void)DoneConform
{
    
}
@end

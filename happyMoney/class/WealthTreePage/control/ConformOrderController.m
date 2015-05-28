//
//  ConformOrderController.m
//  happyMoney
//  确认订单
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ConformOrderController.h"
#import "ConformProductItemView.h"
#import "WuliuView.h"
#import "UseStyleView.h"
#import "ConformBottomView.h"
#import "SelectAddressController.h"
#import "DefaultAddressModel.h"
#import "couponModel.h"
#import "ProductDetailModel.h"
#import "selfAddressView.h"
#import "NoAddressView.h"
#import "AddAddressController.h"
#import "MyOrderController.h"
#import "UseHongbaoView.h"
#import "SystemConfig.h"

#define KStartX 20
#define KStartTag 100
#define KWuliu  101
#define KZIti   100

@interface ConformOrderController ()<NoAddressViewDelegate,UseHongbaoDelegate,UseStyleDelegate>
{
    CGFloat _orderListViewH ;//订单列表的高度
    BOOL _isMore;//是否已经显示完全
    CGFloat _viewH ;
    couponModel *_coupon;
    NSMutableArray *_coupList;
    UIView *_selectedBackView;
    CGFloat wuliuY;
    selfAddressView *_selfView;
    WuliuView *_wuliuView;
    UseStyleView *_pay;
    UseHongbaoView *_use;
    UILabel *_consume;
    UIButton *_checkBtn;
    UIButton *_selectedBtn;
    UIScrollView *_backScroll;
    NoAddressView *_noaddress;
    UIView *clickBackView;//点击展开全部view
    UILabel *_style;
    UILabel *_useHongbao;
    UIButton *_ziti;
    UIButton *_wuliu;
    BOOL isExpand;// 是否已经展开
    UIButton *_expandBtn;
    UIView *_orderListView;
    UILabel *_click;
    NSInteger _payMethod;
}
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *selfAddress;//自提地址
@property (nonatomic,copy) NSString *type;//自提还是物流

-(void)styleBtnClicked:(UIButton *)btn;
@end

@implementation ConformOrderController

- (void)viewWillAppear:(BOOL)animated
{
    if (_backScroll) {
        //如果，还是没有地址,且选中的按钮是自提
        //提示还没有收获地址

//        if (_address == nil && _selectedBtn.tag == KWuliu) {
//            if (!_noaddress) {
//                _noaddress = [[NoAddressView alloc] initWithFrame:Rect(0, 0, kWidth, 300)];
//                _noaddress.delegate = self;
//                [_noaddress show];
//            }else
//            {
//                [_noaddress show];
//            }
//        }else
//        {
//            if (_wuliuView) {
//                [self clickWuliu];
//                _wuliuView.data = _address;
//            }
//        }
        
        if (_selectedBtn.tag == KWuliu) {
            if (_address == nil) {
                if (!_noaddress) {
                    _noaddress = [[NoAddressView alloc] initWithFrame:Rect(0, 0, kWidth, 300)];
                    _noaddress.delegate = self;
                    [_noaddress show];
                }else
                {
                    [_noaddress show];
                }
            }else
            {
                [self clickWuliu];
//                _wuliuView.data = _address;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    _type = @"0";
    _payMethod = 1;//默认是微信
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KContentH)];
    [self.view addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
    
    [self loadData];
}

-(void)loadData
{
    //拉取默认地址
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;

    [HttpTool postWithPath:@"getOrderDetail" params:nil success:^(id JSON, int code) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (code == 100) {
            //address list
            NSDictionary *addressData = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"address"];
            if (![addressData isKindOfClass:[NSNull class]]) {
                if (!_address) {
                     _address = [[DefaultAddressModel alloc] initWithDictionary:addressData];
                }
            }
            /*
            if (!_coupList) {
                _coupList = [NSMutableArray arrayWithCapacity:5];
            }
            //优惠券
            NSDictionary *cDic = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            NSDictionary *coupData = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"couponList"];
            
            if (!isNull(cDic,@"couponList")) {
                NSArray *coupData = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"couponList"];
                for (NSDictionary *dict in coupData) {
                    couponModel *coup = [[couponModel alloc] initWithDictionary:dict];
                    [_coupList addObject:coup];
                }
            }*/
            if ([[[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"money"] isKindOfClass:[NSNull class]]) {
                _money = @"0";
            }else
            {
                _money = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"money"];
            }
            
            _selfAddress = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"self_get_address"];
//            [self buildUI];
            [self getCouponList];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)getCouponList
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.dimBackground = NO;
    
    [HttpTool postWithPath:@"getCouponList" params:nil success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (code == 100) {
            //address list
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            //优惠券
            if (![data isKindOfClass:[NSNull class]]) {
                if (data.count > 0) {
                    if (!_coupList) {
                        _coupList = [NSMutableArray arrayWithCapacity:5];
                    }
                    
                    for (NSDictionary *dict in data) {
                        couponModel *coup = [[couponModel alloc] initWithDictionary:dict];
                        [_coupList addObject:coup];
                    }
                }
            }
        }
        [self buildUI];
    } failure:^(NSError *error) {
        [self buildUI];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void) buildUI
{
    _isMore = NO;//是否需要展开
    CGFloat orderViewH = 100;
    NSUInteger orderCounte = _OrderDataList.count;
    if (orderCounte > 2) {
        _isMore = YES;
        isExpand = NO;
        _orderListViewH = orderViewH * 2;
    }else
    {
        _orderListViewH = orderViewH * _OrderDataList.count;
    }
    _viewH = 0;
    
    CGFloat startX = 20;
    //1 订单列表
    UIView *orderListView = [[UIView alloc] init];
    orderListView.frame = Rect(0, 0, kWidth, _orderListViewH);
    [_backScroll addSubview:orderListView];
    _orderListView = orderListView;
    
    for (int i = 0; i < orderCounte; i++) {
        CGFloat orderY = i * orderViewH;
        ConformProductItemView *item = [[ConformProductItemView alloc] initWithFrame:Rect(0, orderY, kWidth, orderViewH)];
        item.tag = i;
        item.data = self.OrderDataList[i];
        [orderListView addSubview:item];
        if (i > 1) {
            item.hidden = YES;
        }
    }
    _viewH = _orderListViewH;
    
    //展开按钮
    if (_isMore) {
        CGFloat backH = 40;
        UIView *backView = [[UIView alloc] initWithFrame:Rect(0, _viewH, kWidth, backH)];
        clickBackView = backView;
        [_backScroll addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        
        UILabel *click = [[UILabel alloc] initWithFrame:Rect(kWidth/2 - 60, 0, 120, 40)];
        click.text = @"点击展开全部";
        [backView addSubview:click];
        click.textColor = HexRGB(0x808080);
        click.font  =  [UIFont systemFontOfSize:PxFont(Font20)];
        click.backgroundColor = [UIColor clearColor];
        _click = click;
        
        UIButton *expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat exPandBtnY = 5;
        expandBtn.frame = Rect(CGRectGetMaxX(click.frame) - 35, exPandBtnY, 30, 30);
        [backView addSubview:expandBtn];
        expandBtn.enabled = YES;
        [expandBtn setImage:[UIImage imageNamed:@"确认订单"] forState:UIControlStateNormal];
        [expandBtn addTarget:self action:@selector(expandClicked:) forControlEvents:UIControlEventTouchUpInside];
        expandBtn.backgroundColor  = [UIColor clearColor];
        _expandBtn = expandBtn;
        
        UIView *expandLine = [[UIView alloc] init];
        expandLine.frame = Rect(0, backH, kWidth, 1);
        [backView addSubview:expandLine];
        expandLine.backgroundColor = HexRGB(KCellLineColor);
        _viewH += backH;
    }
    //收货方式view
    
    
    
    CGFloat styleY = _viewH + 10;
    UILabel *style = [[UILabel alloc] initWithFrame:Rect(startX, styleY, 100, 30)];
    [_backScroll addSubview:style];
    [style setText:@"收货方式:"];
    style.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
    style.textColor = HexRGB(0x3a3a3a);
    style.backgroundColor = [UIColor clearColor];
    _style = style;
    
    UIView *selectedBackView = [[UIView alloc] init];
    selectedBackView.layer.masksToBounds = YES;
    selectedBackView.layer.cornerRadius = 5.0f;
    selectedBackView.backgroundColor = [UIColor whiteColor];
    selectedBackView.layer.borderColor = HexRGB(KCellLineColor).CGColor;
    selectedBackView.layer.borderWidth = 0.5;
    _selectedBackView = selectedBackView;

    NSArray *btnTitles = @[@"自提",@"物流"];
    CGFloat btnX = CGRectGetMaxX(style.frame) + 15;
    CGFloat btnW = 60;
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnX = btnX + (btnW + 10)* i;
        btn.frame = Rect(btnX, styleY, btnW, 30);
        if (i == 0) {
            btn.selected = YES;
            btn.backgroundColor = [UIColor clearColor];
            _selectedBackView.frame = btn.frame;
            _selectedBtn = btn;
            [_backScroll addSubview:_selectedBackView];
            _ziti = btn;
        }else
        {
            _wuliu = btn;
        }
        [_backScroll addSubview:btn];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(styleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + KStartTag;
    }
    
    CGFloat selfUseViewY = CGRectGetMaxY(style.frame) + 10;
    wuliuY = selfUseViewY;
    
    //默认是自提
    selfAddressView *selfUseView = [[selfAddressView alloc] initWithFrame:Rect(startX, selfUseViewY, kWidth - startX * 2, 40)];
    [_backScroll addSubview:selfUseView];
    selfUseView.selfAddLB.text = [NSString stringWithFormat:@"提货地址：%@",[self.selfAddress isKindOfClass:[NSNull class]] ? @"" :_selfAddress];
//    selfUseView.selfAddLB.text = [NSString stringWithFormat:@"提货地址：%@",_address];
    _selfView = selfUseView;
    
    //使用红包
    CGFloat userHongY = CGRectGetMaxY(selfUseView.frame)+ 10;
    UILabel *useHongbaoLb = [[UILabel alloc] initWithFrame:Rect(startX, userHongY, 100, 30)];
    [_backScroll addSubview:useHongbaoLb];
    [useHongbaoLb setText:@"使用红包:"];
//    useHongbaoLb.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
    useHongbaoLb.textColor = HexRGB(0x3a3a3a);
    useHongbaoLb.backgroundColor = [UIColor clearColor];
    _useHongbao = useHongbaoLb;

    //hongbao  btn
    
    CGFloat typeH = 30 * 3;
    UseHongbaoView *type = [[UseHongbaoView alloc] initWithFrame:Rect(CGRectGetMaxX(useHongbaoLb.frame) + 7, userHongY, 160, typeH) wihtData:3];
    type.delegate = self;
    [_backScroll addSubview:type];
    _use = type;
    
    CGFloat consuY = CGRectGetMaxY(type.frame) + 10;
    UILabel *consume = [[UILabel alloc] initWithFrame:Rect(startX, consuY, 250, 30)];
    [_backScroll addSubview:consume];
    consume.adjustsFontSizeToFitWidth = YES;
    consume.text = [NSString stringWithFormat:@"使用收入消费（账户余额%@）",_money];
    consume.textColor = HexRGB(0x808080);
    consume.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
    _consume = consume;
    consume.backgroundColor = [UIColor clearColor];
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = Rect(kWidth - 30 * 2, consuY + 2, 25, 25);
    [checkBtn setImage:LOADPNGIMAGE(@"地址未选中") forState:UIControlStateNormal];
    [checkBtn setImage:LOADPNGIMAGE(@"地址选中") forState:UIControlStateSelected];
    [checkBtn addTarget:self action:@selector(chenkClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_backScroll addSubview:checkBtn];
    _checkBtn = checkBtn;
    
    //支付方式
    UseStyleView *pay = [[UseStyleView alloc] initWithFrame:Rect(startX, CGRectGetMaxY(checkBtn.frame)+ 10, kWidth - startX, 80) userStyle:2];
    pay.delegate = self;
    pay.backgroundColor = [UIColor clearColor];
    [_backScroll addSubview:pay];
    _pay = pay;
    
    _viewH = CGRectGetMaxY(pay.frame) + 20;
    _backScroll.contentSize = CGSizeMake(kWidth, _viewH);
    
    //3 底部状态栏
    ConformBottomView *bottom = [[ConformBottomView alloc] initWithFrame:Rect(0, KAppHeight - 44 - 44, kWidth, 44)];
    [self.view addSubview:bottom];
    bottom.totalPrice = [self caculateTotalPrice];
//    bottom.data = _data;
    [bottom.conformBtn addTarget:self action:@selector(confromOrder) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark UseStyleDelegate
-(void)UserStyleWithIndex:(NSInteger)index
{
    NSLog(@"支付方式第%ld",index);
    if (index == 0) {
        _payMethod = 1;
    }else
    {
        _payMethod = 0;
    }
}

#pragma mark 红包点击
- (void)useHongBaoClicked:(NSInteger)tag
{
    NSLog(@"红包点击第%ld",tag);
}

- (CGFloat)caculateTotalPrice
{
    CGFloat totalP = 0.0;
    for (int i = 0;  i < _OrderDataList.count; i++) {
        ProductDetailModel *data = _OrderDataList[i];
        CGFloat price = [data.price floatValue];
        CGFloat proNum = data.productCount;
        totalP += proNum * price;
    }
    return totalP;
}
#pragma mark 提交订单
-(void)confromOrder
{
    //拉取分类列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    //拼接products字符串 1_3,2_4,6_1
    NSMutableString *parm = [NSMutableString string];
    CGFloat totalP = 0.0;
    for (int i = 0;  i < _OrderDataList.count; i++) {
        ProductDetailModel *data = _OrderDataList[i];
        NSString *proId = data.ID;
        int proNum = data.productCount;
        CGFloat price = [data.price floatValue];
        totalP += proNum * price;
        NSString *str = [NSMutableString stringWithFormat:@"%@_%d",proId,proNum];
        if (i != _OrderDataList.count - 1) {
            [parm appendString:str];
            [parm appendString:@","];
        }else
        {
            [parm appendString:str];
        }
    }

    NSString *type = [NSString stringWithFormat:@"%ld",(long)_selectedBtn.tag - KStartTag];

    NSString *address_id = _address.ID;
    NSString *pay_methord = [NSString stringWithFormat:@"%ld",_payMethod];

    NSString *coupon_id = @"2";
    NSString *total_price  = [NSString stringWithFormat:@"%f",totalP];
    NSString *use_virtual = @"0";
    if (_checkBtn.selected == YES) {
        use_virtual = @"1";;
    }
    
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:parm,@"products",type,@"express",address_id,@"address_id",pay_methord,@"pay_method",coupon_id,@"coupon_id",total_price,@"total_price",use_virtual,@"use_virtual",nil];
    
    NSLog(@"%@",parms);
    [HttpTool postWithPath:@"postOrder" params:parms success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
//            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
//            NSString *needPay = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"need_pay"];
//            NSString *orderID = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"order_id"];
            [RemindView showViewWithTitle:@"成功提交订单" location:MIDDLE];
            MyOrderController *ctl = [[MyOrderController alloc] init];
            [self.navigationController pushViewController:ctl animated:YES];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 点击自提
-(void) clickZiti
{
    UIButton *btn  = (UIButton *)[_backScroll viewWithTag:KZIti];
    [self styleBtnClicked:btn];
}

#pragma mark 点击物流
-(void) clickWuliu
{
    UIButton *btn  = (UIButton *)[_backScroll viewWithTag:KWuliu];
//    btn.selected  = YES;
    
    _type = @"1";
    [_selfView removeFromSuperview];
    
    wuliuY = CGRectGetMaxY(_style.frame) + 10;
    WuliuView *wuliu = [[WuliuView alloc] initWithFrame:Rect(KStartX, wuliuY, kWidth - KStartX * 2, 150) withBlock:^{
        //收货地址
        SelectAddressController *sa = [[SelectAddressController alloc] init];
        [self.navigationController pushViewController:sa animated:YES];
    }];
    wuliu.data = _address;
    [_backScroll addSubview:wuliu];
    _wuliuView = wuliu;
    
    CGRect hongbaoRect = _useHongbao.frame;
    hongbaoRect.origin.y = CGRectGetMaxY(wuliu.frame) + 10;
    _useHongbao.frame = hongbaoRect;
    
    CGRect useRect = _use.frame;
    useRect.origin.y = CGRectGetMaxY(wuliu.frame) + 10;
    _use.frame = useRect;
    
    CGRect conRect = _consume.frame;
    conRect.origin.y = CGRectGetMaxY(_use.frame) + 10;
    _consume.frame = conRect;
    
    CGRect checkRect = _checkBtn.frame;
    checkRect.origin.y = conRect.origin.y + 2;
    _checkBtn.frame = checkRect;
    
    CGRect payRect = _pay.frame;
    payRect.origin.y = CGRectGetMaxY(_checkBtn.frame) + 10;
    _pay.frame = payRect;
    [UIView animateWithDuration:0.5 animations:^{
        _selectedBackView.frame = btn.frame;
    }];
    _backScroll.contentSize = CGSizeMake(kWidth, CGRectGetMaxY(_pay.frame) + 10);
    
    
}
#pragma mark 使用收入消费
-(void)chenkClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

#pragma mark 回到自提页面
-(void)later
{
    [_noaddress dismiss];
    [self clickZiti];
}

#pragma mark 添加地址
- (void)add
{
    [_noaddress dismiss];
     //这里设置是从确认订单页面进入增加地址的
    [SystemConfig sharedInstance].isFormConformOrder = YES;
    AddAddressController *add = [[AddAddressController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

#pragma mark 物流 自提 按钮点击
-(void)styleBtnClicked:(UIButton *)btn
{
    if (_selectedBtn != btn) {
        _selectedBtn.selected = NO;
        btn.selected = !btn.selected;
        _selectedBtn = btn;
        
        if (btn.tag == KWuliu) {
            //物流
            
            if (_address) {
                _type = @"1";
                [_selfView removeFromSuperview];
                
                wuliuY = CGRectGetMaxY(_style.frame) + 10;
                WuliuView *wuliu = [[WuliuView alloc] initWithFrame:Rect(KStartX, wuliuY, kWidth - KStartX * 2, 150) withBlock:^{
                    //收货地址
                    SelectAddressController *sa = [[SelectAddressController alloc] init];
                    [self.navigationController pushViewController:sa animated:YES];
                }];
                wuliu.data = _address;
                [_backScroll addSubview:wuliu];
                _wuliuView = wuliu;
                
                CGRect hongbaoRect = _useHongbao.frame;
                hongbaoRect.origin.y = CGRectGetMaxY(wuliu.frame) + 10;
                _useHongbao.frame = hongbaoRect;
                
                CGRect useRect = _use.frame;
                useRect.origin.y = CGRectGetMaxY(wuliu.frame) + 10;
                _use.frame = useRect;
            }else
            {
                //还没有添加任何地址
                if (!_noaddress) {
                    _noaddress = [[NoAddressView alloc] initWithFrame:Rect(0, 0, kWidth, 300)];
                    _noaddress.delegate = self;
                    [_noaddress show];

                }else
                {
                    [_noaddress show];
                }
            }
        }else
        {
            //自提
            [_wuliuView removeFromSuperview];
            
            wuliuY = CGRectGetMaxY(_style.frame) + 10;
            selfAddressView *selfUseView = [[selfAddressView alloc] initWithFrame:Rect(KStartX, wuliuY, kWidth - KStartX * 2, 40)];
            [_backScroll addSubview:selfUseView];
            NSLog(@"%@",_selfAddress);
             ;
            selfUseView.selfAddLB.text = [NSString stringWithFormat:@"提货地址：%@",[self.selfAddress isKindOfClass:[NSNull class]] ? @"" :_selfAddress];
            _selfView = selfUseView;
            
            CGRect hongbaoRect = _useHongbao.frame;
            hongbaoRect.origin.y = CGRectGetMaxY(selfUseView.frame) + 10;
            _useHongbao.frame = hongbaoRect;
            
            CGRect useRect = _use.frame;
            useRect.origin.y = CGRectGetMaxY(selfUseView.frame) + 10;
            _use.frame = useRect;
            
//            _use.frame = Rect(KStartX, CGRectGetMaxY(selfUseView.frame) + 10, 200, 80);
            _type = @"0";
        }
        CGRect conRect = _consume.frame;
        conRect.origin.y = CGRectGetMaxY(_use.frame) + 10;
        _consume.frame = conRect;
        
        CGRect checkRect = _checkBtn.frame;
        checkRect.origin.y = conRect.origin.y + 2;
        _checkBtn.frame = checkRect;
        
        CGRect payRect = _pay.frame;
        payRect.origin.y = CGRectGetMaxY(_checkBtn.frame) + 10;
        _pay.frame = payRect;
        [UIView animateWithDuration:0.5 animations:^{
            _selectedBackView.frame = btn.frame;
        }];
        _backScroll.contentSize = CGSizeMake(kWidth, CGRectGetMaxY(_pay.frame) + 10);
    }
}

#pragma mark 向下移动
-(void) downTranserfor:(CGFloat)down
{
    CGRect clickViewRect = clickBackView.frame;
    clickViewRect.origin.y += down;
    clickBackView.frame = clickViewRect;
    
    CGRect styleRect = _style.frame;
    styleRect.origin.y += down;
    _style.frame = styleRect;
    
    CGRect selectedBtnRect = _selectedBackView.frame;
    selectedBtnRect.origin.y += down;
    _selectedBackView.frame = selectedBtnRect;
    
    CGRect zitiRect = _ziti.frame;
    zitiRect.origin.y += down;
    _ziti.frame = zitiRect;
    
    CGRect wuliuRect = _wuliu.frame;
    wuliuRect.origin.y += down;
    _wuliu.frame = wuliuRect;
    
    //判断是物流还是自提
    if (_selectedBtn.tag == KWuliu) {
        CGRect wuliuRect = _wuliuView.frame;
        wuliuRect.origin.y += down;
        _wuliuView.frame = wuliuRect;
    }else
    {
        CGRect selfViewRect = _selfView.frame;
        selfViewRect.origin.y += down;
        _selfView.frame = selfViewRect;
    }
    
    
    CGRect hongbaoRect = _useHongbao.frame;
    hongbaoRect.origin.y += down;
    _useHongbao.frame = hongbaoRect;
    
    CGRect useRect = _use.frame;
    useRect.origin.y += down;
    _use.frame = useRect;
    
    CGRect consumeRect = _consume.frame;
    consumeRect.origin.y += down;
    _consume.frame = consumeRect;
    
    CGRect checkRect = _checkBtn.frame;
    checkRect.origin.y += down;
    _checkBtn.frame = checkRect;
    
    CGRect payRect = _pay.frame;
    payRect.origin.y += down;
    _pay.frame = payRect;
}

#pragma mark 向上移动
-(void) upTranserfor :(CGFloat)down
{
    CGRect clickViewRect = clickBackView.frame;
    clickViewRect.origin.y -= down;
    clickBackView.frame = clickViewRect;
    
    CGRect styleRect = _style.frame;
    styleRect.origin.y -= down;
    _style.frame = styleRect;
    
    CGRect selectedBtnRect = _selectedBackView.frame;
    selectedBtnRect.origin.y -= down;
    _selectedBackView.frame = selectedBtnRect;
    
    CGRect zitiRect = _ziti.frame;
    zitiRect.origin.y -= down;
    _ziti.frame = zitiRect;
    
    CGRect wuliuRect = _wuliu.frame;
    wuliuRect.origin.y -= down;
    _wuliu.frame = wuliuRect;
    
    
    if (_selectedBtn.tag == KWuliu) {
        CGRect wuliuRect = _wuliuView.frame;
        wuliuRect.origin.y -= down;
        _wuliuView.frame = wuliuRect;
    }else
    {
        CGRect selfViewRect = _selfView.frame;
        selfViewRect.origin.y -= down;
        _selfView.frame = selfViewRect;
    }
    
    CGRect hongbaoRect = _useHongbao.frame;
    hongbaoRect.origin.y -= down;
    _useHongbao.frame = hongbaoRect;
    
    CGRect useRect = _use.frame;
    useRect.origin.y -= down;
    _use.frame = useRect;
    
    CGRect consumeRect = _consume.frame;
    consumeRect.origin.y -= down;
    _consume.frame = consumeRect;
    
    CGRect checkRect = _checkBtn.frame;
    checkRect.origin.y -= down;
    _checkBtn.frame = checkRect;
    
    CGRect payRect = _pay.frame;
    payRect.origin.y -= down;
    _pay.frame = payRect;
}

#pragma mark 点击展开全部
-(void)expandClicked:(UIButton *)btn{
    isExpand = !isExpand;
    if (isExpand) {
        //准备展开
        [btn setImage:LOADPNGIMAGE(@"确认订单2") forState:UIControlStateNormal];
        _click.text = @"点击收起";
        // 1显示隐藏的item
        for (UIView *view in _orderListView.subviews) {
            if ([view isKindOfClass:[ConformProductItemView class]]) {
                ConformProductItemView *item = (ConformProductItemView *)view;
                item.hidden = NO;
            }
        }
        // 2 所有的view向下移动超过2的所有item高度
        CGFloat down = 100 *  (_OrderDataList.count - 2);
        [self downTranserfor:down];
        CGFloat contengH = _viewH + down;
        _backScroll.contentSize = CGSizeMake(kWidth,  contengH);
    }else
    {
        // 1隐藏超过2的item
        _click.text = @"点击展开全部";
        for (UIView *view in _orderListView.subviews) {
            if ([view isKindOfClass:[ConformProductItemView class]]) {
                ConformProductItemView *item = (ConformProductItemView *)view;
                if (item.tag > 1) {
                    item.hidden = YES;
                }
            }
        }
        [btn setImage:LOADPNGIMAGE(@"确认订单") forState:UIControlStateNormal];
         CGFloat down = 100 *  (_OrderDataList.count - 2);
        [self upTranserfor:down];
        CGFloat contengH = _viewH;
        _backScroll.contentSize = CGSizeMake(kWidth,  contengH);
    }
}
@end

//
//  ProductDetailController.m
//  happyMoney
//  产品详情
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ProductDetailController.h"
#import "ConformOrderController.h"
#import "BuycarController.h"
#import "ProductDetailModel.h"
#import "BBBadgeBarButtonItem.h"
#import "CarTool.h"
#import "ProductDetailModel.h"
#import "TGCenterLineLabel.h"
#import "SystemConfig.h"
#import "LoginController.h"
#import "UserItem.h"

@interface ProductDetailController ()
{
    UIScrollView *_backScroll;
    ProductDetailModel *_detail;
    UIButton *showBtn;
    UIButton *addBtn;
    UIButton *reduceBtn;
    int _totaNum;
    int _buyCount;//加入购物车数量
    int _showBtnCount;//加减后显示的数量
}
@end

@implementation ProductDetailController

-(void)viewWillAppear:(BOOL)animated
{
    if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"] || ![SystemConfig sharedInstance].isUserLogin)
    {
        //1 计算购物车数量
        if (self.navigationItem.rightBarButtonItem) {
            BBBadgeBarButtonItem *barButton = (BBBadgeBarButtonItem *)self.navigationItem.rightBarButtonItem;
            barButton.badgeValue = [NSString stringWithFormat:@"%ld", (long)[self totalCarNum] ];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"产品详情";
    
    _buyCount = 0;
    _showBtnCount = 1;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KAppNoTabHeight)];
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

#pragma mark 进入购物车
-(void)orderFood
{
    BuycarController *ctl = [[BuycarController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void) loadData
{
    //拉取分类列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:_ID,@"id",nil];
    [HttpTool postWithPath:@"getProductDetail" params:parm success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            _detail = [[ProductDetailModel alloc] initWithDictionary:data];
        }
        [self buildUI];
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)buildUI
{
    CGFloat scorllH = 0;
    UIButton *foodcar = [UIButton buttonWithType:UIButtonTypeCustom];
    foodcar.frame = Rect(0, 0, 30, 30);
    [foodcar addTarget:self action:@selector(orderFood) forControlEvents:UIControlEventTouchUpInside];
    [foodcar setBackgroundImage:LOADPNGIMAGE(@"Bcar") forState:UIControlStateNormal];
    
    if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"] || ![SystemConfig sharedInstance].isUserLogin)
    {
        BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomView:foodcar];
        
        barButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)[self totalCarNum]];
        barButton.badgeBGColor = [UIColor whiteColor];
        barButton.badgeTextColor = HexRGB(0x899c02);
        barButton.badgeFont = [UIFont systemFontOfSize:11.5];
        barButton.badgeOriginX = 20;
        barButton.badgeOriginY = 0;
        barButton.shouldAnimateBadge = YES;
        self.navigationItem.rightBarButtonItem = barButton;
    }
    
    //2 产品图片
    UIImageView *productView = [[UIImageView alloc] initWithFrame:CGRectZero];
    productView.frame = Rect(0, 0, kWidth, 200);
    productView.backgroundColor  = [UIColor clearColor];
    [_backScroll addSubview:productView];
    [productView setImageWithURL:[NSURL URLWithString:_detail.image] placeholderImage:[UIImage imageNamed:@""]];
    
    //3 产品标题
    CGFloat startX = 20;
    UILabel *title = [[UILabel alloc] init];
    CGFloat titleY = CGRectGetMaxY(productView.frame) + 10;
    CGFloat titleW = kWidth - startX - 20;
    title.frame = Rect(startX, titleY, titleW, 30);
    title.text = _detail.name;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = HexRGB(0x3a3a3a);
    title.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
    [_backScroll addSubview:title];
    title.adjustsFontSizeToFitWidth = YES;
    title.numberOfLines = 2;
    //3 现价
    UILabel *newPrice = [[UILabel alloc] init];
    CGFloat newPriceY = CGRectGetMaxY(title.frame) + 10;
    newPrice.frame = Rect(startX, newPriceY, 100, 25);
    [_backScroll addSubview:newPrice];
    newPrice.text = [NSString stringWithFormat:@"¥ %@",_detail.price];
    newPrice.textColor = HexRGB(0xff7c70);
    newPrice.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
    newPrice.backgroundColor = [UIColor clearColor];
    //3 原价
    TGCenterLineLabel *oldPrice = [[TGCenterLineLabel alloc] init];
    CGFloat oldPriceX = CGRectGetMaxX(newPrice.frame);
    [_backScroll addSubview:oldPrice];
    oldPrice.frame = Rect(oldPriceX, newPriceY, 100, 25);
    oldPrice.textColor = HexRGB(0x808080);
    oldPrice.font = [UIFont boldSystemFontOfSize:PxFont(Font22)];
    oldPrice.text = [NSString stringWithFormat:@"¥%@", _detail.old_price];
    oldPrice.backgroundColor = [UIColor clearColor];
    //4 分割线
    UIView *firstLine = [[UIView alloc] init];
    firstLine.backgroundColor = HexRGB(KCellLineColor);
    CGFloat firstLineX = startX - 3;
    firstLine.frame = Rect(firstLineX, CGRectGetMaxY(newPrice.frame) + 5, kWidth - firstLineX * 2, 1);
    [_backScroll addSubview:firstLine];
    
    scorllH = CGRectGetMaxY(firstLine.frame);
    
    
    if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"] || ![SystemConfig sharedInstance].isUserLogin) {
       //代理商没有购买的要求
        //5 购买标题
        CGFloat distence = 20;
        
        UILabel *buyTitle = [[UILabel alloc] init];
        CGFloat buyTitleY = CGRectGetMaxY(firstLine.frame) + distence;
        buyTitle.frame = Rect(startX, buyTitleY + 4, 150, 25);
        [_backScroll addSubview:buyTitle];
        buyTitle.text = @"购买数量";
        buyTitle.textColor = HexRGB(0x3a3a3a);
        buyTitle.font = [UIFont boldSystemFontOfSize:PxFont(Font22)];
        buyTitle.backgroundColor = [UIColor clearColor];
        
        
        //8 加减按钮
        CGFloat backW = 100;
        CGFloat backX = CGRectGetMaxX(buyTitle.frame) - 50;
        CGFloat backY = buyTitleY;
        UIView *back = [[UIView alloc] initWithFrame:Rect(backX, backY, backW, 30)];
        [_backScroll addSubview:back];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 5.0;
        back.layer.borderWidth = 1.0;
        back.layer.borderColor = [UIColor grayColor].CGColor;
        
        NSArray *icons = @[@"heng",@"",@"add"];
        for (int i = 0; i < 3; i++) {
            CGFloat lineX = (backW/3) * (i + 1);
            UIView *line = [[UIView alloc] initWithFrame:Rect(lineX, 0, 1, backW)];
            [back addSubview:line];
            line.backgroundColor = [UIColor grayColor];
            
            CGFloat btnX = (backW/3) * i;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = Rect(btnX, 0, backW/3, 30);
            [back addSubview:btn];
            btn.tag = i;
            if (i == 1) {
                btn.enabled = YES;
                showBtn = btn;
                [btn setTitleColor :[UIColor blackColor] forState:UIControlStateNormal];
                //            btn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
                [showBtn setTitle:[NSString stringWithFormat:@"%d",_showBtnCount] forState:UIControlStateNormal];
            }else if (i == 0)
            {
                reduceBtn = btn;
                btn.enabled = NO;//最少购买量是1
            }else
            {
                addBtn = btn;
            }
            [btn setBackgroundImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        //7 secondLine
        UIView *secondLine = [[UIView alloc] init];
        secondLine.backgroundColor = HexRGB(KCellLineColor);
        CGFloat secondLineY = CGRectGetMaxY(buyTitle.frame) + distence;
        secondLine.frame = Rect(firstLineX, secondLineY, kWidth - firstLineX * 2, 1);
        [_backScroll addSubview:secondLine];
        
        //8 加入购物车
        UIButton *buyCar = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backScroll addSubview:buyCar];
        CGFloat buyCarY = CGRectGetMaxY(secondLine.frame) + distence;
        CGFloat buyW = (kWidth - startX * 3)/2;
        buyCar.frame = Rect(startX, buyCarY, buyW, 40);
        [buyCar setTitle:@"加入购物车" forState:UIControlStateNormal];
        buyCar.layer.masksToBounds = YES;
        buyCar.layer.cornerRadius = 5.0;
        buyCar.layer.borderColor = HexRGB(0x1c9c28).CGColor;
        buyCar.layer.borderWidth = 1.0;
        [buyCar setTitleColor:HexRGB(0x1c9c28) forState:UIControlStateNormal];
        buyCar.titleLabel.font = [UIFont boldSystemFontOfSize:PxFont(Font30)];
        buyCar.titleLabel.textAlignment = NSTextAlignmentCenter;
        buyCar.backgroundColor = [UIColor clearColor];
        [buyCar addTarget:self action:@selector(joinCarDone) forControlEvents:UIControlEventTouchUpInside];
        
        //9 立刻购买
        UIButton *buy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backScroll addSubview:buy];
        CGFloat buyY = buyCarY;
        CGFloat buyX = CGRectGetMaxX(buyCar.frame) + startX;
        buy.frame = Rect(buyX, buyY, buyW, 40);
        buy.titleLabel.font = [UIFont boldSystemFontOfSize:PxFont(Font30)];
        [buy setTitle:@"立刻购买" forState:UIControlStateNormal];
        buy.layer.masksToBounds = YES;
        buy.layer.cornerRadius = 5.0;
        buy.layer.borderColor = HexRGB(0x1c9c28).CGColor;
        buy.layer.borderWidth = 1.0;
        [buy setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
        buy.titleLabel.textAlignment = NSTextAlignmentCenter;
        buy.backgroundColor = HexRGB(0x1c9c28);
        [buy addTarget:self action:@selector(buyDone) forControlEvents:UIControlEventTouchUpInside];
        
        //10 third Line
        UIView *thirdLine = [[UIView alloc] init];
        thirdLine.backgroundColor = HexRGB(KCellLineColor);
        CGFloat thirdLineY = CGRectGetMaxY(buy.frame) + distence;
        thirdLine.frame = Rect(firstLineX, thirdLineY, kWidth - firstLineX * 2, 1);
        [_backScroll addSubview:thirdLine];
        
        scorllH = CGRectGetMaxY(thirdLine.frame);
    }
    
    //11 商品详情title
    UILabel *_detailP = [[UILabel alloc] init];
    [_backScroll addSubview:_detailP];
    CGFloat detailY = scorllH + 20;
    _detailP.frame = Rect(startX, detailY, 100, 25);
    _detailP.textColor = HexRGB(0x3a3a3a);
    _detailP.font = [UIFont boldSystemFontOfSize:PxFont(Font26)];
    _detailP.text = @"商品详情";
    _detailP.backgroundColor = [UIColor clearColor];
    
    UILabel *productD = [[UILabel alloc] init];
    [_backScroll addSubview:productD];
    CGFloat productY = CGRectGetMaxY(_detailP.frame) + 15;
    productD.frame = Rect(startX, productY, kWidth - startX * 2, 90);
    productD.textColor = HexRGB(0x808080);
    productD.numberOfLines = 0;
    productD.font = [UIFont boldSystemFontOfSize:PxFont(Font22)];
    productD.text = _detail.Description;
    productD.backgroundColor = [UIColor clearColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:productD.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:15];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [productD.text length])];
    productD.attributedText = attributedString;
    [productD sizeToFit];
    
    _backScroll.contentSize = CGSizeMake(kWidth, CGRectGetMaxY(productD.frame) + 20);
    
}

#pragma mark 加减购买数量
-(void)btnClicked:(UIButton *)btn
{
    if (btn.tag == 2) {
        _showBtnCount++;
        if (_showBtnCount > 1) {
            //减号按钮显示
            reduceBtn.enabled = YES;
        }else
        {
            reduceBtn.hidden = NO;
        }
        [showBtn setTitle:[NSString stringWithFormat:@"%d",_showBtnCount] forState:UIControlStateNormal];
        [showBtn setTitle:[NSString stringWithFormat:@"%d",_showBtnCount] forState:UIControlStateHighlighted];
    }else if (btn.tag == 0)
    {
        //jian
        //1 更新数量,按钮的状态
        _showBtnCount--;
        if (_showBtnCount == 1) {
            //隐藏减号按钮
            reduceBtn.enabled = NO;
        }else
        {
            reduceBtn.enabled = YES;
        }
        [showBtn setTitle:[NSString stringWithFormat:@"%d",_showBtnCount] forState:UIControlStateNormal];
        [showBtn setTitle:[NSString stringWithFormat:@"%d",_showBtnCount] forState:UIControlStateHighlighted];
    }
}

#pragma mark 购买
-(void)buyDone
{
    if ([SystemConfig sharedInstance].isUserLogin)
    {
        ConformOrderController *crl = [[ConformOrderController alloc] init];
        _detail.productCount = _showBtnCount;
        //    crl.data = _detail;
        NSArray *dataList = [NSArray arrayWithObject:_detail];
        crl.OrderDataList = dataList;
        [self.navigationController pushViewController:crl animated:YES];
    }else{
        LoginController *ctl = [[LoginController alloc] init];
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

#pragma mark 加入购物车
-(void)joinCarDone
{
    //1 添加到购物车
    [[CarTool sharedCarTool] joinCar:_detail withProductNum:_showBtnCount];
    
    //2 购物车动画效果
    BBBadgeBarButtonItem *barButton = (BBBadgeBarButtonItem *)self.navigationItem.rightBarButtonItem;
//    NSLog(@"购物车里%@的数量-----%d,购物车标记显示数量%d",_detail.name,_detail.productCount,[self totalCarNum] + _showBtnCount);
    barButton.badgeValue = [NSString stringWithFormat:@"%ld", (long)[self totalCarNum]];
//    NSLog(@"ID--%@, count--%@",data.ID,data.foodCount);
}

#pragma mark 计算badgeNum
-(NSUInteger)totalCarNum
{
    NSUInteger count = [CarTool sharedCarTool].totalCarMenu.count;
    int total = 0;
    for (int i = 0; i < count; i++) {
        ProductDetailModel *data = [CarTool sharedCarTool].totalCarMenu[i];
        total += data.productCount;
    }
    _totaNum = total;
    return _totaNum;
//    return [CarTool sharedCarTool].totalCarMenu.count;
}

@end
//
//  WealthCenterController.m
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "WealthCenterController.h"
#import "CenterHeadView.h"
#import "CheckRecordsController.h"
#import "MyOrderController.h"
#import "MyBonesController.h"
#import "ReceiveAddressController.h"
#import "MyInforController.h"
#import "MySettingController.h"
#import "BuycarController.h"
#import "SettingViewItem.h"
#import "EntityRegisterController.h"
#import "LoginController.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface WealthCenterController ()<UserItemDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    NSArray *_imgArray;
    CenterHeadView *_head;
    UIScrollView *_scroll;
}
@end

@implementation WealthCenterController

-(void)viewWillAppear:(BOOL)animated
{
    // 1 隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    // 2
    if (_scroll) {
        [_scroll removeFromSuperview];
        _scroll = nil;
        [self buildUI];
    }else
    {
        [self buildUI];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    
//    [self buildUI];
}

-(void)buildUI
{
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.view addSubview:scroll];
    
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.backgroundColor = [UIColor clearColor];
    scroll.userInteractionEnabled = YES;
    _scroll = scroll;
    
    //1 头部
    CGFloat headH = 245;
    CenterHeadView *head = [[CenterHeadView alloc] initWithFrame:Rect(0, 0, kWidth, headH)];
    head.delegate = self;
    head.backgroundColor = [UIColor clearColor];
    [scroll addSubview:head];
    [head reloadData];
    [head.apply addTarget:self action:@selector(applyClicked) forControlEvents:UIControlEventTouchUpInside];
    _head = head;
    
    int ty = [[SystemConfig sharedInstance].user.type intValue];
    if (ty == 0 || ![SystemConfig sharedInstance].isUserLogin) {
        //普通用户
        _dataArray = [NSArray arrayWithObjects:@"收支记录", @"我的订单",@"我的红包",@"购物车",@"收货地址",@"我的资料",@"设置",nil];
        _imgArray = [NSArray arrayWithObjects:@"check_record",@"myOrder",@"myRedPag",@"buyCar",@"receiveA",@"myInfor",@"setting", nil];
    }else
    {
        _dataArray = [NSArray arrayWithObjects:@"收支记录", @"我的订单",@"我的资料",@"设置",nil];
        _imgArray = [NSArray arrayWithObjects:@"check_record",@"myOrder",@"myInfor",@"setting", nil];
    }
    CGFloat itemH = 54;
    CGFloat viewH = 0;
    for (int i = 0; i < _dataArray.count; i++) {
        CGFloat itemY = headH + itemH * i;
        SettingViewItem *item = [[SettingViewItem alloc] initWithFrame:Rect(0, itemY, kWidth, itemH)];
        [scroll addSubview:item];
        item.title.text = [_dataArray objectAtIndex:i];
        item.icon.image = [UIImage imageNamed:[_imgArray objectAtIndex:i]];
        item.cellBtn.tag = i + 1000;
        [item.cellBtn addTarget:self action:@selector(cellBtnDown:) forControlEvents:UIControlEventTouchUpInside];
        if (i == _dataArray.count - 1) {
            viewH = CGRectGetMaxY(item.frame) + 80;
        }
    }
    scroll.contentSize = CGSizeMake(kWidth, viewH);
}

-(void)readToLogin
{
    LoginController *lon = [[LoginController alloc] init];
    [self.navigationController pushViewController:lon animated:YES];
}

#pragma mark申请成为代理商
-(void)applyClicked
{
    EntityRegisterController *ctl = [[EntityRegisterController alloc] init];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:ctl animated:YES];
}
#pragma mark 点击cell
-(void) cellBtnDown:(UIButton *)btn
{
    if (![SystemConfig sharedInstance].isUserLogin) {
        //设置页面可以进,没有登录时默认是游客，所以第六个就是需要登录
        NSInteger selectedBtn = btn.tag - 1000;
        if  (selectedBtn == 6) {
            MySettingController *ms = [[MySettingController alloc] init];
            [self.navigationController pushViewController:ms animated:YES];
           
        }else
        {
            LoginController *log = [[LoginController alloc] init];
            self.navigationController.navigationBar.hidden = NO;
            [self.navigationController pushViewController:log animated:YES];
        }
    
    }else
    {
        if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"])
        {
            switch (btn.tag - 1000) {
                case 0:
                {
                    CheckRecordsController *check = [[CheckRecordsController alloc] init];
                    [self.navigationController pushViewController:check animated:YES];
                }
                    break;
                case 1:
                {
                    MyOrderController *mo = [[MyOrderController alloc] init];
                    [self.navigationController pushViewController:mo animated:YES];
                }
                    break;
                case 2:
                {
                    MyBonesController *mb = [[MyBonesController alloc] init];
                    [self.navigationController pushViewController:mb animated:YES];
                    
                }
                    break;
                case 3:
                {
                    BuycarController *bc = [[BuycarController alloc] init];
                    [self.navigationController pushViewController:bc animated:YES];
                }
                    break;
                case 4:
                {
                    ReceiveAddressController *ra = [[ReceiveAddressController alloc] init];
                    [self.navigationController pushViewController:ra animated:YES];
                }
                    break;
                case 5:
                {
                    MyInforController *mi = [[MyInforController alloc] init];
                    [self.navigationController pushViewController:mi animated:YES];
                    
                }
                    break;
                case 6:
                {
                    MySettingController *ms = [[MySettingController alloc] init];
                    [self.navigationController pushViewController:ms animated:YES];
                }
                default:
                    break;
            }

        }else
        {
            switch (btn.tag - 1000) {
                case 0:
                {
                    CheckRecordsController *check = [[CheckRecordsController alloc] init];
                    [self.navigationController pushViewController:check animated:YES];
                }
                    break;
                case 1:
                {
                    MyOrderController *mo = [[MyOrderController alloc] init];
                    [self.navigationController pushViewController:mo animated:YES];
                }
                    break;
                case 2:
                {
                    MyInforController *mi = [[MyInforController alloc] init];
                    [self.navigationController pushViewController:mi animated:YES];
                    
                }
                    break;
                case 3:
                {
                    MySettingController *ms = [[MySettingController alloc] init];
                    [self.navigationController pushViewController:ms animated:YES];
                }
                default:
                    break;
            }
        }
    }
}
//#pragma mark ios7 以上隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; //返回NO表示要显示，返回YES将hiden
//}
@end

//
//  BuycarController.m
//  happyMoney
//  购物车页面
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "BuycarController.h"
#import "BuyCarCell.h"
#import "EditBuyCarController.h"
#import "buyCarBottomView.h"
#import "CarTool.h"
#import "ProductDetailModel.h"
#import "ConformOrderController.h"
#import "SystemConfig.h"
#import "LoginController.h"
#import "MainController.h"
#import "AppDelegate.h"

@interface BuycarController ()<UITableViewDataSource,UITableViewDelegate,CarClickedDelegate>
{
    UITableView *_tableView;
    NSArray *_dataList;//购物车数据
    UIImageView *_noDataView;//当购物车数据为0
    buyCarBottomView *_tooBar;
    UIImageView *_nodataImg;
    UILabel *_hit;
    UIButton *_goBuy;
}
@end

@implementation BuycarController


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
    if (_dataList && _dataList.count > 0) {
        //重新计算,全部全选
        if (_tableView) {
            [self reCaculate];
        }
    }else
    {
        [self showNoData];
    }
}

-(void)reCaculate
{
    CGFloat totalPrice = 0;
    int totalNum = 0;
    NSUInteger count = _dataList.count;
    if (count > 0) {
        for (int i = 0; i < count; i++) {
            ProductDetailModel *data = _dataList[i];
            data.isChosen = YES;
            totalPrice += (data.productCount * [data.price floatValue]);
            totalNum += data.productCount;
        }
        _tooBar.total.text = [NSString stringWithFormat:@"¥%.1f",totalPrice];
        _tooBar.allBtn.selected = YES;
    }else
    {
        _tooBar.total.text = [NSString stringWithFormat:@"¥%.1f",totalPrice];
        _tooBar.allBtn.selected = NO;
    }
    [_tableView reloadData];
}

#pragma mark 没有数据时显示
- (void)showNoData
{
    CGFloat imgWH = 105;
    if (!_nodataImg) {
        _nodataImg = [[UIImageView alloc] initWithFrame:Rect(0, 0, imgWH, imgWH)];
        _nodataImg.center  = CGPointMake((kWidth)/2, 200 - 30);
        [self.view addSubview:_nodataImg];
        _nodataImg.image = [UIImage imageNamed:@"noOrderData"];
        _nodataImg.backgroundColor = [UIColor clearColor];
    }
    
    if (!_hit) {
        _hit = [[UILabel alloc] init];
        [self.view addSubview:_hit];
        _hit.frame = Rect(0, 0, 300, 25);
        CGPoint nodaC = _nodataImg.center;
        nodaC.y += (imgWH/2 + 30);
        nodaC.x += 20;
        _hit.center = nodaC;
        _hit.backgroundColor = [UIColor clearColor];
        _hit.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _hit.textColor = ButtonColor;
    }
    _hit.text = @"购物车内空空如也，快去挑点宝贝吧！";
    
    if (!_goBuy) {
        _goBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _goBuy.frame = Rect(0, 0, imgWH, 40);
        CGPoint nodaC = _nodataImg.center;
        nodaC.y += (imgWH/2 + 69);
        nodaC.x += 0;
        _goBuy.center = nodaC;
        [_goBuy setTitle:@"去寻宝" forState:UIControlStateNormal];
        _goBuy.backgroundColor = [UIColor clearColor];
        _goBuy.layer.masksToBounds = YES;
        _goBuy.layer.cornerRadius = 5.0f;

        _goBuy.backgroundColor = ButtonColor;
        [_goBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_goBuy];
        [_goBuy addTarget:self action:@selector(gobuy) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_dataList.count > 0) {
        _nodataImg.hidden = YES;
        _hit.hidden = YES;
        _goBuy.hidden = YES;
    }else
    {
        _nodataImg.hidden = NO;
        _hit.hidden = NO;
        _goBuy.hidden = NO;
    }
    
}

#pragma mark 去财富树页面
-(void)gobuy
{
//    [self.navigationController popViewControllerAnimated:YES];
    
    if ([_delegate respondsToSelector:@selector(changeController)]) {
        [_delegate changeController];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"购物车";
    
    _dataList = [CarTool sharedCarTool].totalCarMenu;
    
    [self buildUI];
}

-(void)buildUI
{
    MainController *main = ((AppDelegate *)[UIApplication sharedApplication].delegate).mainCtl;
    //    MainController *main = (MainController *)self.view.window.rootViewController;
    self.delegate = main;
    
    if (_dataList.count > 0) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KAppNoTabHeight - 44) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = HexRGB(0xf3f3f3);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
        
        [self buildToolBar];
    }else
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KAppNoTabHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = HexRGB(0xf3f3f3);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
    }
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    BuyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BuyCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }     
    cell.data = _dataList[indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 156;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark cell的选中按钮点击
- (void)changeCarValue
{
    [self caculate];
}

#pragma mark 加减按钮点击
- (void)CarClickedWithData:(ProductDetailModel *)data buttonType:(ButtonType)type
{
    //1 carTool更新购物车数据
    if (type == kButtonAdd) {
        [[CarTool sharedCarTool] addMenu:data];
    }else
    {
        [[CarTool sharedCarTool] plusMenu:data];
    }
    //2 计算
    [self caculate];
}

#pragma mark 计算总份数和总价
-(void)caculate
{
    CGFloat totalPrice = 0;
    int totalNum = 0;
    bool isAllSelected = YES;
    NSUInteger count = _dataList.count;
    if (count > 0) {
        //        _noDataView.hidden = YES;
        // 如果没有底部工具栏，重新画上
        if (_tooBar) {
            [self buildToolBar];
        }
        for (int i = 0; i < count; i++) {
            //因为不能得到除可视范围内的cell ,所以要根据cell里面的  data来计算数据
            ProductDetailModel *data = _dataList[i];
            if (data.isChosen) {// 被选中的
                totalPrice += (data.productCount * [data.price floatValue]);
                totalNum += data.productCount;
            }
            else
            {
                isAllSelected = NO;//只要有一个没有选中，则不能全选
            }
        }
    }else
    {
        //        _noDataView.hidden = NO;
        isAllSelected = NO;//购物车里没有数据，肯定没有全选
        [self showNoData];
        [self removeBottomView];
    }
    _tooBar.total.text = [NSString stringWithFormat:@"¥%.1f",totalPrice];
    _tooBar.allBtn.selected = isAllSelected ? YES: NO;
}

#pragma mark 添加底部工具栏
-(void)buildToolBar
{
    buyCarBottomView *bottom = [[buyCarBottomView alloc] initWithFrame:Rect(0, KContentH, kWidth, 44)];
    [self.view addSubview:bottom];
    _tooBar = bottom;
    [bottom.allBtn addTarget:self action:@selector(allBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bottom.payBtn addTarget:self action:@selector(PayAction) forControlEvents:UIControlEventTouchUpInside];
    [bottom.deletaBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 移除底部工具栏
-(void) removeBottomView
{
    if (_tooBar) {
        [_tooBar removeFromSuperview];
    }
}

#pragma mark 删除
-(void)deleteAction
{
    //遍历数组，删除选中的数据，刷新页面
    NSMutableArray *temDeleteArray = [NSMutableArray array];
    for (int i = 0; i < _dataList.count; i++) {
        ProductDetailModel *data = _dataList[i];
        if (data.isChosen) {
            [temDeleteArray addObject:data];
        }
    }
    [[CarTool sharedCarTool] deleteDataWithArray:temDeleteArray];
    [_tableView reloadData];
    if (_dataList.count == 0) {
        [self caculate];
    }
}

#pragma mark 去结算
-(void)PayAction
{
    if ([SystemConfig sharedInstance].isUserLogin)
    {
        ConformOrderController *ctl = [[ConformOrderController alloc] init];
        ctl.OrderDataList = _dataList;
        [self.navigationController pushViewController:ctl animated:YES];
    }else{
        LoginController *ctl = [[LoginController alloc] init];
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

#pragma mark 全选:
-(void)allBtnClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
    //分全选，还是没有
    if (btn.selected) {
        //全选,遍历所有cell，cell都是选中状态，计算价格
        NSUInteger count = _dataList.count;
        for (int i = 0; i < count; i++) {
            ProductDetailModel *data = _dataList[i];
            data.isChosen = YES;
        }
        [_tableView reloadData];
        [self caculate];
        
    }else
    {//全部不选，数据清0
        NSUInteger count = _dataList.count;
        for (int i = 0; i < count; i++) {
            ProductDetailModel *data = _dataList[i];
            data.isChosen = NO;
        }
        [_tableView reloadData];
        _tooBar.total.text = @"0";
        
    }
}

@end

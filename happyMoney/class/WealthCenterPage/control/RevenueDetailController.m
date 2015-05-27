//
//  RevenueDetailController.m
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "RevenueDetailController.h"
#import "Product.h"
#import "ProductCell.h"
#import "checkDetialView.h"
#import "Product.h"

@interface RevenueDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    BOOL _isCheckIn;//是否是收入
    CGFloat _cellH;
}


@end

@implementation RevenueDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.title;
    _isCheckIn = NO;
    CGFloat checkVH = 0;
    CGFloat tableH = 0;
    CGFloat bottomH = 50;
    
    if ([self.title isEqualToString:@"收入详情"]) {
        _isCheckIn = YES;
        checkVH = 70;
        tableH = KAppNoTabHeight - checkVH -bottomH;
    }else
    {
        tableH = KAppNoTabHeight - bottomH;
    }
    //1 table
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,tableH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = HexRGB(0xeeeeee);
    [_tableView setSectionHeaderHeight:44.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        Product *pro = [[Product alloc] init];
        [data addObject:pro];
    }
    _dataArray = [NSArray arrayWithArray:data];
    
    //2 check view
    if (_isCheckIn) {
        checkDetialView *check = [[checkDetialView alloc]  initWithFrame:Rect(0, tableH, kWidth, checkVH)];
        [self.view addSubview:check];
        check.styler = KInfoStyleWuliu;
    }
    
    //3 bottom view
    UIView *bottomView = [[UIView alloc] initWithFrame:Rect(0, KAppNoTabHeight - bottomH , kWidth, bottomH)];
    [self.view addSubview:bottomView];
    if (_isCheckIn) {
        bottomView.backgroundColor = HexRGB(0xeeeeee);
    }else
    {
        bottomView.backgroundColor = HexRGB(0xffffff);
    }
    
    CGFloat totalX = 50;
    CGFloat totalY = 10;
    CGFloat totalH = bottomH - totalY * 2;
    UILabel *totalNum = [[UILabel alloc] initWithFrame:Rect(totalX, totalY, 120, totalH)];
    [bottomView addSubview:totalNum];
    totalNum.textColor = HexRGB(0x808080);
    totalNum.font = [UIFont systemFontOfSize:20.0];
    totalNum.backgroundColor = [UIColor clearColor];
    totalNum.text = @"共2件商品";
    
    UILabel *totalCount = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(totalNum.frame) + 10, totalY, 60, totalH)];
    [bottomView addSubview:totalCount];
    totalCount.textColor = HexRGB(0x808080);
    totalCount.font = [UIFont systemFontOfSize:18.0];
    totalCount.text = @"总计： ";
    totalCount.backgroundColor = [UIColor clearColor];
    
    UILabel *mone = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(totalCount.frame) + 5, totalY, 60, totalH)];
    [bottomView addSubview:mone];
    mone.textColor = HexRGB(0x3a3a3a);
    mone.font = [UIFont systemFontOfSize:18.0];
    mone.text = @"¥ 216";
    mone.backgroundColor = [UIColor clearColor];
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Product *data = [[Product alloc] init];
    data.price = @"600";
    data.name = @"面膜";
    data.old_price = @"700";
    data.sell_num = @"3";
    cell.data = data;
    _cellH = [cell getCellH];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"2015-3-22";
//  
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *back = [[UIView alloc] initWithFrame:Rect(0, 0, kWidth, 0)];
    CGFloat lbX = 10;
    CGFloat lbY = 10;
    CGFloat lbH = _tableView.sectionHeaderHeight - lbY * 2;
    UILabel *date = [[UILabel alloc] initWithFrame:Rect(lbX, lbY, 200, lbH)];
    date.text = @"2015-3-22";
    date.font = [UIFont systemFontOfSize:18];
    [back addSubview:date];
    date.backgroundColor = [UIColor clearColor];
    date.textColor = HexRGB(0x666666);
    
    UIView *line = [[UIView alloc] initWithFrame:Rect(0, tableView.sectionHeaderHeight - 0.5, kWidth, 0.5)];
    line.backgroundColor = HexRGB(KCellLineColor);
    [back addSubview:line];
    
    back.backgroundColor = HexRGB(0xeeeeee);
    return back;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}
@end

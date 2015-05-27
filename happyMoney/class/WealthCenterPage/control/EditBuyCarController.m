//
//  EditBuyCarController.m
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "EditBuyCarController.h"
#import "BuyCarCell.h"
#import "buyCarBottomView.h"

@interface EditBuyCarController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation EditBuyCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"编辑购物车";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KContentH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = HexRGB(0xf3f3f3);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    _tableView.sectionFooterHeight = 10;
    [self.view addSubview:_tableView];
    
    //2 bottom
    buyCarBottomView *bottom = [[buyCarBottomView alloc] initWithFrame:Rect(0, KContentH, kWidth, 44)];
    [self.view addSubview:bottom];
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    BuyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BuyCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
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
@end

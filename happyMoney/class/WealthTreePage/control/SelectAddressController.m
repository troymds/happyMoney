//
//  SelectAddressController.m
//  happyMoney
//  选中收货地址页面
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "SelectAddressController.h"
#import "AddressCell.h"
#import "DefaultAddressModel.h"
#import "AddAddressController.h"

@interface SelectAddressController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIImageView *_nodataImg;
    UILabel *_hit;
    UILabel *_hit2;
}
@end

@implementation SelectAddressController

-(void)viewWillAppear:(BOOL)animated
{
    if (_tableView) {
        [_tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    [rightBtn addTarget:self action:@selector(goAddAddress) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 50, 30);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    _dataArray = [NSMutableArray array];
    [self buildUI];
    [self loadData];
}

#pragma mark 没有数据时显示
- (void)showNoData
{
    CGFloat imgWH = 105;
    if (!_nodataImg) {
        _nodataImg = [[UIImageView alloc] initWithFrame:Rect(0, 0, imgWH, imgWH)];
        _nodataImg.center  = CGPointMake((kWidth)/2, (kHeight - imgWH)/2);
        [self.view addSubview:_nodataImg];
        _nodataImg.image = [UIImage imageNamed:@"noOrderData"];
        _nodataImg.backgroundColor = [UIColor clearColor];
    }
    
    if (!_hit && !_hit2) {
        _hit = [[UILabel alloc] init];
        [self.view addSubview:_hit];
        _hit.frame = Rect(0, 0, 300, 25);
        CGPoint nodaC = _nodataImg.center;
        nodaC.y += (imgWH/2 + 20);
        nodaC.x += 50;
        _hit.center = nodaC;
        _hit.backgroundColor = [UIColor clearColor];
        _hit.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _hit.textColor = HexRGB(0x3a3a3a);
        
        _hit2 = [[UILabel alloc] init];
        [self.view addSubview:_hit2];
        _hit2.frame = Rect(0, 0, 300, 25);

        nodaC.y += 30;
        nodaC.x -= 5;
        _hit2.center = nodaC;
        _hit2.backgroundColor = [UIColor clearColor];
        _hit2.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _hit2.textColor = HexRGB(0x3a3a3a);
    }
    _hit.text = @"您还没有添加任何收货信息，";
    _hit2.text = @"请点击右上角图标进行添加哦!";
    _nodataImg.hidden = NO;
    _hit.hidden = NO;
}

-(void)loadData                                                                                                                                                                                                                                                                                                 {
    //获取地址列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    [HttpTool postWithPath:@"getAddressList" params:nil success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            if (![data isKindOfClass:[NSNull class]] && data.count > 0) {
                for (NSDictionary *dic in data) {
                    DefaultAddressModel *model = [[DefaultAddressModel alloc] initWithDictionary:dic];
                    [_dataArray addObject:model];
                }
//              [self buildUI];
                [_tableView reloadData];
            }
            else{
                [self showNoData];
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)buildUI
{
    //1 tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KAppNoTabHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //    _tableView.backgroundColor = HexRGB(0xf3f3f3);
    _tableView.backgroundColor = HexRGB(0xeeeeee);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

#pragma mark 新增地址
-(void)goAddAddress
{
    AddAddressController *ad = [[AddAddressController alloc] init];
    [self.navigationController pushViewController:ad animated:YES];
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString *ID = @"cellName";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = _dataArray[indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
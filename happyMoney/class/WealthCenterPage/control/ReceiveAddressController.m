//
//  ReceiveAddressController.m
//  happyMoney
//  收获地址
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ReceiveAddressController.h"
#import "AddAddressController.h"
#import "AddressCell.h"
#import "ModefyAddressController.h"
#import "DefaultAddressModel.h"

@interface ReceiveAddressController ()<UITableViewDataSource,UITableViewDelegate,DeleteAddressDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    CGFloat _cellH;
    UIImageView *_nodataImg;
    UILabel *_hit;
    UILabel *_hit2;
}
@end

@implementation ReceiveAddressController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
    // 刷新数据
    if (_tableView) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"收货地址";
    
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(goAddAddres) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 60, 30);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    //1 tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KAppNoTabHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //    _tableView.backgroundColor = HexRGB(0xf3f3f3);
    _tableView.backgroundColor = HexRGB(0xeeeeee);
    
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray array];
    [self loadData];
}


-(void)loadData
{
    //获取地址列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    [HttpTool postWithPath:@"getAddressList" params:nil success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            if (_dataArray) {
                [_dataArray removeAllObjects];
            }
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            if (![data isKindOfClass:[NSNull class]]) {
                for (NSDictionary *dic in data) {
                    DefaultAddressModel *model = [[DefaultAddressModel alloc] initWithDictionary:dic];
                    [_dataArray addObject:model];
                }
                if (_dataArray.count > 0) {
                    [self hideNodataView];
                }
                [_tableView reloadData];
            }else
            {
                [self showNoData];
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 新增地址
-(void)goAddAddres
{
    AddAddressController *ad = [[AddAddressController alloc] init];
    [self.navigationController pushViewController:ad animated:YES];
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.type = KAddressModefy;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.data = _dataArray[indexPath.row];
    cell.index = indexPath.row;
    _cellH = [cell getHeight];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ModefyAddressController *ctl = [[ModefyAddressController alloc] init];
        ctl.address = _dataArray[indexPath.row];
        [self.navigationController pushViewController:ctl animated:YES];
    }
}

-(void) hideNodataView
{
    _nodataImg.hidden = YES;
    _hit.hidden = YES;
    _hit2.hidden = YES;
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
    _hit2.hidden = NO;
}

- (void)deleteAddress:(DefaultAddressModel *)address index:(NSInteger)index
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:address.ID,@"id", nil];
    [HttpTool postWithPath:@"deleteAddress" params:parm success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *data;
        if (code == 100) {
            data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            [_dataArray removeObjectAtIndex:index];
            [_tableView reloadData];
            //判断全部删除的情况
            if (_dataArray.count == 0) {
                [self showNoData];
            }
            [RemindView showViewWithTitle:data location:MIDDLE];
        }else{
            [RemindView showViewWithTitle:data location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}
@end

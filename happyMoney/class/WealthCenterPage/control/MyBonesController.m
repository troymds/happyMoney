//
//  MyBonesController.m
//  happyMoney
//  我的红包
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MyBonesController.h"
#import "Tool.h"
#import "MDSBtn.h"
#import "MybonesCell.h"
#import "MyboneData.h"

@interface MyBonesController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_selectedBtn;
    UITableView* _tableView;
    NSArray *_inData;//收入
    NSArray *_outData;//支出
    UIImageView *_nodataImg;
    UILabel *_hit;
    UILabel *_hit2;
    MyboneData *_data;
}
@end

@implementation MyBonesController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"我的红包";
    
    //1 菜单栏
    _data = [[MyboneData alloc] init];
    CGFloat startX = 20;
    CGFloat btnW = (kWidth - startX * 2)/2;
    
    //菜单栏底部view
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(startX,startX,btnW * 2,40)];
    topBgView.backgroundColor = [UIColor whiteColor];
    topBgView.layer.masksToBounds = YES;
    topBgView.layer.cornerRadius = 5.0f;
    topBgView.layer.borderColor = HexRGB(0x77c116).CGColor;
    topBgView.layer.borderWidth = 1.0;
    [self.view addSubview:topBgView];
    
    NSArray *btnTitles = @[@"当前",@"历史"];
    for (int i = 0; i < 2; i++) {
        CGFloat btnX = btnW * i;
        MDSBtn *btn = [[MDSBtn alloc] initWithFrame:Rect(btnX, 0, btnW, 40)];
        [topBgView addSubview:btn];
        btn.tag = i;
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn setTitle:btnTitles[i] forState:UIControlStateSelected];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn setTitleColor:HexRGB(0xffffff) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage *nomalImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        UIImage *selectImg = [Tool imageFromColor:ButtonColor size:btn.frame.size];
        
        [btn setBackgroundImage:nomalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        
        if (i == 0) {
            btn.selected = YES;
            _selectedBtn = btn;
        }
    }
    CGFloat tableY = CGRectGetMaxY(topBgView.frame) + startX;
    //2 table
    _inData = [NSArray array];
    _outData = [NSArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableY,kWidth,KAppNoTabHeight - tableY) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self loaData];
//    [self showNoData];
    
}

-(void)loaData
{
    //获取地址列表
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.dimBackground = NO;
//    
//    [HttpTool postWithPath:@"getAddressList" params:nil success:^(id JSON, int code) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        
//        if (code == 100) {
//            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
//            if (![data isKindOfClass:[NSNull class]]) {
//                for (NSDictionary *dic in data) {
//                    DefaultAddressModel *model = [[DefaultAddressModel alloc] initWithDictionary:dic];
//                    [_dataArray addObject:model];
//                }
//                if (_dataArray.count > 0) {
//                    [self hideNodataView];
//                }
//                [_tableView reloadData];
//            }else
//            {
//                [self showNoData];
//            }
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        [RemindView showViewWithTitle:offline location:MIDDLE];
//    }];
}

#pragma mark 没有数据时显示
- (void)showNoData
{
    CGFloat imgWH = 105;
    if (!_nodataImg) {
        _nodataImg = [[UIImageView alloc] initWithFrame:Rect(0, 0, imgWH, imgWH)];
        _nodataImg.center  = CGPointMake((kWidth)/2, (kHeight - imgWH)/2);
        [self.view addSubview:_nodataImg];
        _nodataImg.image = [UIImage imageNamed:@"noRedpag"];
        _nodataImg.backgroundColor = [UIColor clearColor];
    }
    
    if (!_hit && !_hit2) {
        _hit = [[UILabel alloc] init];
        [self.view addSubview:_hit];
        _hit.frame = Rect(0, 0, 300, 25);
        CGPoint nodaC = _nodataImg.center;
        nodaC.y += (imgWH/2 + 20);
        nodaC.x += 60;
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
    _hit.text = @"红包可在平台直接消费，";
    _hit2.text = @"啊哦，您没有获得任何红包哦!";
    _nodataImg.hidden = NO;
    _hit.hidden = NO;
    
    //    if (_dataArray.count > 0) {
    //        _nodataImg.hidden = YES;
    //        _hit.hidden = YES;
    //    }else
    //    {
    //        _nodataImg.hidden = NO;
    //        _hit.hidden = NO;
    //    }
    
}

#pragma mark 菜单栏点击
-(void)btnClicked:(UIButton *)btn
{
    if (btn != _selectedBtn) {
        _selectedBtn.selected = NO;
        
        btn.selected = !btn.selected;
        //改变选中按钮状态
        _selectedBtn = btn;
        
        //2 显示相应的table
//        [self showNoData];
        if (_selectedBtn.tag == 0) {
            //收入
                        [_tableView reloadData];
        }else
        {
            //支出
                        [_tableView reloadData];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    MybonesCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MybonesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.backgroundColor = [UIColor whiteColor];
    }
    if (_selectedBtn.tag == 0) {
        cell.boneType = KBonesNow;
    }else
    {
        cell.boneType = KBonesHistory;
    }
    cell.data = _data;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RevenueDetailController *rv = [[RevenueDetailController alloc] init];
//    if (_selectedBtn.tag == KRecordIn) {
//        rv.title = @"收入详情";
//    }else
//    {
//        rv.title = @"消费详情";
//    }
//    [self.navigationController pushViewController:rv animated:YES];
}

@end

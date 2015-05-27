//
//  CheckRecordsController.m
//  happyMoney
//  收支记录
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CheckRecordsController.h"
#import "InOutRecordsCell.h"
#import "CollectCashController.h"
#import "RevenueDetailController.h"
#import "Tool.h"
#import "MDSBtn.h"
#import "flowRecordModel.h"

@interface CheckRecordsController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_selectedBtn;
    UITableView* _tableView;
    NSArray *_inData;//收入
    NSArray *_outData;//支出
    UIImageView *_nodataImg;
    UILabel *_hit;
    UILabel *_hit2;
    NSMutableArray *_data;
}
@end

@implementation CheckRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"收支记录";
    
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 80, 30);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    [rightBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    //1 菜单栏
    
    CGFloat startX = 20;
    CGFloat btnW = (kWidth - startX * 2)/2;
    
    //菜单栏底部view
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(startX,startX,btnW * 2,40)];
    topBgView.backgroundColor = [UIColor whiteColor];
    topBgView.layer.masksToBounds = YES;
    topBgView.layer.cornerRadius = 5.0f;
    topBgView.layer.borderColor = ButtonColor.CGColor;
    topBgView.layer.borderWidth = 1.0;
    [self.view addSubview:topBgView];
    
    NSArray *btnTitles = @[@"收入",@"支出"];
    for (int i = 0; i < 2; i++) {
        CGFloat btnX = btnW * i;
        MDSBtn *btn = [[MDSBtn alloc] initWithFrame:Rect(btnX, 0, btnW, 40)];
        [topBgView addSubview:btn];
        btn.tag = i;
//        btn.frame = Rect(btnX, 0, btnW, 40);
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn setTitle:btnTitles[i] forState:UIControlStateSelected];
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = 5.0;
        
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn setTitleColor:HexRGB(0xffffff) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setHighlighted:NO];
        UIImage *nomalImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        UIImage *selectImg = [Tool imageFromColor:ButtonColor size:btn.frame.size];
        UIImage *highImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        [btn setBackgroundImage:nomalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:highImg forState:UIControlStateHighlighted];
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
    
    [self loadData];
//    [self showNoData];
}

-(void)loadData
{
    //收支记录(getFlowRecord)
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    //收入是1
    int direction = 0;
    if (_selectedBtn.tag == 0) {
        direction = 1;
    }
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)direction],@"direction",@"1",@"page",@"10",@"pagesize", nil];
    NSLog(@"%@",parms);
    [HttpTool postWithPath:@"getFlowRecord" params:parms success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            if (!_data) {
                _data = [NSMutableArray array];
            }else
            {
                [_data removeAllObjects];
            }
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            if (![data isKindOfClass:[NSNull class]]) {
                for (NSDictionary *dic in data) {
                    flowRecordModel *model = [[flowRecordModel alloc] initWithDictionaryForGategory:dic];
                    [_data addObject:model];
                }
                if (_data.count > 0) {
                    [self hideNodataView];
                }
                [_tableView reloadData];
            }else
            {
                [self showNoData];
            }
        }else
        {
//            [RemindView showViewWithTitle:[[JSON objectForKey:@"response"] objectForKey:@"msg"] location:MIDDLE];
            [self showNoData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)hideNodataView
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
        _nodataImg.image = [UIImage imageNamed:@"noRedpag"];
        _nodataImg.backgroundColor = [UIColor clearColor];
    }
    
    if (!_hit && !_hit2) {
        _hit = [[UILabel alloc] init];
        [self.view addSubview:_hit];
        _hit.frame = Rect(0, 0, 300, 25);
        CGPoint nodaC = _nodataImg.center;
        nodaC.y += (imgWH/2 + 20);
        nodaC.x += 90;
        _hit.center = nodaC;
        _hit.backgroundColor = [UIColor clearColor];
        _hit.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _hit.textColor = HexRGB(0x3a3a3a);
        
        _hit2 = [[UILabel alloc] init];
        [self.view addSubview:_hit2];
        _hit2.frame = Rect(0, 0, 300, 25);
        
        nodaC.y += 30;
        nodaC.x += 15;
        _hit2.center = nodaC;
        _hit2.backgroundColor = [UIColor clearColor];
        _hit2.font = [UIFont systemFontOfSize:PxFont(Font22)];
        _hit2.textColor = HexRGB(0x3a3a3a);
    }
    if (_selectedBtn.tag == KRecordIn) {
       _hit.text = @"您还没有任何支出，";
    }else
    {
        _hit.text = @"您还没有任何收入，";
    }
    
    _hit2.text = @"请再接再厉哦!";
    _nodataImg.hidden = NO;
    _hit.hidden = NO;
    _hit2.hidden = NO;
}

-(void)tixian
{
    CollectCashController *ctl = [[CollectCashController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
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
        [self loadData];
    }
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    InOutRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[InOutRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.data = _data[indexPath.row];
//    if (_selectedBtn.tag == 0) {
//        cell.type = KRecordIn;
//    }else
//    {
//        cell.type = KRecordOut;
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RevenueDetailController *rv = [[RevenueDetailController alloc] init];
    if (_selectedBtn.tag == KRecordIn) {
        rv.title = @"消费详情";
    }else
    {
        rv.title = @"收入详情";
    }
    [self.navigationController pushViewController:rv animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

@end

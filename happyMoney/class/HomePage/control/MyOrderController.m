//
//  MyOrderController.m
//  happyMoney
//  我的订单
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MyOrderController.h"
#import "UnSendCargoCCell.h"
#import "OrderModel.h"
#import "UnSendCargoSerCell.h"
#import "SendIngCCell.h"
#import "SendingServerCell.h"
#import "DoneCCell.h"
#import "DoneServerCell.h"
#import "SystemConfig.h"
#import "ConformOrderController.h"
#import "OrderDetailController.h"
#import "ChenkStatusController.h"
#import "Tool.h"
#import "OrderModel.h"
#import "MDSBtn.h"
#import "UnsendC.h"
#import "UserItem.h"

#define KMenuTag 1000

@interface MyOrderController ()<UITableViewDataSource,UITableViewDelegate,OrderCellDelegate>
{
    UIButton *_selectedBtn;
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_data;
    CGFloat _cellH;
    int loinType;
    UIImageView *_nodataImg;
    UILabel *_hit;
    CGFloat menuBackY;
}
@end

@implementation MyOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"我的订单";

//    [SystemConfig sharedInstance].menuType = 1;
    loinType = [[SystemConfig sharedInstance].user.type intValue];// 游客，代理商
    
    //1 菜单栏
    
    
    CGFloat StartXY = 10;
    CGFloat btnBW = kWidth - startXY * 2;
    CGFloat BtnH = 30;
    CGFloat btnW = btnBW/3;
    
    //菜单栏底部view
    UIView *menuBack = [[UIView alloc] initWithFrame:CGRectMake(StartXY,StartXY,btnBW,BtnH)];
    menuBack.backgroundColor = [UIColor whiteColor];
    menuBack.layer.masksToBounds = YES;
    menuBack.layer.cornerRadius = 5.0f;
    menuBack.layer.borderColor = ButtonColor.CGColor;
    menuBack.layer.borderWidth = 1.0;
    [self.view addSubview:menuBack];
    
    NSArray *titles = @[@"未发货",@"已发货",@"已完成"];
    for (int i = 0; i < 3; i++) {
        CGFloat btnX = btnW * i;
        MDSBtn *btn  = [[MDSBtn alloc] initWithFrame:Rect(btnX, 0, btnW, BtnH)];
        [menuBack addSubview:btn];
        btn.backgroundColor  = [UIColor clearColor];
        btn.tag = i + KMenuTag;
        btn.num = 3;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateSelected];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn setTitleColor:HexRGB(0xffffff) forState:UIControlStateSelected];
        UIImage *nomalImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        UIImage *selectImg = [Tool imageFromColor:ButtonColor size:btn.frame.size];
        
        [btn setBackgroundImage:nomalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(menuClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.selected = YES;
            _selectedBtn = btn;
        }
    }
    
    menuBackY = CGRectGetMaxY(menuBack.frame);
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

-(void) buildUI
{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, menuBackY,kWidth,KAppNoTabHeight - menuBackY) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = HexRGB(0xeeeeee);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    
}

#pragma mark 获取数据
- (void) loadData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    NSString *type = [NSString stringWithFormat:@"%d",_selectedBtn.tag - KMenuTag];
    NSDictionary *parms  = [NSDictionary dictionaryWithObjectsAndKeys:type,@"status",@"1",@"page",@"10",@"pagesize", nil];
    
    [HttpTool postWithPath:@"getOrderList" params:parms success:^(id JSON, int code) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            if (!_data) {
                _data = [NSMutableArray array];
            }else
            {
                [_data removeAllObjects];
            }
            
            if (![data isKindOfClass:[NSNull class]]) {
            for (NSDictionary *dic in data) {
                OrderModel *item = [[OrderModel alloc] initWithDictionary:dic];
                [_data addObject:item];
                }
                [self buildUI];
                [self hideNoDataView];
            }
            else
            {
                //没有数据
                if (_selectedBtn.tag == KMenuTag) {
                    //未发货
                    [self showNoData:@"您没有未发货的订单哦！"];
                }else if (_selectedBtn.tag == KMenuTag + 1)
                {
                    //已发货
                    [self showNoData:@"您没有已发货的订单哦！"];
                }else
                {
                    //已完成
                    [self showNoData:@"您没有已完成的订单哦！"];
                }
            }
            [_tableView reloadData];
    }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
        //没有数据
//        if (_selectedBtn.tag == KMenuTag) {
//            //未发货
//            [self showNoData:@"您没有未发货的订单哦！"];
//        }else if (_selectedBtn.tag == KMenuTag + 1)
//        {
//            //已发货
//            [self showNoData:@"您没有已发货的订单哦！"];
//        }else
//        {
//            //已完成
//            [self showNoData:@"您没有已完成的订单哦！"];
//        }
    }];
}

-(void)hideNoDataView
{
    if (_nodataImg && _hit) {
//        _nodataImg.hidden = YES;
//        _hit.hidden = YES;
        [_nodataImg removeFromSuperview];
        _nodataImg = nil;
        [_hit removeFromSuperview];
        _hit = nil;
    }
}

#pragma mark 没有数据时显示
- (void)showNoData:(NSString *)str
{
    CGFloat imgWH = 105;
    if (!_nodataImg) {
        _nodataImg = [[UIImageView alloc] initWithFrame:Rect(0, 0, imgWH, imgWH)];
        _nodataImg.center  = CGPointMake((kWidth)/2, (kHeight - imgWH)/2);
        [self.view addSubview:_nodataImg];
        _nodataImg.image = [UIImage imageNamed:@"noOrderData"];
        _nodataImg.backgroundColor = [UIColor clearColor];
    }
    
    if (!_hit) {
        _hit = [[UILabel alloc] init];
        [self.view addSubview:_hit];
        _hit.frame = Rect(0, 0, 250, 25);
        CGPoint nodaC = _nodataImg.center;
        nodaC.y += (imgWH/2 + 20);
        nodaC.x += 40;
        _hit.center = nodaC;
        _hit.backgroundColor = [UIColor clearColor];
        _hit.font = [UIFont systemFontOfSize:PxFont(Font24)];
        _hit.textColor = HexRGB(0x3a3a3a);
    }
        _hit.text = str;
    
    if (_data.count > 0) {
        _nodataImg.hidden = YES;
        _hit.hidden = YES;
    }else
    {
        _nodataImg.hidden = NO;
        _hit.hidden = NO;
    }
    
}

#pragma mark 菜单栏点击
-(void)menuClicked:(UIButton *)btn
{
    if (_selectedBtn.tag != btn.tag) {
        _selectedBtn.selected = NO;
        
        btn.selected = !btn.selected;
        //改变选中按钮状态
        _selectedBtn = btn;
        
        [self loadData];
    }
}

#pragma mark --------tableView_delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%lu",(unsigned long)_data.count);
    return _data.count;
}

#pragma mark 判断是否自提
-(BOOL) isSelfGet:(OrderModel *)data
{
    BOOL isSelfGet = NO;
    if ([data.express isEqualToString:@"0"]) {
        isSelfGet = YES;
    }
    return isSelfGet;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_selectedBtn.tag == 0 + KMenuTag) {
        if (loinType == 0) {
            static NSString *IDC = @"unSendCustomCell";
            UnsendC *cell = [tableView dequeueReusableCellWithIdentifier:IDC];
            if (cell == nil) {
//                cell = [[UnSendCargoCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDC withData:_data[indexPath.row]];
                cell = [[UnsendC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDC];
            }
            cell.type =  [self isSelfGet:_data[indexPath.row]]? kziti :kwuliu;
            cell.data = _data[indexPath.row];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *IDS = @"unSendServerCell";
            UnSendCargoSerCell *cell = [tableView dequeueReusableCellWithIdentifier:IDS];
            if (cell == nil) {
                cell = [[UnSendCargoSerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDS];
            }
            cell.type = [self isSelfGet:_data[indexPath.row]] ? kziti :kwuliu;
            cell.data = _data[indexPath.row];
            cell.delegate = self;
//            _cellH = [cell getCellHeight];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else if (_selectedBtn.tag == 1 + KMenuTag)
    {
        if (loinType == 0) {
            //
            static NSString *IDC = @"SendingCustomCell";
            SendIngCCell *cell = [tableView dequeueReusableCellWithIdentifier:IDC];
            if (cell == nil) {
                cell = [[SendIngCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDC];
            }
            cell.type = [self isSelfGet:_data[indexPath.row]] ? kziti :kwuliu;
            cell.data = _data[indexPath.row];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *IDC = @"SendingSCell";
            SendingServerCell *cell = [tableView dequeueReusableCellWithIdentifier:IDC];
            if (cell == nil) {
                cell = [[SendingServerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDC];
            }
            cell.type = [self isSelfGet:_data[indexPath.row]] ? kziti :kwuliu;
            cell.data = _data[indexPath.row];
            cell.delegate = self;
            _cellH = [cell getCellHeight];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else
    {
        if (loinType == 0) {
            //
            static NSString *IDC = @"DoneCustomCell";
            DoneCCell *cell = [tableView dequeueReusableCellWithIdentifier:IDC];
            if (cell == nil) {
                cell = [[DoneCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDC];
            }
            cell.type = [self isSelfGet:_data[indexPath.row]] ? kziti :kwuliu;
            cell.data = _data[indexPath.row];
            cell.delegate = self;
            _cellH = [cell getCellHeight];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else
        {
            static NSString *IDC = @"DoneSCell";
            DoneServerCell *cell = [tableView dequeueReusableCellWithIdentifier:IDC];
            if (cell == nil) {
                cell = [[DoneServerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDC];
            }
            cell.type = [self isSelfGet:_data[indexPath.row]] ? kziti :kwuliu;
            cell.data = _data[indexPath.row];
            cell.delegate = self;
            _cellH = [cell getCellHeight];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(CGFloat) cellHeight:(NSUInteger) count isSelfGet:(BOOL )isSelfget
{
    CGFloat h = 0.0;
    if (_selectedBtn.tag == 0 + KMenuTag) {
        if (loinType == 0) {
            //"unSendCustomCell";
            h = firstViewH + count * proH + firstViewH + startXY * 2 + btnH + 5;
        }else
        {
            //"unSendServerCell";
            if (isSelfget) {
                h = firstViewH + count * proH + firstViewH + startXY * 2 + btnH + 30+ 5;
            }else
            {
                h = firstViewH + count * proH + firstViewH + startXY * 2 + btnH + 50+ 5;
            }
            
        }
    }else if (_selectedBtn.tag == 1 + KMenuTag)
    {
        if (loinType == 0) {
            //"SendingCustomCell";
            h = firstViewH + count * proH + firstViewH + startXY * 2 + btnH+ 5;
        }else
        {
            //"SendingSCell";
            h = firstViewH + count * proH + firstViewH + startXY * 2 + btnH + 5;
        }
    }else
    {
        if (loinType == 0) {
            //"DoneCustomCell";
            if (isSelfget) {
                h = firstViewH + count * proH + 35 + startXY * 2 + btnH - 10;
            }else
            {
                h = firstViewH + count * proH + 55 + startXY * 2 + btnH - 10;
            }
        }else
        {
            //"DoneSCell";
            if (isSelfget) {
                h = firstViewH + count * proH + 30 + startXY * 2 + btnH + 5;
            }else
            {
                h = firstViewH + count * proH + 50 + startXY * 2 + btnH + 5;
            }
        }
    }
    return h ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderModel *data = _data[indexPath.row];
    NSUInteger count = data.products.count;
    BOOL isself = [self isSelfGet:_data[indexPath.row]]? kziti :kwuliu;
//    NSLog(@"%f",[self cellHeight:count isSelfGet:isself]);
    return [self cellHeight:count isSelfGet:isself];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)OrderCellBtnCliked:(OrderBtnClickedType)type withOrderID:(NSString *)orderID
{
    switch (type) {
        case KOrderBtnClickedTypeConform:
            //确认收货
        {
            [self confromwithID:orderID];
        }
            break;
        case KOrderBtnClickedTypeDetal:
            //订单详情
        {
            OrderDetailController *od = [[OrderDetailController alloc] init];
            od.orderID = orderID;
            [self.navigationController pushViewController:od animated:YES];
        }
            break;
        case kOrderBtnClickedTypeWuliu:
            //物流信息
        {
            ChenkStatusController *cs = [[ChenkStatusController alloc] init];
            [self.navigationController pushViewController:cs animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void) confromwithID:(NSString *)orderID
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:orderID,@"order_id", nil];
    [HttpTool postWithPath:@"confirmReceipt" params:parm success:^(id JSON, int code) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
         NSString *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
        if (code == 100) {
            [self loadData];
        }else
        {
            
        }
        [RemindView showViewWithTitle:data location:MIDDLE];
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}
@end

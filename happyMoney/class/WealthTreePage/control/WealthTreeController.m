//
//  WealthTreeController.m
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "WealthTreeController.h"
#import "TreeProductCell.h"
#import "ProductController.h"
#import "ProductButton.h"
#import "CategoryModel.h"

@interface WealthTreeController ()<UITableViewDataSource,UITableViewDelegate,ProductCellDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation WealthTreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    
    //1 tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,kWidth,KContentH) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = HexRGB(0xeeeeee);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    [self loadData];
    _dataArray = [NSMutableArray array];
}

-(void) loadData
{
    //拉取分类列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    [HttpTool postWithPath:@"getCategoryList" params:nil success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            
            for (NSDictionary *dic in data) {
                CategoryModel *model = [[CategoryModel alloc] initWithDic:dic];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = (_dataArray.count + kProductPerRow - 1) / kProductPerRow;
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cellName";
    TreeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TreeProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.delegate = self;
    }
    NSUInteger loc = indexPath.row * kProductPerRow;
    NSUInteger len = kProductPerRow;
    if (loc + len > _dataArray.count) {
        len =  _dataArray.count - loc;
    }
    NSRange range = NSMakeRange(loc, len);
    
    NSArray *array = [_dataArray subarrayWithRange:range];
    ;
    cell.myIndexPath = indexPath;
    // 设置表格行要填充的内容,先判断是否是第一行，去掉top line
    [cell resetButttonWithArray:array isfirst:indexPath.row == 0];
    // 让表格行记录住当前的行数
    [cell setCellRow:indexPath.row];
    return  cell;
}

#pragma mark 点击cell
-(void)productCell:(TreeProductCell *)productCell didSelectedButteon:(ProductButton *)button andIndex:(NSIndexPath *)indexPath
{
    //进入产品
    ProductController *pd = [[ProductController alloc] init];
    NSInteger index = (indexPath.row) * kProductPerRow  + (button.tag - kStartTag);
    pd.cateData = _dataArray[index];
    [self.navigationController pushViewController:pd animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

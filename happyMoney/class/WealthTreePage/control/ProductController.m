//
//  ProductController.m
//  happyMoney
//
//  Created by promo on 15-4-3.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ProductController.h"
#import "ProductCell.h"
#import "Product.h"
#import "ProductDetailController.h"
#import "CategoryModel.h"
#import "SortButton.h"
#import "BBBadgeBarButtonItem.h"
#import "CarTool.h"
#import "ProductDetailModel.h"
#import "BuycarController.h"
#import "SystemConfig.h"
#import "UserItem.h"
#import "MJRefresh.h"

@interface ProductController ()<UITableViewDataSource,UITableViewDelegate,sortDelegate,MJRefreshBaseViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    CGFloat _cellH;
    int _totaNum;
    SortButton *_saleNumBtn;
    SortButton *_priceBtn;
    MJRefreshFooterView *_footer;
    BOOL isLoadMore;//判断是否加载更多
    NSInteger _pageNum;
}
@end

@implementation ProductController

-(void)viewWillAppear:(BOOL)animated
{
    if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"] || ![SystemConfig sharedInstance].isUserLogin)
    {
        //1 计算购物车数量
        if (self.navigationItem.rightBarButtonItem) {
            BBBadgeBarButtonItem *barButton = (BBBadgeBarButtonItem *)self.navigationItem.rightBarButtonItem;
            barButton.badgeValue = [NSString stringWithFormat:@"%ld", (long)[self totalCarNum] ];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = self.cateData.name;
    
    _pageNum = 1;
    
    [self buildUI];
    [self addRefreshViews];
    NSString *sort = [NSString stringWithFormat:@"price %@,sell_num %@",@"asc",@"desc"];
    [self loadDataWith:sort];
}

#pragma mark 集成刷新控件
- (void)addRefreshViews
{
    // 1.上拉加载更多
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.delegate = self;
    _footer = footer;
    isLoadMore = YES;
}

#pragma mark 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {
        // 上拉加载更多
        [self addLoadStatus:refreshView];
    }
}


#pragma mark 加载更多
-(void)addLoadStatus:(MJRefreshBaseView *)refreshView{
    _pageNum++;
    [self sortwith:refreshView];
}

-(void)sortwith:(MJRefreshBaseView *)refreshView
{
    NSString * saleParm = @"";
    NSString *priceParm = @"";
    if (_saleNumBtn.sortStatus == upTodown) {
        NSLog(@"销量状态：由高到低");
        saleParm = @"desc";
    }else
    {
        NSLog(@"销量状态：由低到高");
        saleParm = @"asc";
    }
    
    if (_priceBtn.sortStatus == upTodown) {
        NSLog(@"价格状态：由高到低");
        priceParm = @"desc";
    }else
    {
        NSLog(@"价格状态：由低到高");
        priceParm = @"asc";
    }
    NSString *sort = [NSString stringWithFormat:@"price %@,sell_num %@",priceParm,saleParm];
    [self loadDataWith:sort withFreshview:refreshView];
}

-(void)loadDataWith:(NSString *)sort withFreshview:(MJRefreshBaseView *)refreshView
{
    //拉取分类列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)_pageNum],@"page",@"10",@"page_size",self.cateData.ID,@"category_id",sort,@"sort",nil];
    NSLog(@"%@",sort);
    [HttpTool postWithPath:@"getProductList" params:parm success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            
            if (!_dataArray) {
                _dataArray = [NSMutableArray array];
            }
            if (data.count > 0) {
                if (data.count < 10) {
                    //没有更多数据
                    _footer.hidden = YES;
                }else{
                    _footer.hidden = NO;
                }
                for (NSDictionary *dic in data) {
                    Product *model = [[Product alloc] initWithDictionaryForGategory:dic];
                    [_dataArray addObject:model];
                }
            }
            [_tableView reloadData];
            [refreshView endRefreshing];
        }else
        {
            _footer.hidden = YES;
            [refreshView endRefreshing];
            NSString *str = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            [RemindView showViewWithTitle:str location:MIDDLE];
        }

    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

//判断价格和销量排序
- (void)sort
{
    NSString * saleParm = @"";
    NSString *priceParm = @"";
    if (_saleNumBtn.sortStatus == upTodown) {
        NSLog(@"销量状态：由高到低");
        saleParm = @"desc";
    }else
    {
        NSLog(@"销量状态：由低到高");
        saleParm = @"asc";
    }
    
    if (_priceBtn.sortStatus == upTodown) {
        NSLog(@"价格状态：由高到低");
        priceParm = @"desc";
    }else
    {
        NSLog(@"价格状态：由低到高");
        priceParm = @"asc";
    }
    NSString *sort = [NSString stringWithFormat:@"price %@,sell_num %@",priceParm,saleParm];
    [self loadDataWith:sort];
    
}
-(void)loadDataWith:(NSString *)sort
{
    //拉取分类列表
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    //每次点击，都要重新获取数据，删除上次的
    //先得到上次总共有多少数据，然后计算重新排序后需要请求的数据，注意：不能直接修改 _pageNum 为1
    NSInteger lastpageSize = _dataArray.count;
    NSInteger requestSize = 0;
    if (lastpageSize == 0) {
        requestSize = 10;
    }else
    {
        requestSize = lastpageSize;
    }
    NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"page",[NSString stringWithFormat:@"%ld",(long)requestSize],@"page_size",self.cateData.ID,@"category_id",sort,@"sort",nil];
//    NSLog(@"%@",sort);
    [HttpTool postWithPath:@"getProductList" params:parm success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSArray *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            
            if (!_dataArray) {
                _dataArray = [NSMutableArray array];
            }else
            {
                [_dataArray removeAllObjects];
            }
            if (data.count > 0) {
                if (data.count < _pageNum * 10) {
                    //没有更多数据
                    _footer.hidden = YES;
                }else{
                    _footer.hidden = NO;
                }
                for (NSDictionary *dic in data) {
                    Product *model = [[Product alloc] initWithDictionaryForGategory:dic];
                    [_dataArray addObject:model];
                }
            }
            [_tableView reloadData];
            
            //滚动到第一行
            NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
            [_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            [self buildUI];
        }else
        {
            NSString *str = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            [RemindView showViewWithTitle:str location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}


#pragma mark 计算badgeNum
-(NSUInteger)totalCarNum
{
    NSUInteger count = [CarTool sharedCarTool].totalCarMenu.count;
    int total = 0;
    for (int i = 0; i < count; i++) {
        ProductDetailModel *data = [CarTool sharedCarTool].totalCarMenu[i];
        total += data.productCount;
    }
    _totaNum = total;
    return _totaNum;
//    return [CarTool sharedCarTool].totalCarMenu.count;
}

-(void)barcar
{
    BuycarController *ctl = [[BuycarController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void)buildUI
{
    UIButton *foodcar = [UIButton buttonWithType:UIButtonTypeCustom];
    foodcar.frame = Rect(0, 0, 30, 30);
    [foodcar addTarget:self action:@selector(barcar) forControlEvents:UIControlEventTouchUpInside];
    [foodcar setBackgroundImage:LOADPNGIMAGE(@"Bcar") forState:UIControlStateNormal];
    
    if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"] || ![SystemConfig sharedInstance].isUserLogin)
    {
        BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomView:foodcar];
        
        barButton.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)[self totalCarNum]];
        barButton.badgeBGColor = [UIColor whiteColor];
        barButton.badgeTextColor = HexRGB(0x899c02);
        barButton.badgeFont = [UIFont systemFontOfSize:11.5];
        barButton.badgeOriginX = 20;
        barButton.badgeOriginY = 0;
        barButton.shouldAnimateBadge = YES;
        self.navigationItem.rightBarButtonItem = barButton;
    }
    
    //1 菜单栏
    CGFloat menuH = 60;
    NSArray *menuTitles = @[@"销量",@"价格"];
    NSArray *imgs = @[@"销售量",@"价格"];
    for (int i = 0; i < menuTitles.count; i++) {
        CGFloat menuX = kWidth/2*i;
        SortButton *menuBrn = [[SortButton alloc] initWithFrame:Rect(menuX, 0, kWidth/2, menuH)];
        if (i == 0) {
            _saleNumBtn = menuBrn;
        }else
        {
            _priceBtn = menuBrn;
        }
        [menuBrn setTitle:menuTitles[i] forState:UIControlStateNormal];
        [menuBrn setTitle:menuTitles[i] forState:UIControlStateHighlighted];
        [menuBrn setImage:LOADPNGIMAGE(imgs[i]) forState:UIControlStateNormal];
        [menuBrn setImage:LOADPNGIMAGE(imgs[i]) forState:UIControlStateHighlighted];
        [menuBrn setTitleColor:HexRGB(0x3a3a3a) forState:UIControlStateNormal];
        [menuBrn setTitleColor:HexRGB(0x56b001) forState:UIControlStateHighlighted];
        menuBrn.frame = Rect(menuX, 0, kWidth/2, menuH);
        menuBrn.tag = i + KSortBtnStartTag;
        menuBrn.btnTag = i + KSortBtnStartTag;
        menuBrn.delegate = self;
        [self.view addSubview:menuBrn];
        [menuBrn setTitle:menuTitles[i] forState:UIControlStateNormal];
        [menuBrn addTarget:self action:@selector(menuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 1) {
            UIImageView *line = [[UIImageView alloc] initWithFrame:Rect(menuX - 1, 0, 1, menuH)];
            line.image = LOADPNGIMAGE(@"shuxian");
            [self.view addSubview:line];
        }
    }
    
    //2 tableView
    CGFloat tableY  = menuH + 10;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableY,kWidth,KAppNoTabHeight - tableY ) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = HexRGB(0xffffff);
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

#pragma mark 菜单按钮点击
- (void)menuBtnClicked:(SortButton *)btn
{
    //1 change status
    [btn changeArrowStatus];
    
    //2 sort
    
}

#pragma mark --------tableView_delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%lu",(unsigned long)_dataArray.count);
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellName";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = _dataArray[indexPath.row];
    _cellH = [cell getCellH];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//     NSLog(@"%f",100.0);
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailController *ctl = [[ProductDetailController alloc] init];
    Product *data = _dataArray[indexPath.row];
    ctl.ID = data.ID;
    [self.navigationController pushViewController:ctl animated:YES];
}

@end

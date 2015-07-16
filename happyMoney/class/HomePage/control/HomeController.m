//
//  HomeController.m
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "HomeController.h"
#import "KDCycleBannerView.h"
#import "FortuneCircleController.h"
#import "BuycarController.h"
#import "InviteFriendsController.h"
#import "MyOrderController.h"
#import "HomeItemView.h"
#import "CheckRecordsController.h"
#import "AdsItem.h"
#import "UserInfor.h"
#import "RelationModel.h"
#import "SystemConfig.h"
#import "MyOrderController.h"
#import "BannerWebView.h"
#import "ServerHitView.h"
#import "SystemConfig.h"
#import "LoginController.h"
#import "UserItem.h"
#import "CheckRecordsController.h"

//#define KMenuButtonW 143 //菜单按钮宽度

//#define KStartX   ((kWidth - KMenuButtonW * 2)/3) //x坐标左右间距

#define kLeft 11
#define KMiddle 16
#define KMenuW  (kWidth - (kLeft + KMiddle) * 2)/3
#define KCateBtnW (kWidth - kLeft * 2 - 14)/2
#define KWHRatio  158/284 //图片宽高比
#define KMenyButtonH    KCateBtnW * KWHRatio //菜单按钮高度

@interface HomeController ()<KDCycleBannerViewDataource,KDCycleBannerViewDelegate,HomeItemDelegate>
{
    UIScrollView *_backScroll;
    KDCycleBannerView *_bannerView;
    UIButton *_selectedBtn;
    NSMutableArray *_Adsarray;
    NSMutableArray *_imgarray;
}
@property (nonatomic,strong) NSMutableArray *bannerArray;//广告条数组
@property (nonatomic,strong) NSMutableArray *relationArray;
@property (nonatomic,strong) RelationModel *relation;
@property (nonatomic,strong) UserInfor *uerInfo;
@end

@implementation HomeController

-(void)viewWillAppear:(BOOL)animated
{
    if (_backScroll) {
        [_backScroll removeFromSuperview];
        [self loadData];
        //重设UI数据
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    
//    [SystemConfig sharedInstance].userType = 1; //1 普通用户 ，2 商家
//    [self initBackView];
    //3 load data
    [self autoLogin];
}

#pragma mark 自动登录
-(void)autoLogin
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *account = [user objectForKey:Account];
    NSString *password = [user objectForKey:Password];
    NSString *type = [user objectForKey:UserType];
    NSInteger isQuit = [[user objectForKey:quitLogin] integerValue];
    if (account && password && isQuit == 1) {
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:account,@"phone_num",password,@"password",type,@"type", nil];
        [HttpTool postWithPath:@"login" params:param success:^(id JSON, int code) {
            NSLog(@"%@",JSON);
            NSDictionary *response = [JSON objectForKey:@"response"];
            if (code == 100) {
                UserItem *item = [[UserItem alloc] initWithDic:[response objectForKey:@"data"]];
                //单例存储用户相关信息
                [SystemConfig sharedInstance].userType = [type intValue];
                [SystemConfig sharedInstance].isUserLogin = YES;
                //                [SystemConfig sharedInstance].uid = item.uid;
                [SystemConfig sharedInstance].user = item;
                //                [SystemConfig sharedInstance].isUserLogin = NO;
                
                [self loadData];
            }
        } failure:^(NSError *error) {
//            [RemindView showViewWithTitle:offline location:MIDDLE];
            [self loadData];
        }];
    }else
    {
        [self loadData];
    }
}

-(void)loadData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    [HttpTool postWithPath:@"getIndex" params:nil success:^(id JSON, int code) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            //banner data
            NSArray *banerArray = [data objectForKey:@"ads"];
            if (!_Adsarray) {
                _Adsarray = [NSMutableArray arrayWithCapacity:10];
            }else
            {
                [_Adsarray removeAllObjects];
                
            }
            if (!self.bannerArray) {
                self.bannerArray = [NSMutableArray array];
            }else
            {
                [self.bannerArray removeAllObjects];
                
            }
            if (!_imgarray) {
                _imgarray = [NSMutableArray array];
            }else
            {
                [_imgarray removeAllObjects];
                
            }
            
            for (NSDictionary *dic in banerArray) {
                AdsItem *item = [[AdsItem alloc] initWithDictionary:dic];
                [self.bannerArray addObject:item];
                [_Adsarray addObject:item];
                [_imgarray addObject:item.imgUrl];
            }
            //numbers
            NSDictionary *munber = [data objectForKey:@"data"];
            _relation = [[RelationModel alloc] initWithDictionary:munber];
            
            //userinfo
            NSDictionary *user = [data objectForKey:@"userInfo"];
            
            if (![user isKindOfClass:[NSNull class]]) {
                _uerInfo = [[UserInfor alloc] initWithDictionary:user];
            }
            [self buildUI];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 菜单栏delegate
- (void)homeItemBtnClieked:(HomeItemView *)view clickedBtnTag:(NSInteger)tag
{
    if (tag == HomeClose) {
        //
//        BanlanceController *check = [[BanlanceController alloc] init];
//        [self.navigationController pushViewController:check animated:YES];
    }else if (tag == HomeDirect)
    {
        //直接会员
    }else
    {
        //间接会员
    }
    CheckRecordsController *ctl = [[CheckRecordsController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark 分类按钮点击
-(void) cateButtonclicked:(UIButton *)btn
{
    if ([SystemConfig sharedInstance].isUserLogin) {
    switch (btn.tag) {
        case KHomeMenu4:
        {
            FortuneCircleController *cirle = [[FortuneCircleController alloc] init];
            [self.navigationController pushViewController:cirle animated:YES];
        }
            break;
        case KHomeMenu5:
        {
            if ([[SystemConfig sharedInstance].user.type isEqualToString:@"0"]) {
                BuycarController *car = [[BuycarController alloc] init];
                [self.navigationController pushViewController:car animated:YES];
            }else
            {
                MyOrderController *mo = [[MyOrderController alloc] init];
                [self.navigationController pushViewController:mo animated:YES];
            }
        }
            break;
        case KHomeMenu6:
        {
            CheckRecordsController *check = [[CheckRecordsController alloc] init];
            [self.navigationController pushViewController:check animated:YES];
        }
            break;
        case KHomeMenu7:
        {
            InviteFriendsController * invite= [[InviteFriendsController alloc] init];
            [self.navigationController pushViewController:invite animated:YES];
        }
            break;
        default:
            break;
    }
    }else
    {
        LoginController *log = [[LoginController alloc] init];
        [self.navigationController pushViewController:log animated:YES];
    }
}

#pragma mark 菜单栏点击
-(void) menuClieked:(UIButton *)btn
{
    if (_selectedBtn != btn) {
        
        btn.selected = !btn.selected;
        _selectedBtn = btn;
        
        if (btn.tag == KHomeMenu1) {
            //收益结算
        }else if (btn.tag == KHomeMenu2)
        {
            //一级消费商
        }else
        {
            //二级消费商
        }
    }
}

#pragma mark 底部scrollview
-(void) initBackView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KContentH)];
    [self.view addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
}

-(void) buildUI
{
    [self initBackView];
    
    // 2 广告条
    [self initBannerView];
    [_bannerView reloadDataWithCompleteBlock:^{
        
    }];
    // 3 菜单栏
    CGFloat startX = kLeft;
    CGFloat menuY = CGRectGetMaxY(_bannerView.frame) + 25;
    CGFloat menuW = KMenuW;
    CGFloat menuH = menuW;
    CGFloat viewH = 0;
    CGFloat menuBtnMaxY = 0;
    
    NSArray *menuTitles = @[@"收益结算",@"一级供应商",@"二级供应商"];
    NSArray *iconTitles = @[@"首页2_10",@"首页2_12",@"首页2_14"];
    
    NSArray *nums = nil;
    if ([SystemConfig sharedInstance].isUserLogin) {
        nums = @[_relation.profit,_relation.first_num,_relation.second_num];
    }else
    {
        nums = @[@"0",@"0",@"0"];
    }

    for (int i = 0; i < menuTitles.count; i++) {
        CGRect rect = CGRectMake(startX + (menuW + KMiddle) * i, menuY, menuW, menuH);
        HomeItemView * menuBtn = [[HomeItemView alloc] initWithFrame:rect icon:iconTitles[i] title:menuTitles[i] num:nums[i] btnTag:i];
        menuBtn.delegate = self;
        
        [_backScroll addSubview:menuBtn];
        menuBtn.tag = i;
        if (i == 0) {
            viewH = CGRectGetMaxY(menuBtn.frame);
            menuBtnMaxY = viewH + 25;
        }
    }
    
    // 4 4个分类
    int imgTag = -1;
    NSArray *imgs = [NSArray array];
    
    if ([SystemConfig sharedInstance].isUserLogin) {
        if ([[SystemConfig sharedInstance].user.type isEqualToString:@"1"] ) {
            imgs = @[@"homeMenu1",@"homeMenu2S",@"homeMenu3",@"homeMenu4"];
        }else
        {
            imgs = @[@"homeMenu1",@"homeMenu2",@"homeMenu3",@"homeMenu4"];
        }
    }else
    {
        imgs = @[@"homeMenu1",@"homeMenu2",@"homeMenu3",@"homeMenu4"];
    }
    
    for (int i = 0; i < 2; i++) {//2行
        for (int j = 0; j < 2 ; j++) {//2列
            UIButton * menu = [UIButton buttonWithType:UIButtonTypeCustom];
            //计算frame
            CGFloat cateBtnY = menuBtnMaxY;
            
            CGFloat x = kLeft + (KCateBtnW + 14) * j;
            CGFloat y = cateBtnY + (KMenyButtonH + 16) * i;
            menu.frame = Rect(x, y, KCateBtnW, KMenyButtonH);
            //设置图片和tag
            imgTag++;
            menu.tag = imgTag;
            menu.backgroundColor = [UIColor clearColor];
            NSString *imgNomralName = imgs[imgTag];
            NSString *imgClickedName = imgs[imgTag];
            [menu setBackgroundImage:LOADPNGIMAGE(imgNomralName) forState:UIControlStateNormal];
            [menu setBackgroundImage:LOADPNGIMAGE(imgClickedName) forState:UIControlStateSelected];
            [menu setBackgroundImage:LOADPNGIMAGE(imgClickedName) forState:UIControlStateHighlighted];
            [menu addTarget:self action:@selector(cateButtonclicked:) forControlEvents:UIControlEventTouchUpInside];
            [_backScroll addSubview:menu];
            if (i == 1) {
                viewH = y + KMenyButtonH;
            }
        }
    }
    _backScroll.contentSize = CGSizeMake(kWidth, viewH + 10);
}

#pragma mark 初始化广告条view
-(void)initBannerView{
    if (_bannerView) {
        [_bannerView removeFromSuperview];
        _bannerView = nil;
        _bannerView =[[KDCycleBannerView alloc] initWithFrame:CGRectMake(0, 0,kWidth,140)];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.datasource = self;
        _bannerView.delegate = self;
        _bannerView.continuous = YES;
        _bannerView.autoPlayTimeInterval = self.bannerArray.count;
        [_backScroll addSubview:_bannerView];
    }else
    {
        _bannerView =[[KDCycleBannerView alloc] initWithFrame:CGRectMake(0, 0,kWidth,140)];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.datasource = self;
        _bannerView.delegate = self;
        _bannerView.continuous = YES;
        _bannerView.autoPlayTimeInterval = self.bannerArray.count;
        [_backScroll addSubview:_bannerView];
    }
}

#pragma mark KDCycleBannerViewDataource
- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView{
    
    return _imgarray;
}

- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index{
    return UIViewContentModeScaleAspectFill;
}

- (UIImage *)placeHolderImageOfBannerView:(KDCycleBannerView *)bannerView atIndex:(NSUInteger)index{
    return placeHoderImage1;
}

#pragma mark  滚动到第几个图片
- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index{
    
}

#pragma mark  选中第几个图片
- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index{
    BannerWebView *ban = [[BannerWebView alloc] init];
    AdsItem *item = _Adsarray[index];
    ban.link = item.link;
    [self.navigationController pushViewController:ban animated:YES];
}


@end

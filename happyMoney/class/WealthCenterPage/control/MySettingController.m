//
//  MySettingController.m
//  happyMoney
//  设置
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MySettingController.h"
#import "ModifyInfoController.h"
#import "ChangePassWordController.h"
#import "AboutUsController.h"
#import "MemoryClearController.h"
#import "FeedBackController.h"
#import "CheckVersonController.h"
#import "MySettingItem.h"
#import "SystemConfig.h"
#import "ProAlertView.h"
#import "MainController.h"
#import "CarTool.h"

@interface MySettingController ()<ProAlertViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    NSString *_download_link;
}
@end

@implementation MySettingController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"设置";
    
    CGFloat scrollH = KContentH + 44;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, scrollH)];
    //    [self.view addSubview:scroll];
    
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.backgroundColor = [UIColor clearColor];
    scroll.userInteractionEnabled = YES;
    [self.view addSubview:scroll];
    
    NSArray *section1 = @[@"修改资料",@"修改密码"];
    NSArray *section2 = @[@"关于我们",@"清除缓存" ,@"意见反馈",@"检查更新"];
    _dataArray = [NSArray arrayWithObjects:section1,section2, nil];
    
    //section 1
    CGFloat startXY = 15;
    CGFloat itemH = 50;
    
    UIView *sectionViewOne = [[UIView alloc] initWithFrame:Rect(startXY, startXY, kWidth - startXY * 2, itemH * 2)];
    [scroll addSubview:sectionViewOne];
    sectionViewOne.backgroundColor = [UIColor whiteColor];
    sectionViewOne.layer.masksToBounds = YES;
    sectionViewOne.layer.cornerRadius = 5.0f;
    
    for (int i = 0; i < 2; i++) {
        CGFloat itemY = itemH * i;
        MySettingItem *settingItem = [[MySettingItem alloc] initWithFrame:Rect(0, itemY, kWidth - startXY * 2, itemH) hasRightArrow:YES withTitle:section1[i]];
        [settingItem.ViewBtn addTarget:self action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        settingItem.ViewBtn.tag = i;
        [sectionViewOne addSubview:settingItem];
        if (i == 1) {
            settingItem.line.hidden = YES;
        }
    }
    
    
    //seection 2
    CGFloat scroolH = CGRectGetMaxY(sectionViewOne.frame) + startXY;
    
    UIView *sectionViewTwo = [[UIView alloc] initWithFrame:Rect(startXY, scroolH, kWidth - startXY * 2, itemH * 4)];
    [scroll addSubview:sectionViewTwo];
    sectionViewTwo.backgroundColor = [UIColor whiteColor];
    sectionViewTwo.layer.masksToBounds = YES;
    sectionViewTwo.layer.cornerRadius = 5.0f;
    
    for (int i = 0; i < 4; i++) {
        CGFloat itemY = itemH * i;
        MySettingItem *settingItem;
        if (i == 3) {
            settingItem = [[MySettingItem alloc] initWithFrame:Rect(0, itemY, kWidth - startXY * 2, itemH) hasRightArrow:NO withTitle:section2[i]];
            settingItem.line.hidden = YES;
        }else if (i == 1)
        {
            settingItem = [[MySettingItem alloc] initWithFrame:Rect(0, itemY, kWidth - startXY * 2, itemH) hasRightArrow:NO withTitle:section2[i]];
        }
        else
        {
            settingItem = [[MySettingItem alloc] initWithFrame:Rect(0, itemY, kWidth - startXY * 2, itemH) hasRightArrow:YES withTitle:section2[i]];
        }
        [settingItem.ViewBtn addTarget:self action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        settingItem.ViewBtn.tag = i + 2;
        [sectionViewTwo addSubview:settingItem];
    }
    
    if ([SystemConfig sharedInstance].isUserLogin) {
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        exitBtn.frame = Rect(startXY, CGRectGetMaxY(sectionViewTwo.frame) + startXY, kWidth - startXY * 2, 40);
        [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        exitBtn.backgroundColor = ButtonColor;
        exitBtn.layer.masksToBounds = YES;
        exitBtn.layer.cornerRadius = 5.0f;
//        exitBtn.layer.borderColor = [UIColor greenColor].CGColor;
//        exitBtn.layer.borderWidth = 1.0;
        [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [scroll addSubview:exitBtn];
        [exitBtn addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
        scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(exitBtn.frame) + 10) ;
    }else
    {
        scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(sectionViewTwo.frame) + 10) ;
    }
}

#pragma mark 推出登录
-(void)exitLogin
{
    ProAlertView *alertView = [[ProAlertView alloc] initWithTitle:nil withMessage:@"确定要退出登录吗?" delegate:self cancleButton:@"取消" otherButton:@"确定", nil];
    alertView.tag = 1001;
    [alertView show];
}

-(void)settingBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
        {
            ModifyInfoController *mi = [[ModifyInfoController alloc] init];
            [self.navigationController pushViewController:mi animated:YES];
        }
            break;
        case 1:
        {
            ChangePassWordController *cw = [[ChangePassWordController alloc] init];
            [self.navigationController pushViewController:cw animated:YES];
        }
            break;
        case 2:
        {
            AboutUsController *au = [[AboutUsController alloc] init];
            [self.navigationController pushViewController:au animated:YES];
        }
            break;
        case 3:
        {
            [self clearCaches];
        }
            break;
        case 4:
        {
            FeedBackController *fb = [[FeedBackController alloc] init];
            [self.navigationController pushViewController:fb animated:YES];
        }
            break;
        case 5:
        {
            //检查版本更新
            [self checkVerson];
        }
            break;
        default:
            break;
    }
}

#pragma mark  清空缓存
- (void)clearCaches
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files :%lu",(unsigned long)[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    }
                   );
    
}

#pragma mark 清空缓存成功
- (void)clearCacheSuccess
{
    [RemindView showViewWithTitle:@"缓存已清空" location:MIDDLE];
}

#pragma mark 版本更新
-(void)checkVerson
{
    [HttpTool postWithPath:@"getNewestVersion" params:nil success:^(id JSON, int code) {
        if (code == 100) {
            //当前版本
            NSString *currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
            float currentVersion_float = [currentVersion floatValue];
            //服务器存储版本
            NSString *version = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"version"];
            float version_float = [version floatValue];
            if (currentVersion_float < version_float) {
                _download_link = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"url"];
                ProAlertView *alertView = [[ProAlertView alloc] initWithTitle:@"温馨提示" withMessage:@"检测到新版本,是否前往更新" delegate:self cancleButton:@"取消" otherButton:@"前往更新", nil];
                alertView.tag = 1000;
                alertView.delegate = self;
                [alertView show];
            }else
            {
                NSString *msg = [[[JSON objectForKey:@"response"] objectForKey:@"data"] objectForKey:@"msg"];
                [RemindView showViewWithTitle:msg location:MIDDLE];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}


- (void)proAclertView:(ProAlertView *)alertView clickButtonAtIndex:(NSInteger)index
{
    if (alertView.tag == 1000) {
        if (index == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_download_link]];
        }
    }else if (alertView.tag == 1001)
    {
        if (index ) {
            MainController *rc= [[MainController alloc] init];
            self.view.window.rootViewController = rc;
            
            //清空用户存储的所有数据  以后处理
            [SystemConfig sharedInstance].isUserLogin = NO;
            //        [SystemConfig sharedInstance].userType = 0;
            [SystemConfig sharedInstance].user = nil;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            //        [user removeObjectForKey:Account];
            //        [user removeObjectForKey:Password];
            [user setObject:@"0" forKey:quitLogin];//退出登录, 0 表示已经退出了
            //清空购物车
            [[CarTool sharedCarTool] clear];
            //        [user removeObjectForKey:UserType];
        }
    }
}

@end

//
//  MainController.m
//  新浪微博
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MainController.h"
#import "Dock.h"
#import "HomeController.h"
#import "WealthCenterController.h"
#import "WealthCircleController.h"
#import "WealthTreeController.h"
#import "UIBarButtonItem+MJ.h"
#import "WBNavigationController.h"
#import "SystemConfig.h"
#import "RegistControllerView.h"
#import "LoginController.h"

#define kDockHeight 44

@interface MainController () <DockDelegate,UINavigationControllerDelegate,LoginDelegate>
@end
@implementation MainController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    // 1.初始化所有的子控制器
    [self addAllChildControllers];
    
    // 2.初始化DockItems
    [self addDockItems];
}

#pragma mark 初始化所有的子控制器
- (void)addAllChildControllers
{
    // 1.首页
    HomeController *home = [[HomeController alloc] init];
    home.title  = @"转乐赚";
//    RegistControllerView *regist = [[RegistControllerView alloc] init];
//    regist.title  = @"注册";
        WBNavigationController *nav1 = [[WBNavigationController alloc] initWithRootViewController:home];
        nav1.delegate = self;
    // self在，添加的子控制器就存在
    [self addChildViewController:nav1];
    
    //  2.财富树
    WealthTreeController *wealthTree = [[WealthTreeController alloc] init];
    wealthTree.title = @"财富树";
        WBNavigationController *nav2 = [[WBNavigationController alloc] initWithRootViewController:wealthTree];
        nav2.delegate = self;
    [self addChildViewController:nav2];
 
    // 3.财富圈
    WealthCircleController *wealthCircle = [[WealthCircleController alloc] init];
    wealthCircle.title = @"财富圈";
    
    WBNavigationController *nav3 = [[WBNavigationController alloc] initWithRootViewController:wealthCircle];
    
    nav3.delegate = self;
    [self addChildViewController:nav3];
    
    // 4.财富中心
    WealthCenterController *wealthCenter = [[WealthCenterController alloc] init];
    wealthCenter.title = @"财富中心";
//    me.delegate = self;
        WBNavigationController *nav4 = [[WBNavigationController alloc] initWithRootViewController:wealthCenter];
        nav4.delegate = self;
    [self addChildViewController:nav4];
    
}

- (void)loginWithSelectedIndex:(NSInteger)selectedIndex
{
    LoginController *login  = [[LoginController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:login];
        login.delegate = self;
        login.type = selectedIndex;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 实现导航控制器代理方法
// 导航控制器即将显示新的控制器
- (void)navigationController:(WBNavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    if (![viewController isKindOfClass:[HomeController class]])
    // 如果显示的不是根控制器，就需要拉长导航控制器view的高度
    
    // 1.获得当期导航控制器的根控制器
    UIViewController *root = navigationController.viewControllers[0];
    if (root != viewController) { // 不是根控制器
        // {0, 20}, {320, 460}
        // 2.拉长导航控制器的view
        CGRect frame = navigationController.view.frame;
        if (IsIos7) {
            frame.size.height = [UIScreen mainScreen].applicationFrame.size.height+20;
        }else{
            frame.size.height = [UIScreen mainScreen].applicationFrame.size.height;
        }

        navigationController.view.frame = frame;
        
        // 3.添加Dock到根控制器的view上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        dockFrame.origin.y = root.view.frame.size.height - _dock.frame.size.height;
        if ([root.view isKindOfClass:[UIScrollView class]]) { // 根控制器的view是能滚动
            UIScrollView *scroll = (UIScrollView *)root.view;
            dockFrame.origin.y += scroll.contentOffset.y;
        }
        _dock.frame = dockFrame;
        [root.view addSubview:_dock];
        
        // 4.添加左上角的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"nav_return" highlightedIcon:@"nav_return" target:self action:@selector(backItem)];
        
    }
}

- (void)changeController
{
    // 0.移除旧控制器的view
    UIViewController *oldVc = self.childViewControllers[0];
    [oldVc.view removeFromSuperview];
    
    // 1.取出即将显示的控制器
    UIViewController *newVc = self.childViewControllers[1];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - kDockHeight;
    newVc.view.frame = CGRectMake(0, 0, width, height);
    
    // 2.添加新控制器的view到MainController上面
    [self.view addSubview:newVc.view];
    if ([self.delegate respondsToSelector:@selector(changeItem)]) {
        [self.delegate changeItem];
    }
}

- (void)ChangeToHomePage
{
    
}

- (void)backItem
{
    [self.childViewControllers[_dock.selectedIndex] popViewControllerAnimated:YES];
}

- (void)navigationController:(WBNavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        // 1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        if (IsIos7) {
            frame.size.height = [UIScreen mainScreen].applicationFrame.size.height+20 - _dock.frame.size.height;
        }else{
            frame.size.height = [UIScreen mainScreen].applicationFrame.size.height - _dock.frame.size.height;
        }
        
        navigationController.view.frame = frame;
        
        // 2.添加Dock到mainView上面
        [_dock removeFromSuperview];
        CGRect dockFrame = _dock.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _dock.frame.size.height;
        _dock.frame = dockFrame;
        [self.view addSubview:_dock];
        
    }
}

#pragma mark 添加Dock
- (void)addDockItems
{
        // .往Dock里面填充内容
    [_dock addItemWithIcon:@"首页_07" selectedIcon:@"首页_071" title:@"首页"];
    
    [_dock addItemWithIcon:@"首页_09" selectedIcon:@"首页_091" title:@"财富树"];
    
    [_dock addItemWithIcon:@"首页_11" selectedIcon:@"首页_111" title:@"财富圈"];
    
    [_dock addItemWithIcon:@"首页_13" selectedIcon:@"首页_131" title:@"财富中心"];
    
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

//#pragma mark ios7 以上隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; //返回NO表示要显示，返回YES将hiden
//}

@end

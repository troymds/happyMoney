//
//  FortuneCircleController.m
//  happyMoney
//  财富圈详情页面
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "FortuneCircleController.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface FortuneCircleController ()<UIWebViewDelegate>
{
    UIScrollView *_backScroll;
    UIWebView *_web;
}
@end

@implementation FortuneCircleController

- (void)viewWillAppear:(BOOL)animated
{
    if (_web) {
        NSString *url = [NSString stringWithFormat:@"%@index.php?s=/Home/Topic/index/uid/%@.html",kUrl,[SystemConfig sharedInstance].user.ID];
        [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        
//        UIButton *back = (UIButton *)self.navigationController.navigationItem.leftBarButtonItem;
//        if ([_web canGoBack]) {
//            back.hidden = NO;
//        }else
//        {
//            //隐藏
//            back.hidden = YES;
//        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"财富圈";
    //1 加返回按钮
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(webBack) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 80, 30);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    rightBtn.hidden = NO;
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:Rect(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:web];
    web.delegate = self;
    NSString *url = [NSString stringWithFormat:@"%@index.php?s=/Home/Topic/index/uid/%@.html",kUrl,[SystemConfig sharedInstance].user.ID];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    _web = web;
}


- (void)webBack
{
//    UIButton *back = (UIButton *)self.navigationController.navigationItem.rightBarButtonItem;
//    if ([_web canGoBack]) {
//        [_web goBack];
//        back.hidden = NO;
//    }else
//    {
//        //隐藏
//        back.hidden = YES;
//    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    UIBarButtonItem *back = (UIBarButtonItem *)self.navigationItem.rightBarButtonItem;
//    UIButton *bac = (UIButton *)back.customView;
//    if ([_web canGoBack]) {;
//        bac.hidden = NO;
//    }else
//    {
//        //隐藏
//        bac.hidden = YES;
//    }
}
@end

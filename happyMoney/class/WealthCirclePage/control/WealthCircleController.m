//
//  WealthCircleController.m
//  happyMoney
//
//  Created by promo on 15-3-27.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "WealthCircleController.h"
#import "PublishTopicController.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface WealthCircleController ()<UIWebViewDelegate>
{
    UIWebView *_web;
}
@end

@implementation WealthCircleController

- (void)viewWillAppear:(BOOL)animated
{
    if (_web) {
       NSString *url = [NSString stringWithFormat:@"%@index.php?s=/Home/Topic/index/uid/%@.html",kUrl,[SystemConfig sharedInstance].user.ID];
        [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 加返回按钮
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(webBack) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 80, 30);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    rightBtn.hidden = NO;
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:Rect(0, 0, kWidth, KContentH)];
    [self.view addSubview:web];
    web.delegate = self;
    NSLog(@"%@",[SystemConfig sharedInstance].user.ID);
    NSString *url = [NSString stringWithFormat:@"%@index.php?s=/Home/Topic/index/uid/%@.html",kUrl,[SystemConfig sharedInstance].user.ID];
     NSLog(@"%@",url);
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
    PublishTopicController *ctl = [[PublishTopicController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    UIBarButtonItem *back = (UIBarButtonItem *)self.navigationItem.rightBarButtonItem;
//    UIButton *bac = (UIButton *)back.customView;
//    if ([_web canGoBack]) {
//        bac.hidden = NO;
//    }else
//    {
//        //隐藏
//        bac.hidden = YES;
//    }
}

@end

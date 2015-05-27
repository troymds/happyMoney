//
//  BannerWebView.m
//  happyMoney
//
//  Created by promo on 15-5-5.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "BannerWebView.h"

@interface BannerWebView()<UIWebViewDelegate>
{
    UIWebView *_bannerWevView;
}
@end

@implementation BannerWebView

- (void)viewWillAppear:(BOOL)animated
{
    if (_bannerWevView) {

    }
}
-(void)viewDidLoad
{
    UIWebView *web = [[UIWebView alloc] initWithFrame:Rect(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:web];
    _bannerWevView = web;
    web.delegate = self;
    [_bannerWevView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_link]]];
}


@end

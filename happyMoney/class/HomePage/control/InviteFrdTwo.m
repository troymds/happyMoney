//
//  InviteFrdTwo.m
//  happyMoney
//
//  Created by promo on 15-5-20.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "InviteFrdTwo.h"

@interface InviteFrdTwo()<UIWebViewDelegate>
{
    UIWebView *_bannerWevView;
}

@end
@implementation InviteFrdTwo

-(void)viewDidLoad
{
    UIWebView *web = [[UIWebView alloc] initWithFrame:Rect(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:web];
    _bannerWevView = web;
    web.delegate = self;
     NSString *url = [NSString stringWithFormat:@"%@index.php?s=/Home/Share/index.html",kUrl];
    [_bannerWevView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}
@end

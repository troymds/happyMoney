//
//  AboutUsController.m
//  happyMoney
//  关于我们
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "AboutUsController.h"

@interface AboutUsController ()

@end

@implementation AboutUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"关于我们";
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:Rect(0, 0, kWidth, KAppNoTabHeight)];
//    [self.view addSubview:web];
//    NSString *url = [NSString stringWithFormat:@"%@index.php?s=/Home/Wap/aboutus.html",kUrl];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    [self buildUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

-(void) buildUI
{
    CGFloat startXY = 20;
    CGFloat imgW = kWidth - startXY * 2;
    CGFloat imgH = 120;
    UIImageView *img = [[UIImageView alloc] initWithFrame:Rect(startXY, startXY, imgW, imgH)];
    [self.view addSubview:img];
    img.backgroundColor = [UIColor redColor];
    
    
    CGFloat inforY = CGRectGetMaxY(img.frame) + startXY;
    CGFloat backHH = 150;
    CGFloat backW = kWidth - startXY * 2;
    UIView *back = [[UIView alloc] initWithFrame:Rect(startXY, inforY, backW, backHH)];
    [self.view addSubview:back];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 3.0;
    
    NSArray *titles = @[@"公司地址｜",@"联系人｜ ",@"手机号｜"];
    NSArray *dates = @[@"南京新街口",@"马德盛",@"18787876765"];
    CGFloat space = 5;
    CGFloat up = 0;
    CGFloat eTextH = ((backHH -up)/ 3);
    CGFloat eTextW = 90;
    for (int i = 0; i < 3; i++) {
        
        UILabel *leftLb = [[UILabel alloc] initWithFrame:Rect(space, up + (eTextH + 1)*i, eTextW, eTextH)];
        [back addSubview:leftLb];
        leftLb.text = titles[i];
        leftLb.backgroundColor = [UIColor clearColor];
        
        CGFloat textX = CGRectGetMaxX(leftLb.frame) - 0;
        UILabel *rightLb = [[UILabel alloc] initWithFrame:Rect(textX, up + (eTextH + 1)*i, backW - textX, eTextH)];
        [back addSubview:rightLb];
        rightLb.backgroundColor = [UIColor clearColor];
        rightLb.text = dates[i];
        
        UIView *line = [[UIView alloc] init];
        [back addSubview:line];
        CGFloat lineY = (eTextH + 1) * (i + 1);
        if (i != 2) {
            line.frame = Rect(0, lineY, backW, 0.5);
            line.backgroundColor = HexRGB(KCellLineColor);
        }
    }
}
@end

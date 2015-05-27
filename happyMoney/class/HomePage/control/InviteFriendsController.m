//
//  InviteFriendsController.m
//  happyMoney
//  邀请好友
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "InviteFriendsController.h"
#import "NewBroadCastController.h"
#import "InviteFrdTwo.h"

@interface InviteFriendsController ()

@end

@implementation InviteFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"邀请好友";
    
//    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBtn setTitle:@"邀请" forState:UIControlStateNormal];
//    rightBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
//    [rightBtn addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
//    rightBtn.frame = Rect(0, 0, 60, 30);
//    
//    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:Rect(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:icon];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.image = LOADPNGIMAGE(@"邀请好友1");
    
    CGFloat yy = 0;
    if (_iPhone4) {
        yy = 120;
    }else if (_iPhone5)
    {
        yy = 160;
    }else
    {
        yy = 190;
    }
    CGFloat redbagX = kWidth/2 - 100;
    CGFloat redbagY = KAppNoTabHeight - yy;
    CGFloat redbagW = 200;
    
    UILabel *redBag = [[UILabel alloc] initWithFrame:Rect(redbagX, redbagY, redbagW, 30)];
    [self.view addSubview:redBag];
    redBag.textColor = [UIColor whiteColor];
    redBag.text = @"红包领取码：562314";
    redBag.textAlignment = NSTextAlignmentCenter;
    redBag.font = [UIFont systemFontOfSize:PxFont(Font28)];
    redBag.backgroundColor = [UIColor clearColor];
    
    UILabel *money = [[UILabel alloc] initWithFrame:Rect(redbagX + 60, CGRectGetMaxY(redBag.frame), redbagW, 30)];
    [self.view addSubview:money];
    money.textColor = [UIColor whiteColor];
    money.text = @"¥ 6.00";
    money.textAlignment = NSTextAlignmentLeft;
    money.font = [UIFont systemFontOfSize:PxFont(Font36)];
    money.backgroundColor = [UIColor clearColor];
}

-(void)invite
{
    InviteFrdTwo *ctl = [[InviteFrdTwo alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void)broadcastClicked
{
    NewBroadCastController *ctl = [[NewBroadCastController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}
@end

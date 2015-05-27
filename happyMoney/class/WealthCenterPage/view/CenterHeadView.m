//
//  CenterHeadView.m
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CenterHeadView.h"
#import "UIImageView+WebCache.h"
#import "UserItem.h"
#import "SystemConfig.h"

@interface CenterHeadView()
{
    UIImageView *_head;
    UILabel *_nickName;
    UILabel *_bones;
    UIButton *_login;
    CGRect headOldFrame;
}

@end
@implementation CenterHeadView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *back = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:back];
        back.userInteractionEnabled = YES;
        back.image = LOADPNGIMAGE(@"CenterBack");
        
        //1 head icon
        CGFloat imgW = 100;
        CGFloat imgH = 100;
//        CGFloat headX = (kWidth - imgW)/2;
        CGFloat headY = 20;
        
        CGFloat headCenterX = kWidth/2;
        CGFloat headCenterY = headY + imgH/2 + 20;
        UIImageView *head = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgW, imgH)];
        CGPoint headCenter = CGPointMake(headCenterX, headCenterY);
        head.center = headCenter;
        [back addSubview:head];
        [head setImage:LOADPNGIMAGE(@"default")];
        head.layer.masksToBounds = YES;
        head.layer.cornerRadius = imgW/2;
        head.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _head = head;
        headOldFrame = head.frame;
        
        //2 nick name
        UILabel *nickName = [[UILabel alloc] initWithFrame:CGRectZero];
        [back addSubview:nickName];
        //        [nickName setText:@"红色石头"];
        nickName.font = [UIFont systemFontOfSize:PxFont(Font20)];
        CGFloat nickW = 150;
        //        CGFloat nickX = headX + imgW/2;
        //        CGFloat nickY = CGRectGetMaxY(head.frame) + 10;
        CGFloat nickH = 30;
        nickName.frame = Rect(0, 0, nickW, nickH);
        headCenter.y += imgH/2 + 15;
        nickName.center = headCenter;
        nickName.textColor = HexRGB(0xffffff);
        nickName.backgroundColor = [UIColor clearColor];
        _nickName = nickName;
        nickName.textAlignment = NSTextAlignmentCenter;
        nickName.hidden = YES;
        //3 红包
        UILabel *bones = [[UILabel alloc] initWithFrame:CGRectZero];
        [back addSubview:bones];
        bones.textAlignment = NSTextAlignmentCenter;
        //        bones.backgroundColor = [UIColor redColor];
        //        [bones setText:@"红包领取码：562425"];
        bones.font = [UIFont systemFontOfSize:11.0];
        CGFloat boneY = CGRectGetMaxY(nickName.frame);
        CGFloat boneH = 25;
        CGFloat boneW = 200;
        CGFloat boneX = (kWidth - boneW)/2;
        bones.frame = Rect(boneX, boneY, boneW, boneH);
        bones.font = [UIFont systemFontOfSize:PxFont(Font20)];
        bones.textColor = HexRGB(0xffffff);
        bones.backgroundColor = [UIColor clearColor];
        bones.hidden = NO;
        _bones = bones;
        
        CGFloat btnH = 35;
        //4 申请button
        UIButton *applyBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [back addSubview:applyBt];
        CGFloat applyBtnY = CGRectGetMaxY(bones.frame) + 5;
        applyBt.frame = Rect((kWidth - 150)/2, applyBtnY, 150, btnH);
        [applyBt setBackgroundColor:[UIColor clearColor]];
        [applyBt setTitle:@"申请成为代理商" forState:UIControlStateNormal];
        [applyBt addTarget:self action:@selector(aply) forControlEvents:UIControlEventTouchUpInside];
        applyBt.layer.masksToBounds = YES;
        applyBt.layer.cornerRadius = 8.0;
        applyBt.layer.borderWidth = 1.5;
        applyBt.layer.borderColor = HexRGB(0xfff45c).CGColor;
        applyBt.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font22)];
        applyBt.titleLabel.textColor = HexRGB(0xffffff);
        _apply = applyBt;
        applyBt.hidden = YES;
        //        CGFloat h = CGRectGetMaxY(applyBt.frame) + 20;
    
        UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
        [back addSubview:login];
        CGFloat loginBtnY = self.frame.size.height - btnH - 25;
        login.frame = Rect((kWidth - 150)/2, loginBtnY, 150, btnH);
//        [login setBackgroundColor:ButtonColor];
        [login setTitle:@"登录/注册" forState:UIControlStateNormal];
        [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        login.layer.masksToBounds = YES;
        login.layer.cornerRadius = 8.0;
        login.layer.borderWidth = 1.0;
        login.layer.borderColor = HexRGB(0xfff45c).CGColor;
        login.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font22)];
        login.titleLabel.textColor = HexRGB(0xffffff);
        _login = login;
        
    }
    return self;
}

-(void)login
{
    if ([self.delegate respondsToSelector:@selector(readToLogin)]) {
        [self.delegate readToLogin];
    }
}

-(void)reloadData
{
    if ([SystemConfig sharedInstance].isUserLogin) {
        _login.hidden = YES;
        
        if ([[SystemConfig sharedInstance].user.type isEqualToString:@"1"]) {
            _apply.hidden = YES;
        }else
        {
            _apply.hidden = NO;
        }
//        NSString *avata = [SystemConfig sharedInstance].user.avatar == [NSNull class] ? @"default": [SystemConfig sharedInstance].user.avatar;
        NSString *avata = [SystemConfig sharedInstance].user.avatar;
        if ([avata isKindOfClass:[NSNull class]]) {
            avata = @"default";
        }
        _head.frame = headOldFrame;
        [_head setImageWithURL:[NSURL URLWithString:avata] placeholderImage:placeHoderImage];
        _nickName.hidden = NO;
        _nickName.text = [SystemConfig sharedInstance].user.userName;
        [_bones setText:@"红包领取码：562425"];
    }else
    {
        CGRect iconRect = headOldFrame;
        iconRect.origin.y += 20;
        _head.frame = iconRect;
        
        _login.hidden = NO;
    }
}

-(void)aply
{
    
}

-(void)setItem:(UserItem *)item
{
    _item = item;
    
}
@end

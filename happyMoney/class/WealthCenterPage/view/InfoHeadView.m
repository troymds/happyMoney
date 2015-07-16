//
//  InfoHeadView.m
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "InfoHeadView.h"
#import "UIImageView+WebCache.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface InfoHeadView()
{
    UIImageView *_head;
    UILabel *_nickName;
    UILabel *_code;
}

@end

@implementation InfoHeadView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // back view
        self.backgroundColor = [UIColor whiteColor];
        UIView *backView = [[UIView alloc] initWithFrame:Rect(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backView];
        backView.layer.masksToBounds =  YES;
        backView.layer.borderWidth = 1.0;
        backView.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        backView.layer.cornerRadius = 5.0;
        
        //2 head icon
        CGFloat startX = 10;
        CGFloat icomWH = frame.size.height - startX * 2;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:Rect(startX, startX, icomWH, icomWH)];
        [self addSubview:icon];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = icomWH / 2;
        icon.backgroundColor = [UIColor clearColor];
        _head = icon;
        [_head setImage:LOADPNGIMAGE(@"default")];
        //3 name
        CGFloat nameX = CGRectGetMaxX(icon.frame) + 20;
        CGFloat nameSpace = icomWH/5;
        CGFloat nameY = startX + nameSpace;
        CGFloat spceBetweenTitle = 10;
        CGFloat titleH = (icomWH - nameSpace * 2 - spceBetweenTitle)/2;
        UILabel *name = [[UILabel alloc] initWithFrame:Rect(nameX, nameY, 200, titleH)];
        [self addSubview:name];
        name.text = @"欧巴";
        name.font = [UIFont systemFontOfSize:20.0];
        name.backgroundColor = [UIColor clearColor];
        _nickName = name;
        
        //4 advice code
        CGFloat codeY = CGRectGetMaxY(name.frame) + spceBetweenTitle;
        UILabel *code = [[UILabel alloc] initWithFrame:Rect(nameX, codeY, frame.size.width - nameX, titleH)];
        [self addSubview:code];
        code.text = @"邀请码：5656565";
        code.font = [UIFont systemFontOfSize:16.0];
        code.backgroundColor  = [UIColor clearColor];
        _code = code;
        
        if ([SystemConfig sharedInstance].isUserLogin) {
            NSString *avata = [SystemConfig sharedInstance].user.avatar;
            if ([avata isKindOfClass:[NSNull class]]) {
                avata = @"default";
            }
            [_code setText:[NSString stringWithFormat:@"邀请码：%@",[SystemConfig sharedInstance].user.invite_code]];
            [_head setImageWithURL:[NSURL URLWithString:avata] placeholderImage:placeHoderImage];
            _nickName.text = [SystemConfig sharedInstance].user.userName;
        }else
        {
            
        }
    }
    return self;
}

-(void) reloadData
{
    if ([SystemConfig sharedInstance].isUserLogin) {
        NSString *avata = [SystemConfig sharedInstance].user.avatar;
        if ([avata isKindOfClass:[NSNull class]]) {
            avata = @"default";
        }
        [_code setText:[NSString stringWithFormat:@"邀请码：%@",[SystemConfig sharedInstance].user.invite_code]];
        [_head setImageWithURL:[NSURL URLWithString:avata] placeholderImage:placeHoderImage];
        _nickName.text = [SystemConfig sharedInstance].user.userName;
    }else
    {
        
    }
}

@end

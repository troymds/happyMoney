//
//  InfoModefyHeadView.m
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "InfoModefyHeadView.h"
#import "UIImageView+WebCache.h"
#import "SystemConfig.h"
#import "UserItem.h"

@implementation InfoModefyHeadView
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
        
        CGFloat startX = 10;
        //1 name
        CGFloat nameH = 25;
        UILabel *name = [[UILabel alloc] initWithFrame:Rect(startX + 20, 0, 130, nameH)];
        name.center = CGPointMake(80 ,frame.size.height/2);
        [backView addSubview:name];
        if ([[SystemConfig sharedInstance].user.type intValue] != 0) {
            name.text = @"企业形象 ｜";
        }else
        {
            name.text = @"用户形象 ｜";
        }
        name.font = [UIFont systemFontOfSize:PxFont(Font24)];
        
        //2 head icon
        CGFloat icomWH = frame.size.height - startX * 2;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:Rect(0, 0, icomWH, icomWH)];
        [backView addSubview:icon];
        icon.center = CGPointMake(frame.size.width - 50 - icomWH/2,frame.size.height/2);
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = icomWH / 2;
        icon.backgroundColor = [UIColor clearColor];
        icon.userInteractionEnabled = YES;
        _icon = icon;
        
        //3 right arrow
        UIButton *arrow = [[UIButton alloc] initWithFrame:Rect(0, 0, 25, 25)];
        arrow.center = CGPointMake(frame.size.width - 25 ,frame.size.height/2);
        [arrow setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        [arrow setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateHighlighted];
        [self addSubview:arrow];
        _arrowBtn = arrow;
        
        if ([SystemConfig sharedInstance].isUserLogin) {
            NSString *avata = [SystemConfig sharedInstance].user.avatar;
            if ([avata isKindOfClass:[NSNull class]]) {
                avata = @"default";
            }
            
            [icon setImageWithURL:[NSURL URLWithString:avata] placeholderImage:placeHoderImage];
            //            _nickName.text = [SystemConfig sharedInstance].user.userName;
        }
        
    }
    return self;
}
@end

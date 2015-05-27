//
//  PersonApplyView.h
//  happyMoney
//
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterDelegate.h"

@class MDSTextField;

@protocol PersonApplyViewDelegate <NSObject>
-(void) PersonApplyViewYZMWith:(NSString *)phoneNum;
-(void) personRegist;
-(void) uploadPic;
@end

@interface PersonApplyView : UIView
{
    int second;
    UIButton *_yzmBtn;
    UILabel *secondLabel;
}
@property (nonatomic, strong) MDSTextField *contact; //联系人
@property (nonatomic, strong) MDSTextField *phoneNum;//手机号
@property (nonatomic, strong) MDSTextField *veryfyNum;//验证码
@property (nonatomic, strong) MDSTextField *password;//密码
@property (nonatomic, strong) MDSTextField *unickNum;//身份证
@property (nonatomic, assign) CGFloat contentHeight;//动态高度
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, assign) id<PersonApplyViewDelegate> delegate;

-(void)updateAUI;
-(void) freshUI;
@end

//
//  BusinessApplyView.h
//  happyMoney
//
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterDelegate.h"

@class MDSTextField;

@protocol BusinessApplyViewDelegate <NSObject>
-(void) BusinessYZMWith:(NSString *)phoneNum;
-(void) BusinessApplyapplyRegist;
@end

@interface BusinessApplyView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) MDSTextField *contact; //联系人
@property (nonatomic, strong) MDSTextField *phoneNum;//手机号
@property (nonatomic, strong) MDSTextField *veryfyNum;//验证码
@property (nonatomic, strong) MDSTextField *password;//密码
@property (nonatomic, strong) MDSTextField *businessName;//店铺名
@property (nonatomic, strong) MDSTextField *businessAddress;//店铺地址
@property (nonatomic, strong) MDSTextField *license;//营业执照编号;
@property (nonatomic, assign) CGFloat contentHeight;//动态高度
@property (nonatomic, assign) id<BusinessApplyViewDelegate> delegate;
-(void)updateBUI;
@end

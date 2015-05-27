//
//  LoginController.m
//  happyMoney
//  登录页面
//  Created by promo on 15-3-30.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "LoginController.h"
#import "MDSTextField.h"
#import "RegistControllerView.h"
#import "FindPasswordController.h"
#import "ImageTextView.h"
#import "UserItem.h"
#import "SystemConfig.h"

#define KSpace 18
#define KSpace2 10
#define KBUttonW 100
#define KTextFieldH 55

@interface LoginController ()<UITextFieldDelegate>
{
    MDSTextField *_phone;
    MDSTextField *_password;
}
@end

@implementation LoginController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.title = @"登录";
    self.view.backgroundColor = HexRGB(0xeeeeee);
    
    //返回按钮
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return") forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return") forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 22, 44);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.leftBarButtonItem = rehtnItem;
    
    CGFloat startX = 10;
    CGFloat startY = 10;
    CGFloat width = kWidth - startX * 2;
    CGFloat height = 55;
    CGFloat btnH = 40;
    
    MDSTextField *phone  = [[MDSTextField alloc] initWithFrame:CGRectMake(startX, startY, width, height) placeHold:@"请输入注册手机号码" leftImg:@"login_06" index:1];
    phone.imgField.textField.delegate = self;
    phone.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phone];
    _phone = phone;
    
    CGFloat codeY = CGRectGetMaxY(phone.frame);
    MDSTextField *code = [[MDSTextField alloc] initWithFrame:CGRectMake(startX, codeY, width, height) placeHold:@"请输入密码" leftImg:@"login_08" index:1];
    code.imgField.textField.delegate = self;
    code.imgField.textField.secureTextEntry = YES;
    [self.view addSubview:code];
    _password = code;
    
     //登入眼睛按钮
    CGFloat eyeWH = 25;
    CGFloat yzmX = width - 10 - eyeWH;
    CGFloat space = (KMDSTextH - eyeWH) / 2;
    CGFloat yzmY =  KMDSTextFieldY + space;
    UIButton *eye = [UIButton buttonWithType:UIButtonTypeCustom];
    eye.frame = Rect(yzmX, yzmY, eyeWH, eyeWH);
    [eye setBackgroundImage:[UIImage imageNamed:@"login_10"] forState:UIControlStateNormal];
    [eye setBackgroundImage:[UIImage imageNamed:@"login_14"] forState:UIControlStateSelected];
    [code addSubview:eye];
    [eye addTarget:self action:@selector(eyeClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *regist = [UIButton buttonWithType:UIButtonTypeCustom];
    regist.frame = CGRectMake(startX, CGRectGetMaxY(code.frame) + KSpace, KBUttonW, btnH);
    [self.view addSubview:regist];
    [regist setTitleColor:ButtonColor forState:UIControlStateNormal];
    [regist setTitle:@"立即注册" forState:UIControlStateNormal] ;
    regist.backgroundColor = [UIColor clearColor];
    [regist addTarget:self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
    [regist setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    regist.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    
    UIButton *forgetPas = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPas.frame = CGRectMake(kWidth - startX - KBUttonW, CGRectGetMaxY(code.frame) + KSpace, KBUttonW, btnH);
    [self.view addSubview:forgetPas];
    [forgetPas setTitleColor:ButtonColor forState:UIControlStateNormal];
    [forgetPas setTitle:@"忘记密码" forState:UIControlStateNormal] ;
    forgetPas.backgroundColor = [UIColor clearColor];
    [forgetPas setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -25)];
    [forgetPas addTarget:self action:@selector(forgetPasNow) forControlEvents:UIControlEventTouchUpInside];
    forgetPas.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(startX, CGRectGetMaxY(forgetPas.frame) + 5, width, 40);
    [self.view addSubview:login];
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius = 5.0;
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setTitle:@"立即登录" forState:UIControlStateNormal];
    login.backgroundColor = ButtonColor;
    [login addTarget:self action:@selector(loginNow) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)eyeClicked:(UIButton *)btn
{
    //如果有密码，则显示明文
    btn.selected = !btn.selected;
    if (btn.selected) {
        _password.imgField.textField.secureTextEntry = NO;
    }else
    {
        _password.imgField.textField.secureTextEntry = YES;
    }
}

-(void)back
{
    if ([SystemConfig sharedInstance].isUserLogin) {
        
    }
    else
    {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(loginSucessWithType:)]) {
            [self.delegate loginSucessWithType:0];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 立即登录
-(void) loginNow
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    //    NSLog(@"_phone.imgField%@",_phone.imgField.textField.text);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_phone.imgField.textField.text,@"phone_num",_password.imgField.textField.text,@"password", nil];
    NSLog(@"%@",params);
    [HttpTool postWithPath:@"login" params:params success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //            [RemindView showViewWithTitle:addAddressSuccess location:MIDDLE];
        if (code == 100) {
            //收起键盘
            [self hideKeyBoard];
            
            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            
            //存储用户信息 并归档
            UserItem *item = [[UserItem alloc] initWithDic:data];
            //            item.userType = @"2";
            //            UserDataModelSingleton *dm = [UserDataModelSingleton shareInstance];
            //            dm.userItem = item;
            //            [dm archive];
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:_phone.imgField.textField.text forKey:Account];
            [user setObject:_password.imgField.textField.text forKey:Password];
            [user setObject:@"1" forKey:quitLogin]; //1表示没有已经登录，没有退出
//            [user setObject:@"2" forKey:UserType];
            [user synchronize];
            
            //单例存储用户相关信息
//            [SystemConfig sharedInstance].userType = @"2";
            [SystemConfig sharedInstance].isUserLogin = YES;
            [SystemConfig sharedInstance].uid = item.ID;
            [SystemConfig sharedInstance].user = item;
            if (self.delegate&&[self.delegate respondsToSelector:@selector(loginSucessWithType:)]) {
                [self.delegate loginSucessWithType:_type];
            }else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            [RemindView showViewWithTitle:msg location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)hideKeyBoard
{
    [_phone.imgField.textField resignFirstResponder];
    [_password.imgField.textField resignFirstResponder];
}

#pragma mark 立即登录
-(void) registNow
{
    NSLog(@"立即注册");
    RegistControllerView *regist = [[RegistControllerView alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

#pragma mark 忘记密码
-(void) forgetPasNow
{
    NSLog(@"忘记密码");
    FindPasswordController *regist = [[FindPasswordController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

//收起键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

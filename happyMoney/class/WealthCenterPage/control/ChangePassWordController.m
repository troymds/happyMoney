//
//  ChangePassWordController.m
//  happyMoney
//  修改密码 
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ChangePassWordController.h"
#import "TGCover.h"
#import "LoginController.h"
#import "MainController.h"
#import "UserItem.h"
#import "SystemConfig.h"

@interface ChangePassWordController ()
{
    TGCover *_cover; // 遮盖
    UITextField *Oldfield;
    UITextField *Newfield;
    UITextField *Conformfield;
}
@end

@implementation ChangePassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"修改密码 ";
    
    CGFloat viewH = 0;
    NSArray *titles = @[@"原密码",@"新密码",@"确认新密码"];
    CGFloat startXY = 14;
    CGFloat space = 3;
    CGFloat labelH = 25;
    CGFloat textH = 45;
    CGFloat textW = kWidth - startXY * 2;
    for (int i = 0; i < 3; i++) {
        CGFloat labelY = startXY + (labelH + space + textH + startXY) * i;
        UILabel *text = [[UILabel alloc] initWithFrame:Rect(startXY, labelY, textW, textH)];
        [self.view addSubview:text];
        text.text = titles[i];
        text.font = [UIFont boldSystemFontOfSize:PxFont(Font22)];
        text.textColor = HexRGB(0x3a3a3a);
        text.backgroundColor = [UIColor clearColor];
        
        CGFloat textY = CGRectGetMaxY(text.frame);
        UITextField *field = [[UITextField alloc] initWithFrame:Rect(startXY, textY, textW, textH)];
        [self.view addSubview:field];
        field.delegate = self;
        field.layer.masksToBounds  = YES;
        field.layer.cornerRadius = 5.0;
        field.layer.backgroundColor = HexRGB(0xffffff).CGColor;
        field.secureTextEntry  = YES;
        if (i == 2) {
            Conformfield = field;
            viewH = CGRectGetMaxY(field.frame) + 28;
        }else if (i == 0)
        {
            Oldfield = field;
        }else
        {
            Newfield = field;
        }
    }
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:done];
    done.layer.masksToBounds = YES;
    done.layer.cornerRadius = 5.0;
    CGFloat doneX = startXY + 10;
    done.frame = Rect(doneX, viewH, kWidth - doneX * 2, 40);
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    done.backgroundColor = ButtonColor;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)complete
{
    [self.view endEditing:YES];
    
    if (Oldfield.text.length > 0 && Newfield.text.length > 0 && Conformfield.text.length > 0) {
        
        if ([Newfield.text isEqualToString:Conformfield.text] && ![Oldfield.text isEqualToString:Newfield.text] && ![Oldfield.text isEqualToString:Conformfield.text]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = NO;
            
            NSDictionary *parms  = [NSDictionary dictionaryWithObjectsAndKeys:Oldfield.text,@"old_password",Newfield.text,@"new_password", nil];
            
            [HttpTool postWithPath:@"changePassword" params:parms success:^(id JSON, int code) {
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
//                NSString *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
                [RemindView showViewWithTitle:@"修改密码成功" location:MIDDLE];
                if (code == 100) {
                    [self modefySuccess];
                }
                
            } failure:^(NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [RemindView showViewWithTitle:offline location:MIDDLE];
            }];
            
        }else
        {
            [RemindView showViewWithTitle:@"确认密码和新密码不符，请重新填写" location:MIDDLE];
        }
    }else
    {
        [RemindView showViewWithTitle:@"请填写完整密码 " location:MIDDLE];
    }
}

#pragma mark 修改成功
-(void) modefySuccess
{
    //添加遮罩view
    if (_cover == nil) {
        _cover = [TGCover cover];
    }
    _cover.frame = self.view.bounds;
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        [_cover reset];
    }completion:^(BOOL finished) {
        [self ShowSuccessView];
        
        [UIView animateWithDuration:2.0 animations:^{
            _cover.alpha = 0.0;
        }completion:^(BOOL finished) {
            [_cover removeFromSuperview];
        }];
    }];
    //修改新密码
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:Newfield.text forKey:Password];
    [user synchronize];
    
    //重新登录
    [self autoLogin];
}

#pragma mark 自动登录
-(void)autoLogin
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *account = [user objectForKey:Account];
    NSString *password = [user objectForKey:Password];
    NSString *type = [user objectForKey:UserType];
    NSInteger isQuit = [[user objectForKey:quitLogin] integerValue];
    if (account && password && isQuit == 1) {
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:account,@"phone_num",password,@"password",type,@"type", nil];
        [HttpTool postWithPath:@"login" params:param success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSDictionary *response = [JSON objectForKey:@"response"];
            if (code == 100) {
                UserItem *item = [[UserItem alloc] initWithDic:[response objectForKey:@"data"]];
                //单例存储用户相关信息
                [SystemConfig sharedInstance].userType = [type intValue];
                [SystemConfig sharedInstance].isUserLogin = YES;
                [SystemConfig sharedInstance].user = item;
                [self goHome];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }
}

#pragma mark 返回首页
-(void)goHome
{
    //重新登录
    MainController *rc= [[MainController alloc] init];
    self.view.window.rootViewController = rc;
    
    //    [self loginNow];
}

-(void) ShowSuccessView
{
    CGFloat showW = kWidth - 40 * 2;
    UIView *showView = [[UIView alloc] initWithFrame:Rect(0, 0, showW, 45)];
    showView.center = CGPointMake(kWidth/2, self.view.bounds.size.height/2 - 45);
    showView.backgroundColor = [UIColor whiteColor];
    showView.layer.masksToBounds = YES;
    showView.layer.cornerRadius = 5.0;
    
    CGFloat lbW = 190;
    UILabel *lb = [[UILabel alloc] initWithFrame:Rect((showW - lbW)/2, 10, lbW, 25)];
    lb.text = @"恭喜，修改密码成功!";
    lb.textColor = HexRGB(0x3a3a3a);
    lb.font = [UIFont boldSystemFontOfSize:18.0];
    [showView addSubview:lb];
    
    [_cover addSubview:showView];
}
-(void)hide
{
    // 1.移除遮盖
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
}

#pragma mark 监听点击遮盖
- (void)coverClicked
{
    // 1.移除遮盖
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

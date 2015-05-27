//
//  FindPasswordController.m
//  happyMoney
//
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "FindPasswordController.h"
#import "MDSTextField.h"
#import "ImageTextView.h"
#import "Tool.h"

@interface FindPasswordController ()
{
    MDSTextField *_password;
    MDSTextField *_phone;
    MDSTextField *_yzm;
    UIButton *_yzmBtn;
    UILabel *secondLabel;
    int second;
}
@end

@implementation FindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"重置密码";
    
    //返回按钮
    UIButton *leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return") forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return_pre") forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = Rect(0, 0, 30, 30);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    CGFloat startX = 10;
    CGFloat startY = 10;
    CGFloat width = kWidth - startX * 2;
    CGFloat height = 45;
    CGFloat space = 10;
    CGFloat viewH = 0;
    
    NSArray *array = @[@"请输入注册时的手机号",@"请输入新密码",@"请输入验证码"];
    NSArray *imgs = @[@"login_06",@"login_08",@"login_04"];
    for (int i = 0; i < array.count; i++) {
        CGRect rect = CGRectMake(startX, startY + (height + space) * i, width, height);
        MDSTextField *field = [[MDSTextField alloc] initWithFrame:rect placeHold:array[i] leftImg:imgs[i] index:i hasLeftImg:YES];
        [self.view addSubview:field];
        switch (i) {
            case 0:
            {
                _phone = field;
                field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            case 2:
            {
                _yzm = field;
                field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
                CGFloat yzmX = width - 10 - 100;
                CGFloat yzmY = KMDSTextFieldY + 5;
                CGFloat yzmH = (height + KMDSTextFieldY)- yzmY * 2;
                UIButton *receiveYZM = [UIButton buttonWithType:UIButtonTypeCustom];
                receiveYZM.layer.masksToBounds = YES;
                receiveYZM.layer.cornerRadius = 5.0f;
                receiveYZM.layer.borderWidth = 1.0;
                receiveYZM.layer.borderColor = ButtonColor.CGColor;
                receiveYZM.frame = Rect(yzmX, yzmY, 100, yzmH);
                [receiveYZM setTitle:@"获取验证码" forState:UIControlStateNormal];
                [receiveYZM setTitle:@"获取验证码" forState:UIControlStateHighlighted];
                [receiveYZM setTitleColor:ButtonColor forState:UIControlStateNormal];
                receiveYZM.backgroundColor = [UIColor whiteColor];
                [_yzm addSubview:receiveYZM];
                _yzmBtn = receiveYZM;
                [receiveYZM addTarget:self action:@selector(receiveyzm) forControlEvents:UIControlEventTouchUpInside];
                
                //点击验证码按钮后显示剩余时间文字的label
                secondLabel = [[UILabel alloc] initWithFrame:_yzmBtn.frame];
                secondLabel.textColor = HexRGB(0xffffff);
                secondLabel.font = [UIFont systemFontOfSize:13];
                secondLabel.textAlignment = NSTextAlignmentCenter;
                secondLabel.layer.cornerRadius = 3.0f;
                secondLabel.layer.masksToBounds = YES;
                secondLabel.backgroundColor = [UIColor grayColor];
                [_yzm addSubview:secondLabel];
                secondLabel.hidden = YES;
            }
                break;
            case 1:
            {
                _password = field;
                field.imgField.textField.secureTextEntry = YES;
                
                //登入眼睛按钮
                CGFloat eyeWH = 25;
                CGFloat yzmX = width - 10 - eyeWH;
                CGFloat space = (KMDSTextH - eyeWH) / 2;
                CGFloat yzmY =  KMDSTextFieldY + space;
                UIButton *eye = [UIButton buttonWithType:UIButtonTypeCustom];
                eye.frame = Rect(yzmX, yzmY, eyeWH, eyeWH);
                [eye setBackgroundImage:[UIImage imageNamed:@"login_10"] forState:UIControlStateNormal];
                [eye setBackgroundImage:[UIImage imageNamed:@"login_14"] forState:UIControlStateSelected];
                [field addSubview:eye];
                [eye addTarget:self action:@selector(eyeClicked:) forControlEvents:UIControlEventTouchUpInside];
                
            }
                break;
            default:
                break;
        }
        if (i == array.count - 1) {
            viewH = CGRectGetMaxY(field.frame) + height;
        }
    }
    
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame = CGRectMake(startX, viewH - 10, width, 40);
    [self.view addSubview:submit];
    submit.layer.masksToBounds = YES;
    submit.layer.cornerRadius = 5.0f;
    submit.backgroundColor = ButtonColor;
    [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [submit setTitle:@"提交" forState:UIControlStateNormal];
    
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

-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 检查电话号码
- (BOOL)checkPhoneNum
{
    if (_phone.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入手机号码" location:MIDDLE];
        return NO;
    }
    if (![Tool isValidPhoneNum:_phone.imgField.textField.text]) {
        [RemindView showViewWithTitle:@"手机号码格式不正确" location:MIDDLE];
        return NO;
    }
    return YES;
}

-(void)receiveyzm
{
        if ([self checkPhoneNum]) {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:_phone.imgField.textField.text,@"phone_num", nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    [HttpTool postWithPath:@"getRegisterCode" params:param success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"data"];
        
        if (code == 100) {
            [RemindView showViewWithTitle:msg location:MIDDLE];
            second = 60;
            _yzmBtn.hidden = YES;
            secondLabel.hidden = NO;
            secondLabel.text = [NSString stringWithFormat:@"%d秒后重新获取",second];
            [self performSelector:@selector(changeUI) withObject:nil afterDelay:1];
        }else{
            [RemindView showViewWithTitle:msg location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:@"获取验证码失败" location:MIDDLE];
    }];
}
}

#pragma mark 更改获取验证码UI
- (void)changeUI
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeUI) object:nil];
    second--;
    secondLabel.text = [NSString stringWithFormat:@"%d秒后重新获取",second ];
    if (second == 0) {
        secondLabel.hidden = YES;
        _yzmBtn.hidden = NO;
    }else{
        [self performSelector:_cmd withObject:nil afterDelay:1];
    }
}

//收起键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void) submit
{
    if (_phone.imgField.textField.text.length > 0 && _password.imgField.textField.text.length > 0 && _yzm.imgField.textField.text.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;
        
        //    NSLog(@"_phone.imgField%@",_phone.imgField.textField.text);
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_phone.imgField.textField.text,@"phone_num",_password.imgField.textField.text,@"password", _yzm.imgField.textField.text,@"code",nil];
        NSLog(@"%@",params);
        [HttpTool postWithPath:@"findPassword" params:params success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (code == 100) {
                NSString *data = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
                [RemindView showViewWithTitle:data location:MIDDLE];
                [self.navigationController popViewControllerAnimated:YES];
            }else
            {
                NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
                [RemindView showViewWithTitle:msg location:MIDDLE];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }else
    {
        [RemindView showViewWithTitle:@"请填写完整信息" location:MIDDLE];
    }
}
@end

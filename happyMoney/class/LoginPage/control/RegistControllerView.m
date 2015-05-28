//
//  RegistControllerView.m
//  happyMoney
//  注册页面
//  Created by promo on 15-3-30.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "RegistControllerView.h"
#import "MDSTextField.h"
#import "BusinessRegistController.h"
#import "LoginController.h"
#import "ImageTextView.h"
#import "Tool.h"

#define KStartY   20 //起始Y坐标（状态栏高度）
#define KStartX   10
#define KTextFieldH 45
#define KSpaceBetweenTextField 5
#define KTextFieldW kWidth - (KStartX * 2)
#define KStartTag 100
#define KRegidtBtnH 50

@interface RegistControllerView ()
{
    UIScrollView *_backScroll;
    CGFloat _viewH;//当前的view的Y值
    UIButton *_bussinessBtn;
    MDSTextField *_useName;
    MDSTextField *_phone;
    MDSTextField *_yzm;
    MDSTextField *_passWord;
    MDSTextField *_redPag;
    int second;
    UIButton *_yzmBtn;
    UILabel *secondLabel;
}
@end

@implementation RegistControllerView

- (void)viewWillAppear:(BOOL)animated
{
//    if (_bussinessBtn) {
//        [_bussinessBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"普通用户注册";
    self.view.backgroundColor = HexRGB(0xeeeeee);
    
    //返回按钮
    UIButton *leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return") forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return_pre") forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = Rect(0, 0, 30, 30);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //登录
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    rightBtn.frame = Rect(0, 0, 60, 30);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    // 1 添加scroll
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
    
    // 2 注册编辑框
    NSArray *placeHolds =@[@"请输入您的用户名",@"请输入11位数手机号",@"请输入6-16位账号密码",@"请输入验证码",@"请输入6位数红包领取码"];
    NSArray *imgs = @[@"login_03",@"login_06",@"login_08",@"login_04",@"login_04"];
    NSUInteger count = placeHolds.count;
    for (int i = 0; i < count; i++) {
        CGFloat y = (KTextFieldH + KSpaceBetweenTextField) * i + KStartX;
        CGRect rect = CGRectMake(KStartX, y, KTextFieldW, KTextFieldH);
       
        BOOL hasLeftImg = YES;
        if (i == count - 1) {
            hasLeftImg = NO;
        }
         MDSTextField *field = [[MDSTextField alloc] initWithFrame:rect placeHold:placeHolds[i] leftImg:imgs[i] index:KStartTag + i hasLeftImg:hasLeftImg];
        field.backgroundColor = [UIColor clearColor];
        [scroll addSubview:field];
        switch (i) {
            case 0:
            {
                _useName = field;
            }
                break;
            case 1:
            {
                _phone = field;
                _phone.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            case 3:
            {
                _yzm = field;
                field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
                CGFloat yzmX = KTextFieldW - 10 - 100;
                CGFloat yzmY = KMDSTextFieldY + 5;
                CGFloat yzmH = (KTextFieldH + KMDSTextFieldY)- yzmY * 2;
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
            case 2:
            {
                _passWord = field;
                field.imgField.textField.secureTextEntry = YES;
                
                //登入眼睛按钮
                CGFloat eyeWH = 25;
                CGFloat yzmX = KTextFieldW - 10 - eyeWH;
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
            case 4:
            {
                _redPag = field;
                field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            default:
                break;
        }
        if (i == count - 1) {
            _viewH = y + KTextFieldH + KSpaceBetweenTextField;
        }
    }
    
   //3 立即注册
    UIButton *regisetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    regisetBtn.layer.masksToBounds = YES;
    regisetBtn.layer.cornerRadius = 5.0f;
    regisetBtn.backgroundColor = ButtonColor;
    [regisetBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [regisetBtn setTitle:@"立即注册" forState:UIControlStateHighlighted];
    [regisetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    regisetBtn.frame = CGRectMake(KStartX, _viewH + 20, KTextFieldW, KRegidtBtnH);
    [regisetBtn addTarget:self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:regisetBtn];
    
    _viewH = CGRectGetMaxY(regisetBtn.frame) + KRegidtBtnH;
    
    //4 注册成为商户
    UIButton *bussinessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bussinessBtn.backgroundColor = [UIColor clearColor];
    [bussinessBtn setTitle:@"想成为商户，点击这里" forState:UIControlStateNormal];
    [bussinessBtn setTitle:@"想成为商户，点击这里" forState:UIControlStateHighlighted];
    [bussinessBtn setTitleColor:HexRGB(0x808080) forState:UIControlStateNormal];
    bussinessBtn.frame = CGRectMake(0, 0, 250, KRegidtBtnH);
    bussinessBtn.center = CGPointMake(kWidth/2, _viewH + KRegidtBtnH/2 - 25);
    [bussinessBtn addTarget:self action:@selector(becomebussiness) forControlEvents:UIControlEventTouchUpInside];
    bussinessBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font24)];
    [scroll addSubview:bussinessBtn];
    _bussinessBtn = bussinessBtn;
    _viewH = CGRectGetMaxY(bussinessBtn.frame) + KRegidtBtnH;
    

    scroll.contentSize = CGSizeMake(kWidth, _viewH);
}

-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)eyeClicked:(UIButton *)btn
{
    //如果有密码，则显示明文
    btn.selected = !btn.selected;
    if (btn.selected) {
        _passWord.imgField.textField.secureTextEntry = NO;
    }else
    {
        _passWord.imgField.textField.secureTextEntry = YES;
    }
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
//}
#pragma mark 登录
- (void)login
{
    LoginController *ctl = [[LoginController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark 开始注册
- (void) registNow
{
    if ([self checkData]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_phone.imgField.textField.text,@"phone_num",_useName.imgField.textField.text,@"username",_passWord.imgField.textField.text,@"password", _yzm.imgField.textField.text,@"register_code",@"123456",@"invite_code",nil];
        NSLog(@"%@",params);
        
        [HttpTool postWithPath:@"register" params:params success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if (code == 100) {
//                NSString *registID = [[JSON objectForKey:@"response"] objectForKey:@"data"];
                [RemindView showViewWithTitle:@"注册成功" location:MIDDLE];
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

#pragma mark 检查账号
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

#pragma mark 检查数据填写是否完整
- (BOOL)checkData
{
    if (_passWord.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入密码" location:MIDDLE];
        return NO;
    }
    if (_useName.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入用户名" location:MIDDLE];
        return NO;
    }
    if (_yzm.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入验证码" location:MIDDLE];
        return NO;
    }
    return YES;
}

//收起键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 成为商户注册
- (void) becomebussiness
{
//    [_bussinessBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal ];
    BusinessRegistController *ctl = [[BusinessRegistController alloc] init];
    ctl.title = @"代理商申请";
    [self.navigationController pushViewController:ctl animated:YES];
}
@end

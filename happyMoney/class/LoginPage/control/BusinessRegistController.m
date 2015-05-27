//
//  BusinessRegistController.m
//  happyMoney
//  代理商申请注册
//  Created by promo on 15-3-30.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "BusinessRegistController.h"
#import "BusinessApplyView.h"
#import "PersonApplyView.h"
#import "LoginController.h"
#import "Tool.h"
#import "GTMBase64.h"
#import "ImageTextView.h"
#import "MDSTextField.h"
#import "ServerHitView.h"
#import "MainController.h"
#import "MDSBtn.h"
#import "SystemConfig.h"
#import "UserItem.h"

//#import "MDSTextField.h"

#define KStartY   20 //起始Y坐标（状态栏高度）
#define KStartX   45
#define KTextFieldH 55
#define KSpaceBetweenTextField 5
#define KTextFieldW kWidth - (KStartX * 2)
#define KStartTag 100
#define KLeftdistance   20
#define KScrolW (kWidth - KStartY * 2)

@interface BusinessRegistController ()<BusinessApplyViewDelegate,PersonApplyViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_backScroll;
    CGFloat _viewH;//当前的view的Y值
    UIButton *_selectedBtn;//被选中的菜单按钮
    BusinessApplyView *_businessView;
    PersonApplyView *_personView;
    UIView *_topView;
    ServerHitView *_hitview;
}
@property (nonatomic,copy) NSString *imgData;
@end

@implementation BusinessRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
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
    [rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(BLogin) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 60, 30);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    CGFloat startXY = KStartY;
    CGFloat btnW = (kWidth - startXY * 2)/2;
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(startXY,startXY,btnW * 2,30)];
    topBgView.backgroundColor = [UIColor whiteColor];
    topBgView.layer.masksToBounds = YES;
    topBgView.layer.cornerRadius = 5.0f;
    topBgView.layer.borderColor = ButtonColor.CGColor;
    topBgView.layer.borderWidth = 1.0;
    _topView = topBgView;
    [self.view addSubview:topBgView];
    
    CGFloat btnY = 20;
    CGFloat btnH = 30;
    NSArray *btnName = @[@"店铺注册",@"个人注册"];
    for (int i = 0; i < 2; i++) {
        CGFloat btnX = i * btnW;
        MDSBtn *btn = [[MDSBtn alloc] initWithFrame:CGRectMake(btnX, 0, btnW, btnH)];
        [topBgView addSubview:btn];
        [btn setTitle:btnName[i] forState:UIControlStateNormal];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn setTitleColor:HexRGB(0xffffff) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        UIImage *nomalImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        UIImage *highImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        UIImage *selectImg = [Tool imageFromColor:ButtonColor size:btn.frame.size];
        [btn setBackgroundImage:nomalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:highImg forState:UIControlStateHighlighted];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        
        if (i == 0) {
            btn.selected = YES;
            _selectedBtn = btn;
        }
    }
    
    CGFloat scrY = CGRectGetMaxY(topBgView.frame) + btnY / 2;
    CGFloat scrolH = KAppNoTabHeight - scrY;
    // 2 添加scroll
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrY, kWidth, scrolH)];
    [self.view addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
    
    _viewH = scrolH;
    
    // 3 添加店铺申请和个人申请 view 默认是店铺申请
    BusinessApplyView * business = [[BusinessApplyView alloc] initWithFrame:CGRectMake(startXY, 0, btnW * 2, scrolH)];
    business.delegate = self;
    _businessView = business;
    business.backgroundColor = [UIColor clearColor];
    [scroll addSubview:business];

}

-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}

//收起键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 登录
- (void)BLogin
{
    LoginController *ctl =  [[LoginController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

#pragma mark 店铺 个人申请 菜单按钮
-(void) btnClicked:(UIButton *)btn
{
    if (_selectedBtn != btn) {
        // 先把旧选中的按钮颜色变灰色，再把新选中的按钮颜色变红色
        _selectedBtn.selected = NO;
        btn.selected = !btn.selected;
        _selectedBtn = btn;
        
        if (_selectedBtn.tag == KPersonal) {
            //个人店铺注册
            [_businessView removeFromSuperview];
            _businessView = nil;
            PersonApplyView * personView = [[PersonApplyView alloc] initWithFrame:CGRectMake(KStartY, 0, KScrolW, _viewH)];
            personView.delegate = self;
            _personView = personView;
            personView.backgroundColor = [UIColor clearColor];
            [_backScroll addSubview:personView];
        }else
        {
            //商铺注册
            [_personView removeFromSuperview];
            _personView = nil;
            BusinessApplyView * business = [[BusinessApplyView alloc] initWithFrame:CGRectMake(KStartY, 0, KScrolW, _viewH)];
            business.delegate = self;
            _businessView = business;
            business.backgroundColor = [UIColor clearColor];
            [_backScroll addSubview:business];
        }
    }
}

-(void)receiveyzm:(NSString *)phone
{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phone_num", nil];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    [HttpTool postWithPath:@"getRegisterCode" params:param success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"data"];
        
        if (code == 100) {
            [RemindView showViewWithTitle:msg location:MIDDLE];
            if (_businessView) {
                //更新ui
                [_businessView updateBUI];
            }else{
                [_personView updateAUI];
            }
        }else{
            [RemindView showViewWithTitle:msg location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:@"获取验证码失败" location:MIDDLE];
    }];
}

-(void) buildHitView
{
    if (!_hitview) {
        _hitview = [[ServerHitView alloc] initWithFrame:Rect(0, 0, kWidth, 300)];
        [_hitview.okBtn  addTarget:self action:@selector(goHome) forControlEvents:UIControlEventTouchUpInside];
    }
    [_hitview show];
}

#pragma mark 店铺申请
- (void)BusinessApplyapplyRegist
{
    NSString *contact = _businessView.contact.imgField.textField.text;
    NSString *phone_num = _businessView.phoneNum.imgField.textField.text;
    NSString *code = _businessView.veryfyNum.imgField.textField.text;
    NSString *password = _businessView.password.imgField.textField.text;
    NSString *shop_name = _businessView.businessName.imgField.textField.text;
    NSString *shop_address = _businessView.businessAddress.imgField.textField.text;
    NSString *shop_code = _businessView.license.imgField.textField.text;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contact,@"contact",phone_num,@"phone_num",code,@"code", password,@"password",shop_name,@"shop_name",shop_address,@"shop_address",shop_code,@"shop_code",@"1",@"type",nil];
    //    NSLog(@"%@",params);
    [HttpTool postWithPath:@"applyAgent" params:params success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            [RemindView showViewWithTitle:@"申请成功" location:MIDDLE];
            [self.navigationController popViewControllerAnimated:YES];
            [self buildHitView];
            
        }else
        {
            [RemindView showViewWithTitle:@"申请失败" location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 店铺验证码
- (void)BusinessYZMWith:(NSString *)phoneNum
{
    NSLog(@"%@",phoneNum);
    [self receiveyzm:phoneNum];
}

#pragma mark 个人申请
- (void)personRegist
{
    if (_imgData) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;
        
        NSString *contact = _personView.contact.imgField.textField.text;
        NSString *phone_num = _personView.phoneNum.imgField.textField.text;
        NSString *code = _personView.veryfyNum.imgField.textField.text;
        NSString *password = _personView.password.imgField.textField.text;
        NSString *id_num = _personView.unickNum.imgField.textField.text;
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contact,@"contact",phone_num,@"phone_num",code,@"code", password,@"password",id_num,@"id_num",_imgData,@"id_image",@"0",@"type",nil];
        NSLog(@"%@",params);
        
        [HttpTool postWithPath:@"applyAgent" params:params success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            
            [RemindView showViewWithTitle:msg location:MIDDLE];
            if (code == 100) {
                //                [RemindView showViewWithTitle:@"申请成功" location:MIDDLE];
                //                [self.navigationController popViewControllerAnimated:YES];
                
                [self buildHitView];
                
            }else
            {
                //NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }else
    {
        [RemindView showViewWithTitle:@"请先上传图片" location:MIDDLE];
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

#pragma mark 立即登录
-(void) loginNow
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    //    NSLog(@"_phone.imgField%@",_phone.imgField.textField.text);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_personView.phoneNum.imgField.textField.text,@"phone_num",_personView.password.imgField.textField.text,@"password", nil];
    NSLog(@"%@",params);
    [HttpTool postWithPath:@"login" params:params success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        //            [RemindView showViewWithTitle:addAddressSuccess location:MIDDLE];
        if (code == 100) {
            
            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            
            //存储用户信息 并归档
            UserItem *item = [[UserItem alloc] initWithDic:data];
            //            item.userType = @"2";
            //            UserDataModelSingleton *dm = [UserDataModelSingleton shareInstance];
            //            dm.userItem = item;
            //            [dm archive];
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:_personView.phoneNum.imgField.textField.text forKey:Account];
            [user setObject:_personView.password.imgField.textField.text forKey:Password];
            //            [user setObject:@"2" forKey:UserType];
            [user synchronize];
            
            //单例存储用户相关信息
            //            [SystemConfig sharedInstance].userType = @"2";
            [SystemConfig sharedInstance].isUserLogin = YES;
            [SystemConfig sharedInstance].uid = item.ID;
            [SystemConfig sharedInstance].user = item;
            
//            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            [RemindView showViewWithTitle:msg location:MIDDLE];
            [_hitview dismiss];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 上传照片
-(void)uploadPic
{
    NSLog(@"上传照片");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选取图片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相机",@"相簿", nil];
    [alertView show];
}

#pragma mark alertView_delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.allowsEditing = YES;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else if(buttonIndex ==2){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self upLoadImg:img];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)upLoadImg:(UIImage *)img
{
    NSData *data;
    NSString *str;
    if (UIImagePNGRepresentation(img)) {
        data = UIImagePNGRepresentation(img);
        str= @"png";
    }else{
        data = UIImageJPEGRepresentation(img, 1.0);
        str = @"jpg";
    }
    NSString *s = [GTMBase64 stringByEncodingData:data];
    NSString *string = [NSString stringWithFormat:@"data:image/%@;base64,%@",str,s];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:string,@"image", nil];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    [HttpTool postWithPath:@"uploadImage" params:param success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (code == 100) {
            _imgData = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            [RemindView showViewWithTitle:@"上传照片成功" location:MIDDLE];
            _personView.icon.image = img;
            //成功上传图片后，显示图片，重新排版
            [_personView freshUI];
        }else
        {
            [RemindView showViewWithTitle:@"发布失败" location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 个人验证码
-(void)PersonApplyViewYZMWith:(NSString *)phoneNum
{
    [self receiveyzm:phoneNum];
    NSLog(@"%@",phoneNum);
}

@end

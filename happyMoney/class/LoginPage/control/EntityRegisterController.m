//
//  EntityRegisterController.m
//  happyMoney
//  实体店铺注册
//  Created by promo on 15-4-21.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "EntityRegisterController.h"
#import "PersonRegister.h"
#import "BusineseRegister.h"
#import "Tool.h"
#import "MDSBtn.h"
#import "GTMBase64.h"
#import "MDSTextField.h"
#import "ImageTextView.h"

#define KStartY   20 //起始Y坐标（状态栏高度）
#define KStartX   45
#define KTextFieldH 55
#define KSpaceBetweenTextField 15
#define KTextFieldW kWidth - (KStartX * 2)
#define KStartTag 100
#define KLeftdistance   20
#define KScrolW (kWidth - KStartY * 2)

@interface EntityRegisterController ()<RegisterDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_backScroll;
    CGFloat _viewH;//当前的view的Y值
    UIButton *_selectedBtn;//被选中的菜单按钮
    BusineseRegister *_businessView;
    PersonRegister *_personView;
    UIView *_topView;
}
@property (nonatomic,copy) NSString *imgData;
@end

@implementation EntityRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"代理商申请";
    
    //返回按钮
    UIButton *leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return") forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:LOADPNGIMAGE(@"nav_return_pre") forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = Rect(0, 0, 60, 30);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    CGFloat startXY = KStartY;
    CGFloat btnW = (kWidth - startXY * 2)/2;
    
    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(startXY,startXY,btnW * 2,40)];
    topBgView.backgroundColor = [UIColor clearColor];
    topBgView.layer.masksToBounds = YES;
    topBgView.layer.cornerRadius = 5.0f;
    topBgView.layer.borderColor = ButtonColor.CGColor;
    topBgView.layer.borderWidth = 1.0;
    _topView = topBgView;
    [self.view addSubview:topBgView];
    
    //1 店铺申请和个人申请按钮
    CGFloat btnY = 20;
    CGFloat btnH = 40;
    NSArray *btnName = @[@"店铺申请",@"个人申请"];
    for (int i = 0; i < 2; i++) {
        MDSBtn *btn = [MDSBtn buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = i * btnW;
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [topBgView addSubview:btn];
        [btn setTitle:btnName[i] forState:UIControlStateNormal];
        [btn setTitleColor:ButtonColor forState:UIControlStateNormal];
        [btn setTitleColor:HexRGB(0xffffff) forState:UIControlStateSelected];
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = 5.0f;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        UIImage *nomalImg = [Tool imageFromColor:HexRGB(0xffffff) size:btn.frame.size];
        UIImage *selectImg = [Tool imageFromColor:ButtonColor size:btn.frame.size];
        
        [btn setBackgroundImage:nomalImg forState:UIControlStateNormal];
        [btn setBackgroundImage:selectImg forState:UIControlStateSelected];
        
        if (i == 0) {
            btn.selected = YES;
            _selectedBtn = btn;
        }
    }
    
    CGFloat scrY = btnY + btnH;
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
    BusineseRegister * business = [[BusineseRegister alloc] initWithFrame:CGRectMake(startXY, 0, btnW * 2, scrolH)];
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
            PersonRegister * personView = [[PersonRegister alloc] initWithFrame:CGRectMake(KStartY, 0, KScrolW, _viewH)];
            personView.delegate = self;
            _personView = personView;
            personView.backgroundColor = [UIColor clearColor];
            [_backScroll addSubview:personView];
        }else
        {
            //商铺注册
            [_personView removeFromSuperview];
            BusineseRegister * business = [[BusineseRegister alloc] initWithFrame:CGRectMake(KStartY, 0, KScrolW, _viewH)];
            business.delegate = self;
            _businessView = business;
            business.backgroundColor = [UIColor clearColor];
            [_backScroll addSubview:business];
        }
    }
}

#pragma mark 店铺申请
- (void)BusinessApply
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    NSString *contact = _businessView.contact.imgField.textField.text;
    NSString *shop_name = _businessView.businessName.imgField.textField.text;
    NSString *shop_address = _businessView.businessAddress.imgField.textField.text;
    NSString *shop_code = _businessView.license.imgField.textField.text;
    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contact,@"contact",phone_num,@"phone_num",code,@"code", password,@"password",shop_name,@"shop_name",shop_address,@"shop_address",shop_code,@"shop_code",@"1",@"type",nil];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contact,@"contact",shop_name,@"shop_name",shop_address,@"shop_address",shop_code,@"shop_code",@"1",@"type",nil];
    
    NSLog(@"%@",params);
    
    [HttpTool postWithPath:@"applyAgent" params:params success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            //            NSString *registID = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            [RemindView showViewWithTitle:@"申请成功" location:MIDDLE];
            [self.navigationController popViewControllerAnimated:YES];
//            [self buildHitView];
            
        }else
        {
            //            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            [RemindView showViewWithTitle:@"申请失败" location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

#pragma mark 个人申请
- (void)personRegist
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    if (_imgData) {
        NSString *contact = _personView.contact.imgField.textField.text;
//        NSString *phone_num = _personView.phoneNum.imgField.textField.text;
//        NSString *code = _personView.veryfyNum.imgField.textField.text;
//        NSString *password = _personView.password.imgField.textField.text;
        NSString *id_num = _personView.unickNum.imgField.textField.text;
        
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contact,@"contact",phone_num,@"phone_num",code,@"code", password,@"password",id_num,@"id_num",_imgData,@"id_image",@"0",@"type",nil];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contact,@"contact",id_num,@"id_num",_imgData,@"id_image",@"0",@"type",nil];
        
        NSLog(@"%@",params);
        
        [HttpTool postWithPath:@"applyAgent" params:params success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            
            [RemindView showViewWithTitle:msg location:MIDDLE];
            if (code == 100) {
                //                [RemindView showViewWithTitle:@"申请成功" location:MIDDLE];
                //                [self.navigationController popViewControllerAnimated:YES];
                
//                [self buildHitView];
                
            }else
            {
                //            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"msg"];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }
}

#pragma mark 上传照片
-(void)personUpLoad
{
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
            //            _personView.icon.image = img;
        }else
        {
            [RemindView showViewWithTitle:@"发布失败" location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

@end

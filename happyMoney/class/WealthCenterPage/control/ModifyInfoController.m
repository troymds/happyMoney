//
//  ModifyInfoController.m
//  happyMoney
//  修改资料
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ModifyInfoController.h"
#import "InfoModefyHeadView.h"
#import "MDSTextField.h"
#import "GTMBase64.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface ModifyInfoController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CGFloat _viewH;
    UITextField *nameText;
    UITextField *phoneText;
    UITextField *alipayText;
    InfoModefyHeadView *_head;
    UIScrollView *_backScroll;
}
@property (nonatomic,copy) NSString *imgData;
@end

@implementation ModifyInfoController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"修改资料";
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
    
    //1 modefy info head
    CGFloat startXY = 10;
    CGFloat backH = 196/2;
    InfoModefyHeadView *head = [[InfoModefyHeadView alloc] initWithFrame:Rect(startXY, startXY, kWidth - startXY * 2, backH)];
    _head = head;
    head.layer.masksToBounds =  YES;
    head.layer.borderWidth = 1.0;
    head.layer.borderColor = HexRGB(KCellLineColor).CGColor;
    head.layer.cornerRadius = 5.0;
    [_backScroll addSubview:head];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadIcon)];
    [head.icon addGestureRecognizer:tap];
    [head.arrowBtn addTarget:self action:@selector(uploadIcon) forControlEvents:UIControlEventTouchUpInside];
    CGFloat inforY = CGRectGetMaxY(head.frame) + startXY;
    
    int isService =  [[SystemConfig sharedInstance].user.type intValue];
    CGFloat spacer = 10;
    
    if (isService != 0) {
        // info
        CGFloat backHH = 150;
        CGFloat backW = kWidth - startXY * 2;
        UIView *back = [[UIView alloc] initWithFrame:Rect(startXY, inforY + startXY, backW, backHH)];
        _viewH = CGRectGetMaxY(back.frame) + 10;
        [_backScroll addSubview:back];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 3.0;
        
        NSString *address = [SystemConfig sharedInstance].user.address;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSString *phone = [user objectForKey:Account];
        NSString *ali = [SystemConfig sharedInstance].user.alipay;
        
        NSArray *titles = @[@"企业地址|",@"手机号|",@"支付宝|"];
        NSArray *dates = @[address,phone,ali];
        CGFloat space = 5;
        CGFloat up = 0;
        CGFloat eTextH = ((backHH -up)/ 3);
        CGFloat eTextW = 80;
        for (int i = 0; i < 3; i++) {
            
            UILabel *leftLb = [[UILabel alloc] initWithFrame:Rect(space - spacer, up + (eTextH + 1)*i, eTextW, eTextH)];
            [back addSubview:leftLb];
            leftLb.text = titles[i];
            leftLb.backgroundColor = [UIColor clearColor];
            leftLb.textAlignment = NSTextAlignmentRight;
            
            CGFloat textX = CGRectGetMaxX(leftLb.frame) + 15;
            UITextField *rightLb = [[UITextField alloc] initWithFrame:Rect(textX, up + (eTextH + 1)*i, backW - textX, eTextH)];
            rightLb.delegate = self;
            [back addSubview:rightLb];
            rightLb.backgroundColor = [UIColor clearColor];
            rightLb.text = dates[i];
            rightLb.contentVerticalAlignment =  UIControlContentVerticalAlignmentCenter;
            if (i == 1) {
                rightLb.keyboardType = UIKeyboardTypeNumberPad;
                phoneText = rightLb;
            }else if (i == 0)
            {
                nameText = rightLb;
            }else
            {
                alipayText = rightLb;
            }
            
            UIView *line = [[UIView alloc] init];
            [back addSubview:line];
            CGFloat lineY = (eTextH + 1) * (i + 1);
            if (i != 2) {
                line.frame = Rect(0, lineY, backW, 0.5);
                line.backgroundColor = HexRGB(KCellLineColor);
            }
        }
    }else
    {
        CGFloat backHH = 150;
        CGFloat backW = kWidth - startXY * 2;
        UIView *back = [[UIView alloc] initWithFrame:Rect(startXY, inforY + startXY, backW, backHH)];
        _viewH = CGRectGetMaxY(back.frame) + 40;
        [_backScroll addSubview:back];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 3.0;
        
        NSString *nickName = [SystemConfig sharedInstance].user.userName;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSString *phone = [user objectForKey:Account];
        NSString *ali = [SystemConfig sharedInstance].user.alipay;
        
        NSArray *titles = @[@"昵 称|",@"手机号|",@"支付宝|"];
        NSArray *dates = @[nickName,phone,ali];
        CGFloat space = 5;
        CGFloat up = 0;
        CGFloat eTextH = ((backHH -up)/ 3);
        CGFloat eTextW = 70;
        for (int i = 0; i < 3; i++) {
            
            UILabel *leftLb = [[UILabel alloc] initWithFrame:Rect(space - spacer, up + (eTextH + 1) * i, eTextW, eTextH)];
            [back addSubview:leftLb];
            leftLb.text = titles[i];
            leftLb.backgroundColor = [UIColor clearColor];
            leftLb.textAlignment = NSTextAlignmentRight;
            
            CGFloat textX = CGRectGetMaxX(leftLb.frame) + 15;
            UITextField *rightLb = [[UITextField alloc] initWithFrame:Rect(textX, up + (eTextH + 1)*i, backW - textX, eTextH)];
            rightLb.delegate = self;
            [back addSubview:rightLb];
            rightLb.backgroundColor = [UIColor clearColor];
            rightLb.placeholder = dates[i];
            rightLb.contentVerticalAlignment =  UIControlContentVerticalAlignmentCenter;
            if (i == 1) {
                rightLb.keyboardType = UIKeyboardTypeNumberPad;
                phoneText = rightLb;
            }else if (i == 0)
            {
                nameText = rightLb;
            }else
            {
                alipayText = rightLb;
            }
            UIView *line = [[UIView alloc] init];
            [back addSubview:line];
            CGFloat lineY = (eTextH + 1) * (i + 1);
            if (i != 2) {
                line.frame = Rect(0, lineY, backW, 0.5);
                line.backgroundColor = HexRGB(KCellLineColor);
            }
        }
    }
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backScroll addSubview:done];
    done.layer.masksToBounds = YES;
    done.layer.cornerRadius = 5.0;
    CGFloat doneX = startXY + 10;
    done.frame = Rect(doneX, _viewH + 20, kWidth - doneX * 2, 40);
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done addTarget:self action:@selector(modefy) forControlEvents:UIControlEventTouchUpInside];
    done.backgroundColor = ButtonColor;
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _backScroll.contentSize = CGSizeMake(kWidth, CGRectGetMaxY(done.frame) + 10);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 开始修改资料
-(void)modefy
{
    [self.view endEditing:YES];
//    if (nameText.text.length > 0 && alipayText.text.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;
        //生成图片data
//       NSString *imgData = [self buildImgData:_head.icon.image];

        NSDictionary *prams = nil;
    if (_imgData == nil) {
        _imgData = @"";
    }
            if ([[SystemConfig sharedInstance].user.type intValue] == 0) {
                prams = [NSDictionary dictionaryWithObjectsAndKeys:_imgData,@"avatar", nameText.text,@"username",alipayText.text,@"alipay",nil];
        }else
        {
                prams = [NSDictionary dictionaryWithObjectsAndKeys:_imgData,@"avatar", nameText.text,@"address",alipayText.text,@"alipay",nil];
        }
            [HttpTool postWithPath:@"updateBaseInfo" params:prams success:^(id JSON, int code) {
//                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                if (code == 100) {
                    NSString *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
                    [RemindView showViewWithTitle:data location:MIDDLE];
                    [self autoLogin];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [RemindView showViewWithTitle:offline location:MIDDLE];
            }];
//    }
}

#pragma mark 自动登录
-(void)autoLogin
{
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
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }
}

-(NSString *)buildImgData:(UIImage *)img
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
    return string;
}

#pragma mark  准备上传头像
-(void)uploadIcon
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
    _head.icon.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self upLoadImg:img];
    
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
        }else
        {
            [RemindView showViewWithTitle:@"上传照片失败" location:MIDDLE];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

@end

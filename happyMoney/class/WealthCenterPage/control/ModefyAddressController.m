//
//  ModefyAddressController.m
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ModefyAddressController.h"
#import "MDSTextField.h"
#import "DefaultAddressModel.h"
#import "Tool.h"
#import "SystemConfig.h"
#import "UserItem.h"

@interface ModefyAddressController ()
{
    UITextField *nameText;
    UITextField *phoneText;
    UITextField *addressText;
    UILabel *hit;
    UIButton *_checkBtn;
}
@end

@implementation ModefyAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改地址";
    
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(confrom) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 60, 60);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    
    //back
    CGFloat startX  = 20;
    CGFloat backH = 120;
    CGFloat backW = kWidth - startX * 2;
    UIView *back = [[UIView alloc] initWithFrame:Rect(startX, startX, backW, backH)];
    [self.view addSubview:back];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.masksToBounds = YES;
    back.layer.cornerRadius = 5.0;
    
    CGFloat textY = 0;
    CGFloat eTextSX = 9;
    CGFloat eTextH = (backH / 3);
    CGFloat eTextW = backW - 2 * 2;
    for (int i = 0; i < 3; i++) {
        textY = i * eTextH;
        UITextField *text = [[UITextField alloc] initWithFrame:Rect(eTextSX, textY, eTextW, eTextH)] ;
        [back addSubview:text];
        [text setFont:[UIFont systemFontOfSize:PxFont(Font26)]];
        text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        text.backgroundColor = [UIColor clearColor];
        if (i == 1) {
            text.keyboardType = UIKeyboardTypeNumberPad;
            phoneText = text;
            phoneText.text = _address.phone_num;
        }else if (i == 0)
        {
            nameText = text;
            nameText.text = _address.contact;
        }else
        {
            addressText = text;
            addressText.text = _address.address;
        }
        
        UIView *line = [[UIView alloc] init];
        [back addSubview:line];
        CGFloat lineY = (eTextH + 1) * (i + 1);
        if (i != 2) {
            line.frame = Rect(2, lineY, eTextW, 0.5);
            line.backgroundColor = HexRGB(KCellLineColor);
        }
    }
    
    UILabel *hitL = [[UILabel alloc] init];
    hitL.frame = Rect(30, CGRectGetMaxY(back.frame) + 15, 120, 25);
    [self.view addSubview:hitL];
    hitL.text = @"设为默认地址";
    hitL.font = [UIFont systemFontOfSize:18.0];
    hitL.textColor = HexRGB(0x3a3a3a);
    hitL.backgroundColor = [UIColor clearColor];
    hit = hitL;
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:checkBtn];
    [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"check_selected"] forState:UIControlStateSelected];
    CGFloat chenckBtnX = CGRectGetMaxX(hitL.frame);
    checkBtn.frame  =  Rect(chenckBtnX, hitL.frame.origin.y, 25, 25);
    [checkBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _checkBtn = checkBtn;
    [self judgeStatus];
}

#pragma mark  判断是否能设置默认地址
-(void)judgeStatus
{
    NSLog(@"存储的ID:%@----now ID:%@",[SystemConfig sharedInstance].defaultAddress.ID,self.address.ID);
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:DefaultAddressIdKey ] isEqualToString:self.address.ID]) {
        hit.hidden = YES;
        _checkBtn.hidden = YES;
    }else
    {
        hit.hidden = NO;
        _checkBtn.hidden = NO;
    }
}

#pragma mark 默认按钮点击
-(void)checkBtnClicked:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        // 设置默认地址
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;

        NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:_address.ID,@"address_id", nil];
        [HttpTool postWithPath:@"setDefaultAddress" params:parm success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            [RemindView showViewWithTitle:msg location:MIDDLE];
            if (code == 100) {
               //隐藏默认摄者按钮，更新default 地址
                [SystemConfig sharedInstance].defaultAddress = self.address;
                [[NSUserDefaults standardUserDefaults] setObject:self.address.ID forKey:DefaultAddressIdKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSLog(@"存储的ID:%@----now ID:%@",[SystemConfig sharedInstance].defaultAddress,_address);
                
                hit.hidden = YES;
                _checkBtn.hidden = YES;
            }else
            {
                
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:offline location:MIDDLE];
        }];
    }
}

#pragma mark 确认按钮点击
-(void)confrom
{
    //修改地址
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;
    
    NSDictionary *parms = [NSDictionary dictionaryWithObjectsAndKeys:_address.ID,@"address_id", nameText.text,@"contact",phoneText.text,@"phone_num",addressText.text,@"address",nil];
    [HttpTool postWithPath:@"updateAddressInfo" params:parms success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *msg = [[JSON objectForKey:@"response"] objectForKey:@"data"];
        [RemindView showViewWithTitle:msg location:MIDDLE];
        if (code == 100) {
            //修改成功后，返回
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end

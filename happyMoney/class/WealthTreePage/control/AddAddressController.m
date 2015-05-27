//
//  AddAddressController.m
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "AddAddressController.h"
#import "MDSTextField.h"
#import "ImageTextView.h"

@interface AddAddressController ()<UITextFieldDelegate>
{
    UITextField *_nameText;
    UITextField *_phoneText;
    UITextField *_addressText;
}
@end

@implementation AddAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增地址";
    
    
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(confromadd) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    rightBtn.frame = Rect(0, 0, 60, 30);
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
    back.layer.cornerRadius = 3.0;
    
    NSArray *titles = @[@"请输入姓名",@"请输入正确的手机号",@"请输入详细地址"];
    CGFloat textY = 0;
    CGFloat eTextH = (backH / 3);
    CGFloat eTextW = backW - 2 * 2;
    for (int i = 0; i < 3; i++) {
        textY = i * eTextH;
        UITextField *text = [[UITextField alloc] initWithFrame:Rect(12, textY, eTextW, eTextH)];
        [back addSubview:text];
        text.backgroundColor = [UIColor clearColor];
        text.contentVerticalAlignment =  UIControlContentVerticalAlignmentCenter;
        text.placeholder = titles[i];
        if (i == 0) {
            _nameText = text;
        }else if (i == 1)
        {
            _phoneText = text;
            _phoneText.keyboardType = UIKeyboardTypeNumberPad;
        }else
        {
            _addressText = text;
        }
        UIView *line = [[UIView alloc] init];
        [back addSubview:line];
        CGFloat lineY = (eTextH) * (i + 1);
        if (i != 2) {
            line.frame = Rect(2, lineY, eTextW, 0.5);
            line.backgroundColor = HexRGB(KCellLineColor);
        }
    }
}

-(void)confromadd
{
    if (_nameText.text.length > 0 && _phoneText.text.length > 0 && _addressText.text.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.dimBackground = NO;
        
        //    NSLog(@"%@",_addressText.text);
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_nameText.text,@"contact",_phoneText.text,@"phone_num",_addressText.text,@"address", nil];
        
        [HttpTool postWithPath:@"addAddress" params:params success:^(id JSON, int code) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [RemindView showViewWithTitle:addAddressSuccess location:MIDDLE];
            if (code == 100) {
                //            NSString *addID = [[JSON objectForKey:@"response"] objectForKey:@"data"];
                [self.navigationController popViewControllerAnimated:YES];
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

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end

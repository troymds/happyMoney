//
//  MyInforController.m
//  happyMoney
//  我的资料
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "MyInforController.h"
#import "InfoHeadView.h"
#import "MDSTextField.h"
#import "ModifyInfoController.h"
#import "SystemConfig.h"
#import "UserItem.h"
@interface MyInforController ()<UITextFieldDelegate>
{
    InfoHeadView *_head;
    UILabel *_nickName;
    UILabel *_address;
    UILabel *_alipay;
}
@end

@implementation MyInforController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    
    if (_head) {
        [_head reloadData];
    }
    
    if ([[SystemConfig sharedInstance].user.type intValue] == 0) {
        _nickName.text = [SystemConfig sharedInstance].user.userName;
    }else
    {
        _address.text = [SystemConfig sharedInstance].user.address;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IsIos7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = HexRGB(0xeeeeee);
    self.title = @"我的资料";
    
    UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"修改" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    [rightBtn addTarget:self action:@selector(changeInfo) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = Rect(0, 0, 60, 30);
    UIBarButtonItem *rehtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rehtnItem;
    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    //1 head view
    CGFloat startXY = 10;
    CGFloat backH = 196/2;
    
    
    InfoHeadView *headView = [[InfoHeadView alloc] initWithFrame:Rect(startXY, startXY, kWidth - startXY * 2, backH)];
    _head = headView;
    [self.view addSubview:headView];
    _head.layer.masksToBounds = YES;
    _head.layer.cornerRadius = 5.0;
    CGFloat inforY = CGRectGetMaxY(headView.frame) + startXY;
    int isService =  [[SystemConfig sharedInstance].user.type intValue];
    
    CGFloat spacer = 10;
    
    if (isService != 0) {
        // info
        CGFloat backHH = 150;
        CGFloat backW = kWidth - startXY * 2;
        UIView *back = [[UIView alloc] initWithFrame:Rect(startXY, inforY + startXY, backW, backHH)];
        [self.view addSubview:back];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 3.0;
        
        NSString *address = [SystemConfig sharedInstance].user.address;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSString *phone = [user objectForKey:Account];
        NSString *ali = [SystemConfig sharedInstance].user.alipay;
        
        NSArray *titles = @[@"企业地址|",@"手机号|",@"支付宝|"];
        NSArray *dates = @[address,phone,ali];
        
//        NSArray *titles = @[@"企业地址:",@"手机号:",@"支付宝:"];
//        NSArray *dates = @[@"马大哥",@"13338878787",@"1736327328382@qq.com"];
        CGFloat space = 5;
        CGFloat up = 0;
        CGFloat eTextH = ((backHH -up)/ 3);
        CGFloat eTextW = 80;
        for (int i = 0; i < 3; i++) {
            
            UILabel *leftLb = [[UILabel alloc] initWithFrame:Rect(space - spacer + 2, up + (eTextH + 1)*i, eTextW, eTextH)];
            [back addSubview:leftLb];
            leftLb.text = titles[i];
            leftLb.backgroundColor = [UIColor clearColor];
            leftLb.textAlignment = NSTextAlignmentRight;
//            [leftLb sizeToFit];
            CGFloat textX = CGRectGetMaxX(leftLb.frame) + 13;
            UILabel *rightLb = [[UILabel alloc] initWithFrame:Rect(textX, up + (eTextH + 1)*i, backW - textX, eTextH)];
            [back addSubview:rightLb];
            rightLb.backgroundColor = [UIColor clearColor];
            rightLb.text = dates[i];
            
            if (i == 0) {
                _address = rightLb;
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
        CGFloat backHH = 100;
        CGFloat backW = kWidth - startXY * 2;
        UIView *back = [[UIView alloc] initWithFrame:Rect(startXY, inforY + startXY, backW, backHH)];
        [self.view addSubview:back];
        back.backgroundColor = [UIColor whiteColor];
        back.layer.masksToBounds = YES;
        back.layer.cornerRadius = 3.0;
        

        NSString *nickName = [SystemConfig sharedInstance].user.userName;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        
        NSString *phone = [user objectForKey:Account];
        NSString *ali = [SystemConfig sharedInstance].user.alipay;
        
        NSArray *titles = @[@"昵 称|",@"手机号|",@"支付宝|"];
        NSArray *dates = @[nickName,phone,ali];
        
//
//        NSArray *titles = @[@"手机号:",@"支付宝:"];
//        NSArray *dates = @[@"13338878787",@"1736327328382@qq.com"];
        CGFloat space = 5;
        CGFloat up = 0;
        CGFloat eTextH = ((backHH -up)/ 2);
        CGFloat eTextW = 80;
        for (int i = 0; i < 2; i++) {
            
            UILabel *leftLb = [[UILabel alloc] initWithFrame:Rect(space - spacer, up + (eTextH + 1)*i, eTextW, eTextH)];
            [back addSubview:leftLb];
            leftLb.text = titles[i];
            leftLb.backgroundColor = [UIColor clearColor];
            leftLb.textAlignment = NSTextAlignmentRight;
            
            CGFloat textX = CGRectGetMaxX(leftLb.frame) + 15;
            UILabel *rightLb = [[UILabel alloc] initWithFrame:Rect(textX, up + (eTextH + 1)*i, backW - textX, eTextH)];
            [back addSubview:rightLb];
            rightLb.backgroundColor = [UIColor clearColor];
            rightLb.text = dates[i];
            if (i == 0) {
                _nickName = rightLb;
            }else if (i == 2)
            {
                _alipay = rightLb;
                [rightLb sizeToFit];
            }
            UIView *line = [[UIView alloc] init];
            [back addSubview:line];
            CGFloat lineY = (eTextH + 1) * (i + 1);
            if (i != 1) {
                line.frame = Rect(0, lineY, backW, 0.5);
                line.backgroundColor = HexRGB(KCellLineColor);
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)changeInfo
{
    ModifyInfoController *ctl = [[ModifyInfoController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end

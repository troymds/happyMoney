//
//  CollectCashController.m
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CollectCashController.h"
#import "MDSTextField.h"
#import "CashMenuItem.h"

@interface CollectCashController ()<UITextFieldDelegate>
{
    CGFloat _thaw;//可提现金额
    CGFloat _freeze; //冻结中的金额
    CashMenuItem *_thawitem;
    CashMenuItem *_freezeitem;
    UITextField *_field;
}
@end

@implementation CollectCashController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    CGFloat startX = 20;
    CGFloat viewH = 0;
    //1 菜单栏
    NSArray *titles = @[@"可提现",@"冻结中"];
    NSArray *icons = @[@"canUse",@"frosen"];
    CGFloat itemH = 135;
    for (int i = 0; i < 2; i++) {
        CashMenuItem *item = [[CashMenuItem alloc] initWithFrame:Rect((kWidth/2) * i, 0, kWidth/2, itemH) icon:icons[i] title:titles[i] btnTag:i];
        [self.view addSubview:item];
        if (i == 0) {
            _thawitem = item;
        }else
        {
            _freezeitem = item;
        }
    }
    
    UIView *back = [[UIView alloc] initWithFrame:Rect(startX, itemH + 30, kWidth - startX *2, 40)];
    [self.view addSubview:back];
    back.backgroundColor = [UIColor whiteColor];
    
    UITextField *field = [[UITextField alloc] initWithFrame:Rect(startX, 0, back.frame.size.width - startX, 40)];
    field.delegate = self;
    [back addSubview:field];
    viewH = CGRectGetMaxY(back.frame);
    field.placeholder = @"请输入提现金额";
    field.returnKeyType = UIReturnKeyDone;
    field.backgroundColor = [UIColor clearColor];
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.keyboardType = UIKeyboardTypeNumberPad;
    _field = field;
    
    //3  温馨提示
    UILabel *hit = [[UILabel alloc] init];
    [self.view addSubview:hit];
    hit.textColor = HexRGB(0x3a3a3a);
    hit.font = [UIFont systemFontOfSize:PxFont(Font20)];
    hit.numberOfLines = 0;
    CGFloat hitX = startX * 1.5;
    CGFloat hitW = kWidth - hitX *2;
    hit.frame = Rect(hitX, viewH + 20, hitW, 60);
    hit.text = @"温馨提示：冻结中的资金指用户已经下单但还没确认收货的那部分资金";
    hit.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:hit.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [hit.text length])];
    hit.attributedText = attributedString;
    [hit sizeToFit];
    
    
    UIButton *cash = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:cash];
    cash.frame = Rect(startX, CGRectGetMaxY(hit.frame )+ 20, kWidth - startX * 2, 40);
    [cash setTitle:@"立即提现" forState:UIControlStateNormal];
    cash.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
    [cash addTarget:self action:@selector(cash) forControlEvents:UIControlEventTouchUpInside];
    cash.backgroundColor = ButtonColor;
    cash.layer.masksToBounds = YES;
    cash.layer.cornerRadius = 5.0;
    
    [self loadData];
}

-(void)loadData
{
    //收支记录(getFlowRecord)
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = NO;

    [HttpTool postWithPath:@"takeOutMoney" params:nil success:^(id JSON, int code) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if (code == 100) {
            NSDictionary *data = [[JSON objectForKey:@"response"] objectForKey:@"data"];
            if (![data isKindOfClass:[NSNull class]]) {
                NSString *cash = [data objectForKey:@"thaw"];
                if ([cash isKindOfClass:[NSNull class]]) {
                    _thaw = 0.0;
                }else
                {
                    _thaw = [cash floatValue];
                }
                
                NSString *frosen  = [data objectForKey:@"freeze"];
                if ([frosen isKindOfClass:[NSNull class]]) {
                    _freeze = 0.0;
                }else
                {
                    _freeze = [cash floatValue];
                }
                
                [self updateValule];
            }
        }else
        {
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [RemindView showViewWithTitle:offline location:MIDDLE];
    }];
}

-(void)updateValule
{
    _thawitem.money.text = [NSString stringWithFormat:@"¥ %.1f",_thaw];
    _freezeitem.money.text = [NSString stringWithFormat:@"¥ %.1f",_freeze];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)cash
{
    
    if (_field.text.length > 0) {
        if ([_field.text floatValue] <=  [_thawitem.money.text floatValue]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.dimBackground = NO;
            
            NSDictionary *parm = [NSDictionary dictionaryWithObjectsAndKeys:_field.text,@"apply_num", nil];
            [HttpTool postWithPath:@"applyTakeOutMoney" params:parm success:^(id JSON, int code) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                
                if (code == 100) {
                    
                }
                [RemindView showViewWithTitle:[[JSON objectForKey:@"response"] objectForKey:@"data"] location:MIDDLE];
            } failure:^(NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [RemindView showViewWithTitle:offline location:MIDDLE];
            }];
        }else
        {
            [RemindView showViewWithTitle:@"金额不足" location:MIDDLE];
        }
    }else{
        [RemindView showViewWithTitle:@"请输入提现金额" location:MIDDLE];
    }
}

//收起键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end

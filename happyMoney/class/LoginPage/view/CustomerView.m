//
//  CustomerView.m
//  Manicure
//
//  Created by tianj on 14-12-11.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import "CustomerView.h"
#import "Tool.h"

@implementation CustomerView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat height = 41;
        CGFloat leftDistance = 13;
        CGFloat topDistance = 22;
        
        _accountView = [[ImageTextView alloc] initWithFrame:CGRectMake(leftDistance,topDistance,kWidth-leftDistance*2,height)];
        _accountView.layer.masksToBounds = YES;
        _accountView.imageView.image = [UIImage imageNamed:@"phone_login"];
        _accountView.textField.placeholder = @"请输入手机号码";
        _accountView.textField.keyboardType = UIKeyboardTypeNumberPad;
        _accountView.layer.cornerRadius = 4.0f;
        _accountView.layer.borderWidth = 1.0f;
        _accountView.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        [self addSubview:_accountView];
        
        _passWordView = [[ImageTextView alloc] initWithFrame:CGRectMake(leftDistance,topDistance+height+22,kWidth-leftDistance*2, height)];
        _passWordView.textField.placeholder = @"请输入密码";
        _passWordView.imageView.image = [UIImage imageNamed:@"lock_login"];
        _passWordView.textField.secureTextEntry = YES;
        _passWordView.layer.masksToBounds = YES;
        _passWordView.layer.cornerRadius = 4.0f;
        _passWordView.layer.borderWidth = 1.0f;
        _passWordView.layer.borderColor = HexRGB(0xc3c3c3).CGColor;
        [self addSubview:_passWordView];
        
        UIButton *losePassWord = [UIButton buttonWithType:UIButtonTypeCustom];
        losePassWord.frame = CGRectMake(kWidth-leftDistance-60,_passWordView.frame.origin.y+_passWordView.frame.size.height+5,60, 20);
        [losePassWord setTitle:@"忘记密码" forState:UIControlStateNormal];
        [losePassWord setTitleColor:HexRGB(0xe5376b) forState:UIControlStateNormal];
        [losePassWord addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        losePassWord.titleLabel.font = [UIFont systemFontOfSize:14];
        losePassWord.tag = loseTag;
        [self addSubview:losePassWord];
        
        NSArray *array = [NSArray arrayWithObjects:@"注册",@"登录", nil];
        CGFloat width = (kWidth-leftDistance*3)/2;
        for (int i = 0; i <array.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(leftDistance+(width+leftDistance)*i,topDistance+height*2+22+44,width,height);
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            btn.tag = 2000+i;
            UIImage *image ;
            if (i == 0 ) {
             image = [Tool imageFromColor:HexRGB(0x86f897) size:CGSizeMake(kWidth/2, 35)];
                
            }else{
                
              image = [Tool imageFromColor:HexRGB(0xe5376b) size:CGSizeMake(kWidth/2, 35)];
            }
            btn.layer.cornerRadius = 3.0;
            btn.layer.masksToBounds = YES;
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
    }
    return self;
}
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(customerBtnClick:view:)]) {
        [self.delegate customerBtnClick:btn view:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

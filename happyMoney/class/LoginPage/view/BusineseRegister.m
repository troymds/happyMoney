//
//  BusineseRegister.m
//  happyMoney
//
//  Created by promo on 15-4-21.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "BusineseRegister.h"
#import "MDSTextField.h"
#import "ImageTextView.h"

#define KRegidtBtnH 40

@implementation BusineseRegister

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1 scrollview
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:scroll];
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.pagingEnabled = NO;
        scroll.bounces = NO;
        scroll.scrollEnabled = YES;
        scroll.userInteractionEnabled = YES;
        
        //2 初始化所有编辑框
        CGFloat startX = 0;
        CGFloat startY = 5;
        CGFloat height = 40;
        CGFloat width = frame.size.width;
        CGFloat space = 10;
        CGFloat scrollH = 0;
        
        NSArray *placeHolds = @[@"请输入申请人的真实姓名",@"请输入店铺名称",@"请输入店铺的具体地址",@"请输入营业执照证号"];
        NSArray *imgs = @[@"login_03",@"login_18",@"login_20",@"login_22"];
        
        for (int i = 0; i < placeHolds.count; i++)
        {
            CGRect rect = CGRectMake(startX, startY + (height + space) * i, width, height);
            MDSTextField *field = [[MDSTextField alloc] initWithFrame:rect placeHold:placeHolds[i] leftImg:imgs[i] index:i];
            [scroll addSubview:field];
            if (i == placeHolds.count - 1) {
                scrollH = CGRectGetMaxY(rect);
                field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
                _license = field;
                
            }else if (i == 0)
            {
                _contact = field;
            }
            else if (i == 1)
            {
                _businessName = field;
            }
            else if (i == 2)
            {
                _businessAddress = field;
            }
        }
        CGFloat lbW  = frame.size.width;
        CGFloat lbH = 25;
        CGFloat lbStartY = scrollH + 20;
        NSArray *titels = @[@"温馨提示：",@"1. 您的销售额达到90，成功的几率才会高哦"];
        for (int i = 0; i < 2; i++) {
            
            UILabel *lb = [[UILabel alloc] initWithFrame:Rect(0, lbStartY + (lbH + 5) * i, lbW, 25)];
            [scroll addSubview:lb];
            lb.text = titels[i];
            lb.numberOfLines = 1;
            lb.font = [UIFont systemFontOfSize:14];
            lb.textColor = HexRGB(0x808080);
            lb.backgroundColor = [UIColor clearColor];
            if (i == 1) {
                scrollH = CGRectGetMaxY(lb.frame);
            }
        }
        
        //4 立即申请
        UIButton *regisetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [regisetBtn setBackgroundColor:ButtonColor];
        regisetBtn.layer.masksToBounds  = YES;
        regisetBtn.layer.cornerRadius = 5.0;
        [regisetBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        regisetBtn.frame = CGRectMake(0, scrollH + KRegidtBtnH - 20, frame.size.width, KRegidtBtnH);
        [regisetBtn addTarget:self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:regisetBtn];
        
        scrollH = CGRectGetMaxY(regisetBtn.frame) + KRegidtBtnH;
        scroll.contentSize = CGSizeMake(width, scrollH);
    }
    return self;
}

#pragma mark 立即申请
- (void) registNow
{
    if ([self.delegate respondsToSelector:@selector(BusinessApply)]) {
        [self.delegate BusinessApply];
    }
}

@end

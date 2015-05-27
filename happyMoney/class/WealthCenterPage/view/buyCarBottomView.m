//
//  buyCarBottomView.m
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "buyCarBottomView.h"

@implementation buyCarBottomView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //1 check btn
        CGFloat startX = 10;
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:checkBtn];
        [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [checkBtn setImage:[UIImage imageNamed:@"check_selected"] forState:UIControlStateSelected];
        CGFloat checkWH = 22;
        checkBtn.frame  =  Rect(startX, startX, checkWH, checkWH);
        _allBtn = checkBtn;
        
        //2 total
        CGFloat titleW = 60;
        UILabel *all = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(checkBtn.frame) + 1, startX, titleW, checkWH)];
        [self addSubview:all];
        all.text = @"全选";
        all.textColor = HexRGB(0x808080);
        
        UILabel *total = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(all.frame) - 13, startX, 45, checkWH)];
        [self addSubview:total];
        total.text = @"总计:";
        total.textColor = HexRGB(0x808080);
        
        UILabel *money = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(total.frame), startX, 80, checkWH)];
        [self addSubview:money];
        money.text = @"¥ 216";
        _total = money;
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat deleteY = 4;
        CGFloat deleteH = self.frame.size.height - deleteY * 2;
        CGFloat deleteW = 65;
        CGFloat deleteX = kWidth - startX - deleteW;
        deleteBtn.frame = Rect(kWidth - startX - deleteW, deleteY, deleteW, deleteH);
        [self addSubview:deleteBtn];
        deleteBtn.layer.masksToBounds = YES;
        deleteBtn.layer.cornerRadius = 5.0;
        deleteBtn.layer.backgroundColor = ButtonColor.CGColor;
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deletaBtn = deleteBtn;
        
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:payBtn];
        CGFloat payX = deleteX  - startX - deleteW;
        payBtn.frame = Rect(payX, deleteY, deleteW, deleteH);
        payBtn.layer.masksToBounds = YES;
        payBtn.layer.cornerRadius = 5.0;
        payBtn.layer.backgroundColor = ButtonColor.CGColor;
        [payBtn setTitle:@"去结算" forState:UIControlStateNormal];
        _payBtn = payBtn;
        
    }
    return self;
}

@end

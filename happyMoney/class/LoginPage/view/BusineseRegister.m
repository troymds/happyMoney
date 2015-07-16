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

@interface BusineseRegister()<UITextFieldDelegate>

@end

@implementation BusineseRegister
{
    CGFloat keyBoardH;//键盘高度
    UIScrollView *_backScroll;
    CGFloat viewW;
    CGFloat viewH;
    MDSTextField *_selectedField;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 利用通知中心监听键盘的变化（打开、关闭、中英文切换）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        
        //1 scrollview
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:scroll];
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.pagingEnabled = NO;
        scroll.bounces = NO;
        scroll.scrollEnabled = YES;
        scroll.userInteractionEnabled = YES;
        _backScroll = scroll;
        
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
            field.imgField.textField.delegate = self;
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
        _contentHeight = scrollH;
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

#pragma mark - 键盘边框大小变化
- (void)keyboardChange:(NSNotification *)notification
{
    // 1. 获取键盘的目标区域
    NSDictionary *info = notification.userInfo;
    CGRect rect = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyBoardH = rect.size.height;
    // 2. 根据rect的orgion.y可以判断键盘是开启还是关闭
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        // 键盘已经关闭
        [UIView animateWithDuration:duration animations:^{
            [_backScroll setContentSize:CGSizeMake(viewW, _contentHeight)];
            [_backScroll setContentOffset:CGPointMake(0, 0) animated:YES];
        }];
    } else {
        // 键盘打开
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    for (UIView *view in _backScroll.subviews) {
        if ([view isKindOfClass:[MDSTextField class]]) {
            MDSTextField *text = (MDSTextField *)view;
            if (text.imgField.textField.tag == textField.tag) {
                
                _selectedField = text;
                //只要最下面的立即申请按钮在键盘的上面，就不需要再增加偏移量的值了
                CGFloat editViewY = text.frame.origin.y;
//                CGFloat editH = text.frame.size.height;
                //                if (editH + editViewY > _backScroll.frame.size.height - keyBoardH) {
                [UIView animateWithDuration:0.25 animations:^{
                    [_backScroll setContentOffset:CGPointMake(0, editViewY) animated:YES];
                    [_backScroll setContentSize:CGSizeMake(viewW, _contentHeight + 253)];
                } completion:^(BOOL finished) {
                }];
                break;
            }
        }
    }
}
@end
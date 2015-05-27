//
//  BusinessApplyView.m
//  happyMoney
//  店铺申请注册编辑页面
//  Created by promo on 15-4-1.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "BusinessApplyView.h"
#import "MDSTextField.h"
#import "ImageTextView.h"
#import "Tool.h"

#define KRegidtBtnH 40
//#define KTextFieldW kWidth - (KStartX * 2)

@implementation BusinessApplyView
{
    int second;
    UIButton *_yzmBtn;
    UILabel *secondLabel;
    CGFloat keyBoardH;//键盘高度
    UIScrollView *_backScroll;
    CGFloat viewW;
    CGFloat viewH;
    MDSTextField *_selectedField;
    CGSize keyboardSize;
    CGFloat registBtnY;
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
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

        //1 scrollview
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:scroll];
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        scroll.pagingEnabled = NO;
        scroll.bounces = NO;
        scroll.backgroundColor = [UIColor clearColor];
        scroll.scrollEnabled = YES;
        scroll.userInteractionEnabled = YES;
        _backScroll = scroll;
        
        //2 初始化所有编辑框
        CGFloat startX = 0;
        CGFloat startY = 5;
        CGFloat height = 45;
        CGFloat width = frame.size.width;
        viewH = frame.size.height;
        viewW = width;
        CGFloat space = 5;
        CGFloat scrollH = 0;
        
        NSArray *placeHolds = @[@"请输入申请人真实姓名",@"请输入11位数手机号",@"请输入6-16位账号密码",@"请输入验证码",@"请输入店铺名称",@"请输入店铺具体地址",@"请输入店铺的营业执照编号"];
        NSArray *imgs = @[@"login_03",@"login_06",@"login_08",@"login_04",@"login_18",@"login_20",@"login_22"];
        for (int i = 0; i < placeHolds.count; i++)
        {
            CGRect rect = CGRectMake(startX, startY + (height + space) * i, width, height);
            MDSTextField *field = [[MDSTextField alloc] initWithFrame:rect placeHold:placeHolds[i] leftImg:imgs[i] index:i hasLeftImg:YES];
            field.imgField.textField.delegate = self;
            switch (i) {
            case 0:
                {
                    _contact = field;
                }
                break;
            case 1:
                {
                    _phoneNum = field;
                    field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                break;
            case 3:
                {
                    _veryfyNum = field;
                    field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
                    CGFloat yzmX = width - 10 - 100;
                    CGFloat yzmY = KMDSTextFieldY + 5;
                    CGFloat yzmH = (height + KMDSTextFieldY)- yzmY * 2;
                    UIButton *receiveYZM = [UIButton buttonWithType:UIButtonTypeCustom];
                    receiveYZM.layer.masksToBounds = YES;
                    receiveYZM.layer.cornerRadius = 5.0f;
                    receiveYZM.layer.borderWidth = 1.0;
                    receiveYZM.layer.borderColor = ButtonColor.CGColor;
                    receiveYZM.frame = Rect(yzmX, yzmY, 100, yzmH);
                    [receiveYZM setTitle:@"获取验证码" forState:UIControlStateNormal];
                    [receiveYZM setTitle:@"获取验证码" forState:UIControlStateHighlighted];
                    [receiveYZM setTitleColor:ButtonColor forState:UIControlStateNormal];
                    receiveYZM.backgroundColor = [UIColor whiteColor];
                    [_veryfyNum addSubview:receiveYZM];
                    _yzmBtn = receiveYZM;
                    [receiveYZM addTarget:self action:@selector(receiveyzm) forControlEvents:UIControlEventTouchUpInside];
                    
                    //点击验证码按钮后显示剩余时间文字的label
                    secondLabel = [[UILabel alloc] initWithFrame:_yzmBtn.frame];
                    secondLabel.textColor = HexRGB(0xffffff);
                    secondLabel.font = [UIFont systemFontOfSize:13];
                    secondLabel.textAlignment = NSTextAlignmentCenter;
                    secondLabel.layer.cornerRadius = 3.0f;
                    secondLabel.layer.masksToBounds = YES;
                    secondLabel.backgroundColor = [UIColor grayColor];
                    [_veryfyNum addSubview:secondLabel];
                    secondLabel.hidden = YES;
                    
                }
                break;
            case 2:
                {
                    _password = field;
                    field.imgField.textField.secureTextEntry = YES;
                    //登入眼睛按钮
                    CGFloat eyeWH = 25;
                    CGFloat yzmX = width - 10 - eyeWH;
                    CGFloat space = (KMDSTextH - eyeWH) / 2;
                    CGFloat yzmY =  KMDSTextFieldY + space;
                    UIButton *eye = [UIButton buttonWithType:UIButtonTypeCustom];
                    eye.frame = Rect(yzmX, yzmY, eyeWH, eyeWH);
                    [eye setBackgroundImage:[UIImage imageNamed:@"login_10"] forState:UIControlStateNormal];
                    [eye setBackgroundImage:[UIImage imageNamed:@"login_14"] forState:UIControlStateSelected];
                    [field addSubview:eye];
                    [eye addTarget:self action:@selector(eyeClicked:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                break;
            case 4:
                {
                    _businessName = field;
                }
                break;
            case 5:
                {
                    _businessAddress = field;
                }
                    break;
            case 6:
                {
                    _license = field;
                    field.imgField.textField.keyboardType = UIKeyboardTypeNumberPad;
                }
                    break;

            default:
                break;
            }

            [scroll addSubview:field];
            if (i == placeHolds.count - 1) {
                scrollH = CGRectGetMaxY(rect);
            }
        }
        
        //3 立即申请
        UIButton *regisetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [regisetBtn setBackgroundColor:[UIColor greenColor]];
        regisetBtn.layer.masksToBounds  = YES;
        regisetBtn.layer.cornerRadius = 5.0;
        [regisetBtn setTitle:@"立即申请" forState:UIControlStateNormal];
        regisetBtn.backgroundColor = ButtonColor;
        registBtnY = scrollH + 15;
        regisetBtn.frame = CGRectMake(0, registBtnY, frame.size.width, KRegidtBtnH);
        [regisetBtn addTarget:self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:regisetBtn];
        scrollH = CGRectGetMaxY(regisetBtn.frame) + 10;
        _contentHeight = scrollH;
//        _contentHeight = scrollH > height ? scrollH : height;
        scroll.contentSize = CGSizeMake(width, _contentHeight);
        
    }
    return self;
}


-(void)eyeClicked:(UIButton *)btn
{
    //如果有密码，则显示明文
    btn.selected = !btn.selected;
    if (btn.selected) {
        _password.imgField.textField.secureTextEntry = NO;
    }else
    {
        _password.imgField.textField.secureTextEntry = YES;
    }
}

-(void)receiveyzm
{
    
    //check data
    if ([self checkPhoneNum]) {
        
        if ([self.delegate respondsToSelector:@selector(BusinessYZMWith:)]) {
            [self.delegate BusinessYZMWith:_phoneNum.imgField.textField.text];
        }
    }
}

#pragma mark 检查电话号码
- (BOOL)checkPhoneNum
{
    if (_phoneNum.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入手机号码" location:MIDDLE];
        return NO;
    }
    if (![Tool isValidPhoneNum:_phoneNum.imgField.textField.text]) {
        [RemindView showViewWithTitle:@"手机号码格式不正确" location:MIDDLE];
        return NO;
    }
    return YES;
}

#pragma mark 立即申请
- (void) registNow
{
    if ([self checkData]) {
        if ([self checkPhoneNum]) {
            if ([self.delegate respondsToSelector:@selector(BusinessApplyapplyRegist)]) {
                [self.delegate BusinessApplyapplyRegist];
            }
        }
    }
}

#pragma mark 检查数据填写是否完整
- (BOOL)checkData
{
    if (_contact.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入申请人真实姓名" location:MIDDLE];
        return NO;
    }
    if (_phoneNum.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入11位数手机号" location:MIDDLE];
        return NO;
    }
    if (_veryfyNum.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入验证码" location:MIDDLE];
        return NO;
    }
    if (_password.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入6-16位账号密码" location:MIDDLE];
        return NO;
    }
    if (_businessName.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入店铺名称" location:MIDDLE];
        return NO;
    }
    if (_businessAddress.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入店铺具体地址" location:MIDDLE];
        return NO;
    }
    if (_license.imgField.textField.text.length == 0) {
        [RemindView showViewWithTitle:@"请输入店铺的营业执照编号" location:MIDDLE];
        return NO;
    }
    
    return YES;
}

-(void)updateBUI
{
    second = 60;
    _yzmBtn.hidden = YES;
    secondLabel.hidden = NO;
    secondLabel.text = [NSString stringWithFormat:@"%d秒后重新获取",second];
    [self performSelector:@selector(changeUI) withObject:nil afterDelay:1];
}

#pragma mark 更改获取验证码UI
- (void)changeUI
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeUI) object:nil];
    second--;
    secondLabel.text = [NSString stringWithFormat:@"%d秒后重新获取",second ];
    if (second == 0) {
        secondLabel.hidden = YES;
        _yzmBtn.hidden = NO;
    }else{
        [self performSelector:_cmd withObject:nil afterDelay:1];
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

-(void) keyboardDidShow:(NSNotification *) notification
{
    if (_selectedField == nil) return;
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    keyboardSize = [aValue CGRectValue].size;
//
    [self scrollToField];
}

-(void) keyboardWillHide:(NSNotification *) notification
{
//    NSTimeInterval duration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    
//    [UIView animateWithDuration:duration animations:^{
//        [_backScroll setContentOffset:CGPointMake(0, 0) animated:NO];
//    }];
//   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:self];
}

- (void)scrollToField
{
    //选择后，改变位置
    
    //只要最下面的立即申请按钮在键盘的上面，就不需要再增加偏移量的值了
    CGFloat editViewY =  _selectedField.frame.origin.y;
    CGFloat editH = _selectedField.frame.size.height + 30;
    CGFloat keyBoardHH = keyboardSize.height;
    CGFloat PHeight = _backScroll.frame.size.height - keyBoardHH;
    if (editH + editViewY > PHeight) {
        if (registBtnY > _backScroll.frame.size.height - keyBoardHH) {
            
        }
        [UIView animateWithDuration:0.25 animations:^{
            [_backScroll setContentOffset:CGPointMake(0, editViewY - 100) animated:YES];
            [_backScroll setContentSize:CGSizeMake(viewW, _contentHeight + 253)];
        }];
    }else
    {
        [_backScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
//    CGFloat editViewY = _selectedField.frame.origin.y;
//    CGRect aRect = _backScroll.bounds;
//    CGRect textFieldRect = _selectedField.frame;
//    aRect.origin.y = 0;
//    aRect.size.height -= keyboardSize.height;
//    
//    CGPoint textRectBoundary = CGPointMake(textFieldRect.origin.x, editViewY + _selectedField.frame.size.height);
//    
//    if (!CGRectContainsPoint(aRect, textRectBoundary)|| _backScroll.contentOffset.y > 0)  {
//        
//        CGPoint scrollPoint = CGPointMake(0.0, editViewY + _selectedField.frame.size.height - aRect.size.height);
//        
//        if (scrollPoint.y < 0) scrollPoint.y = 0;
//
//        [UIView animateWithDuration:0.25 animations:^{
//            [_backScroll setContentOffset:scrollPoint animated:YES];
//            [_backScroll setContentSize:CGSizeMake(viewW, _contentHeight - keyboardSize.height)];
//        } completion:^(BOOL finished) {
//        }];
//    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    for (UIView *view in _backScroll.subviews) {
        if ([view isKindOfClass:[MDSTextField class]]) {
            MDSTextField *text = (MDSTextField *)view;
            if (text.imgField.textField.tag == textField.tag) {
                
                _selectedField = text;
//                [self scrollToField];
                //
//                //只要最下面的立即申请按钮在键盘的上面，就不需要再增加偏移量的值了
                CGFloat editViewY = text.frame.origin.y;
                CGFloat editH = text.frame.size.height;
//                if (editH + editViewY > _backScroll.frame.size.height - keyBoardH) {
                    [UIView animateWithDuration:0.25 animations:^{
                        [_backScroll setContentOffset:CGPointMake(0, editViewY) animated:YES];
                        [_backScroll setContentSize:CGSizeMake(viewW, _contentHeight + 253)];
                    } completion:^(BOOL finished) {
                    }];
                    break;
                }
            }
//        }
    }
}
@end

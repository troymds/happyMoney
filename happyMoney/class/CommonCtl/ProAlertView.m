//
//  MyActionSheetView.m
//  PEM
//
//  Created by tianj on 14-9-30.
//  Copyright (c) 2014年 ___普尔摩___. All rights reserved.
//

#import "ProAlertView.h"
#import "AdaptationSize.h"
#import "Tool.h"
#define alertWidth ([UIScreen mainScreen].bounds.size.width-40)
#define messageLabelFont [UIFont systemFontOfSize:18]
#define messageWidth (alertWidth-40)

@interface ProAlertView ()
{
    UILabel *_titleLabel;
    UILabel *_messageLabel;
    UIView *bgView;
    UIView *view;
    UIWindow *secondWindow;
    NSMutableArray *_buttons;
    NSInteger _allBtnNum;
    UIButton *_oneButton;
    UIButton *_rigthButton;
    UIButton *_leftButton;
}

@end


@implementation ProAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString *)title withMessage:(NSString *)message delegate:(id)delegate cancleButton:(NSString *)cancelButtonTitle otherButton:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if (self = [super init]) {
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = HexRGB(0xffffff);
        _delegate = delegate;
        self.title = title;
        self.message = message;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = HexRGB(0xffffff);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = HexRGB(0xe5376b);
        _titleLabel.text = self.title;
        _titleLabel.font = [UIFont systemFontOfSize:19];
        [self addSubview:_titleLabel];
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.font = messageLabelFont;
        _messageLabel.text = message;
        _messageLabel.textColor = HexRGB(0xe5376b);
        [self addSubview:_messageLabel];
        
        
        _buttons = [[NSMutableArray alloc] init];
        NSMutableArray *otherButtons = [[NSMutableArray alloc] init];
        if(otherButtonTitles){
            [otherButtons addObject:otherButtonTitles];
            va_list list;
            va_start(list, otherButtonTitles);
            while(1){
                NSString *eachButton = va_arg(list, id);
                if(!eachButton)
                {
                    break;
                }
                [otherButtons addObject:eachButton];
            }
            va_end(list);
        }
        _allBtnNum = 0;
        if(cancelButtonTitle){
            _allBtnNum +=1;
        }
        _allBtnNum +=otherButtons.count;
        switch(_allBtnNum){
            case 0:
            {
                break;
            }
            case 1:
            {
                _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _oneButton.layer.cornerRadius = 3.0f;
                _oneButton.layer.masksToBounds = YES;
                _oneButton.frame = CGRectMake(0, 0, messageWidth,40);
                [_oneButton setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitles forState:UIControlStateNormal];
                [_oneButton setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
                [_oneButton setBackgroundImage:[Tool imageFromColor:HexRGB(0x86f897) size:CGSizeMake(_oneButton.frame.size.width,_oneButton.frame.size.height)] forState:UIControlStateNormal];

                _oneButton.tag = 0;
                [_oneButton addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_oneButton];
                break;
            }
            case 2:
            {
                CGFloat width = (alertWidth-40-10)/2;
                _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _leftButton.layer.cornerRadius = 3.0f;
                _leftButton.layer.masksToBounds = YES;
                _leftButton.frame = CGRectMake(0, 0, width,40);
                [_leftButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
                [_leftButton setTitleColor:HexRGB(0x808080) forState:UIControlStateNormal];
                [_leftButton setBackgroundImage:[Tool imageFromColor:HexRGB(0xeaeaea) size:CGSizeMake(_leftButton.frame.size.width,_leftButton.frame.size.height)] forState:UIControlStateNormal];
                _leftButton.tag = 0;
                [_leftButton addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_leftButton];
                
                _rigthButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _rigthButton.frame = CGRectMake(0, 0, width,40);
                _rigthButton.layer.cornerRadius = 3.0f;
                _rigthButton.layer.masksToBounds = YES;
                [_rigthButton setTitle:otherButtonTitles forState:UIControlStateNormal];
                [_rigthButton setTitleColor:HexRGB(0xffffff) forState:UIControlStateNormal];
                [_rigthButton setBackgroundImage:[Tool imageFromColor:HexRGB(0x86f897) size:CGSizeMake(_rigthButton.frame.size.width,_rigthButton.frame.size.height)] forState:UIControlStateNormal];
                _rigthButton.tag = 1;
                [_rigthButton addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:_rigthButton];

                break;
            }
            default:{
                for(int i = 0;i < otherButtons.count;i++){
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setTitle:[otherButtons objectAtIndex:i] forState:UIControlStateNormal];
                    [btn setTitleColor:HexRGB(0x000000) forState:UIControlStateNormal];
                    [btn setBackgroundImage:[UIImage imageNamed:@"action_btn.png"] forState:UIControlStateHighlighted];
                    btn.tag = i+1;
                    [btn addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchUpInside];
                    [_buttons addObject:btn];
                    [self addSubview:btn];
                }
                UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [cancelBtn setTitle:cancelButtonTitle?cancelButtonTitle:otherButtonTitles forState:UIControlStateNormal];
                [cancelBtn setTitleColor:HexRGB(0x000000) forState:UIControlStateNormal];
                [cancelBtn setBackgroundImage:[UIImage imageNamed:@"action_btn.png"] forState:UIControlStateHighlighted];
                cancelBtn.tag = 0;
                [cancelBtn addTarget:self action:@selector(actionButtonDown:) forControlEvents:UIControlEventTouchUpInside];
                [_buttons addObject:cancelBtn];
                [self addSubview:cancelBtn];
                break;
            }
        }
    }
    return self;
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect frame = [[UIScreen mainScreen] bounds];
//
//    secondWindow = [[UIWindow alloc] initWithFrame:frame];
//    secondWindow.windowLevel = UIWindowLevelAlert;
    
    bgView = [[UIView alloc] initWithFrame:frame];
    bgView.alpha = 0.0;
    bgView.backgroundColor = [UIColor blackColor];
    [window addSubview:bgView];
    self.center = secondWindow.center;
    [window addSubview:self];
//    [secondWindow makeKeyAndVisible];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    [UIView animateWithDuration:0.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self setupFrame];
        self.center = window.center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.center = window.center;
            bgView.alpha = 0.4;
            [self roate:orientation sacle:1.1];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.center = window.center;
                [self roate:orientation sacle:1.0];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }];
}

- (void)setupFrame
{
    CGFloat height = 0 ;
    if (self.title&&self.title.length!=0) {
        height = 44;
        _titleLabel.frame = CGRectMake(0, 0, alertWidth,44);
        _messageLabel.textColor = HexRGB(0xe5376b);
    }else{
        _messageLabel.textColor = HexRGB(0x808080);
    }
    CGFloat width = (alertWidth-40-10)/2;
    CGSize size = [AdaptationSize getSizeFromString:self.message Font:messageLabelFont withHight:CGFLOAT_MAX withWidth:messageWidth];
    switch (_allBtnNum) {
        case 0:
            break;
        case 1:
        {
            self.frame = CGRectMake((kWidth-alertWidth)*0.5,0, alertWidth,height+40+size.height+40+10);
            _oneButton.frame = CGRectMake(20,height+40+size.height,alertWidth-20*2,40);
        }
            break;
        case 2:
        {
            self.frame = CGRectMake((kWidth-alertWidth)*0.5, 0, alertWidth,height+40+size.height+40+10);
            _leftButton.frame = CGRectMake(20,height+40+size.height,width,40);
            _rigthButton.frame = CGRectMake(20+width+10, height+40+size.height,width,40);
        }
            break;
        default:
        {
            self.frame = CGRectMake((kWidth-alertWidth)*0.5, 0, alertWidth,height+40+size.height+(40+10)*_buttons.count);
            for (int i = 0 ; i < _buttons.count; i++) {
                UIButton *btn = (UIButton *)[_buttons objectAtIndex:i];
                btn.frame = CGRectMake(0,height+40+size.height+(40+10)*i, alertWidth, 40);
            }
        }
            break;
    };
    _messageLabel.frame = CGRectMake(20,height+20,messageWidth,size.height);
}

- (void)rotate:(UIInterfaceOrientation) orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(3*M_PI/2);
        [self setTransform:rotation];
    }else if (orientation == UIInterfaceOrientationLandscapeRight) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2);
        [self setTransform:rotation];
    }else if (orientation == UIInterfaceOrientationPortrait) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(0);
        [self setTransform:rotation];
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI);
        [self setTransform:rotation];
    }
}


- (void)roate:(UIInterfaceOrientation)orientation sacle:(float)num
{
    CGAffineTransform rotationTransform;
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        
        rotationTransform = CGAffineTransformMakeRotation(3*M_PI/2);
        
    }else if (orientation == UIInterfaceOrientationLandscapeRight) {
        
        rotationTransform = CGAffineTransformMakeRotation(M_PI/2);
        
    }else if (orientation == UIInterfaceOrientationPortrait) {
        
        rotationTransform = CGAffineTransformMakeRotation(0);
        
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        
        rotationTransform = CGAffineTransformMakeRotation(-M_PI);
        
    }
    
    CGAffineTransform scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity,num,num);
    
    self.transform = CGAffineTransformConcat(scaleTransform,rotationTransform);
}


- (void)actionButtonDown:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(proAclertView:clickButtonAtIndex:)]) {
        [self.delegate proAclertView:self clickButtonAtIndex:button.tag];
    }
    [self dismiss];
}

- (void)dismiss
{
    UIInterfaceOrientation oritention = [[UIApplication sharedApplication] statusBarOrientation];
    [UIView animateWithDuration:0.15f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self roate:oritention sacle:0.0001];
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end



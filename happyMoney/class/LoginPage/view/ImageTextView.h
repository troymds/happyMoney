//
//  ImageTextView.h
//  Manicure
//
//  Created by tianj on 14-12-17.
//  Copyright (c) 2014年 tianj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTextView : UIView<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITextField *textField;

- (id)initWithFrame:(CGRect)frame hasLeftImg:(BOOL )has;
@end

//
//  AddressCell.m
//  happyMoney
//  地址cell
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "AddressCell.h"
#import "DefaultAddressModel.h"
#import "SystemConfig.h"

@implementation AddressCell
{
    bool _isDefault;//是否默认
    UIView *_backview;
    CGFloat _backW;
    CGFloat _backH;
    UILabel *_name;
    UILabel *_tel;
    UILabel *_address;
    CGFloat _cellH;
    UILabel *_defaultLabel;
    UIImageView *_phoneIcon;
    UIImageView *_adIcon;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = HexRGB(0xeeeeee);
        
        _isDefault = YES;
        // back view
        UIView *backview = [[UIView alloc] init];
        backview.frame = CGRectZero;
        [self.contentView addSubview:backview];
        backview.backgroundColor = [UIColor whiteColor];
        backview.layer.borderWidth = 0.5;
        backview.layer.masksToBounds = YES;
        backview.layer.cornerRadius = 5.0f;
        backview.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        _backview = backview;
        
        //1 是否默认
      //2  name
        UILabel *name = [[UILabel alloc] init];
        if (_isDefault) {
            UILabel *defaultLabel = [[UILabel alloc] init];
            [backview addSubview:defaultLabel];
            defaultLabel.frame  = CGRectZero;
            defaultLabel.text  = @"[默认]";
            defaultLabel.textColor = HexRGB(0x1c9c28);
            defaultLabel.font = [UIFont boldSystemFontOfSize:PxFont(Font28)];
            defaultLabel.textAlignment = NSTextAlignmentLeft;
            _defaultLabel = defaultLabel;
            
        }else
        {
        }
        name.frame = CGRectZero;
        [backview addSubview:name];
        _name = name;
        name.textColor = HexRGB(0x3a3a3a);
        name.font = [UIFont boldSystemFontOfSize:PxFont(Font26)];
        name.text = @"马德盛";
        // check btn
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backview addSubview:checkBtn];
        UIImageView *phoneIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [backview addSubview:phoneIcon];
        phoneIcon.image  = [UIImage imageNamed:@"callPhone"];
        phoneIcon.backgroundColor = [UIColor clearColor];
        phoneIcon.frame = CGRectZero;

        _phoneIcon = phoneIcon;
        
        //3 phone
        UILabel *phone = [[UILabel alloc] init];
        [backview addSubview:phone];
        _tel = phone;
        phone.frame  = CGRectZero;
        phone.text  = @"13878789879";
        phone.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
        phone.textColor = HexRGB(0x808080);
        phone.backgroundColor = [UIColor clearColor];
        //4 address
        UIImageView *adIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [backview addSubview:adIcon];
        adIcon.image  = [UIImage imageNamed:@"receive_adress"];
        adIcon.backgroundColor = [UIColor clearColor];
        adIcon.frame = CGRectZero;
        _adIcon = adIcon;
        
        UILabel *address = [[UILabel alloc] init];
        [backview addSubview:address];
        _address = address;
        address.frame  = CGRectZero;
        address.text  = @"江苏南京江东北路16号";
        address.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
        address.textColor = HexRGB(0x808080);
        address.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setType:(AddressType)type
{
    if (type == KAddressModefy) {
        CGFloat endLineX = _backW - 40;
        CGFloat startY = 15;
        UIView *line = [[UIView alloc] initWithFrame:Rect(endLineX, startY, 1, _backH - startY * 2)];
        [_backview addSubview:line];
        line.backgroundColor = HexRGB(KCellLineColor);
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backview addSubview:deleteBtn];
        CGFloat deleteWH = 25;
        CGFloat btnX = CGRectGetMaxX(line.frame) + 5;
        deleteBtn.frame = Rect(btnX, _backH/2 - deleteWH/2, deleteWH, deleteWH);
        [deleteBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteAddress) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)deleteAddress
{
    if ([self.delegate respondsToSelector:@selector(deleteAddress:index:)]) {
        [self.delegate deleteAddress:_data index:_index];
    }
}

-(void)setData:(DefaultAddressModel *)data
{
    _data = data;
    
    _isDefault = YES;
    CGFloat startX = 20;
    CGFloat startY = 10;
    CGFloat leftDistence = 20;
    CGFloat backW = kWidth - leftDistence * 2;
    _backW = backW;
    
    CGFloat backH = (160 - leftDistence * 2);
    _backH = backH;
    CGFloat space = 5;
    
    // back view
    _backview.frame = Rect(leftDistence, leftDistence, backW, backH);
    
    //1 是否默认
    CGFloat dfX = 0;
    CGFloat dfH = 30;
    
    //2  name
    CGFloat nameX = 0;
    //判断是否默认
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:DefaultAddressIdKey ] isEqualToString:_data.ID]) {
        dfX = startX;
        _defaultLabel.frame  = Rect(dfX, startY, 100, dfH);
        _defaultLabel.text  = @"[默认]";
        _defaultLabel.hidden = NO;
        nameX = CGRectGetMaxX(_defaultLabel.frame) - 30;
        
    }else
    {
        _defaultLabel.hidden = YES;
        nameX = startX;
    }
    _name.frame = Rect(nameX, startY, 200, dfH);

    CGFloat phoneY = CGRectGetMaxY(_name.frame) + 10;

    CGFloat iconW = 25;
    _phoneIcon.frame = Rect(startX, phoneY, iconW, iconW);

    //3 phone
    CGFloat foneW = 6;
    CGFloat phoneX = CGRectGetMaxX(_phoneIcon.frame) + foneW +space;
    _tel.frame  = Rect(phoneX, phoneY, 200, iconW);

    _adIcon.frame = Rect(startX, CGRectGetMaxY(_tel.frame) + space, iconW, iconW);

    CGFloat addY = CGRectGetMaxY(_tel.frame) + space;
    _address.frame  = Rect(phoneX, addY, backW - CGRectGetMaxX(_adIcon.frame), iconW);

    _cellH = CGRectGetMaxY(_address.frame) + leftDistence;
    
    _name.text = data.contact;
    _tel.text = data.phone_num;
    _address.text = data.address;
}

-(CGFloat)getHeight
{
    return _cellH;
}
@end

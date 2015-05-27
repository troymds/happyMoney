//
//  WuliuView.m
//  happyMoney
//  确认订单物流view
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "WuliuView.h"

@implementation WuliuView
{
    WuliuViewClickedBlock _block;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0f;
        self.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        NSArray *names  = @[@"收件人|",@"手机号|",@"送达地址|"];
        NSArray *values  = @[@"回回",@"18772727272",@"南京市实际上减肥 i 撒 福建大赛风景降低送啊就佛风景"];
        for (int i = 0; i < 3; i++) {
            CGFloat startY = 5;
            CGFloat vH = frame.size.height / 3;
            CGFloat nameY = startY + vH * i;
            UILabel *name = [[UILabel alloc] initWithFrame:Rect(5, nameY, 100, vH)];
            name.text  = names[i];
            name.textColor = HexRGB(0x3a3a3a);
            name.font = [UIFont boldSystemFontOfSize:PxFont(Font28)];
            [self addSubview:name];
            name.backgroundColor = [UIColor clearColor];
            
            CGFloat valueX = CGRectGetMaxX(name.frame) + 10;
            UILabel *value = [[UILabel alloc] initWithFrame:Rect(valueX, nameY, frame.size.width - valueX, vH)];
            value.font = [UIFont systemFontOfSize:14.0];
            value.numberOfLines = 0;
            value.textColor = HexRGB(0x666666);
            value.font = [UIFont boldSystemFontOfSize:PxFont(Font28)];
            [self addSubview:value];
            value.backgroundColor = [UIColor clearColor];
            value.text = values[i];
            if (i == 0) {
                _receiver = value;
            }else if (i == 1)
            {
                _phone = value;
            }else
            {
                _address = value;
            }
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withBlock:(WuliuViewClickedBlock)block
{
    self = [super initWithFrame:frame];
    if (self) {
        _block = block;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        NSArray *names  = @[@"收件人|",@"手机号|",@"送达地址|"];
        NSArray *values  = @[@"回回",@"18772727272",@"南京市实际上减肥 i 撒 福建大赛风景降低送啊就佛风景"];
        for (int i = 0; i < 3; i++) {
            CGFloat startY = 5;
            CGFloat vH = frame.size.height / 3;
            CGFloat nameY = startY + vH * i;
            UILabel *name = [[UILabel alloc] initWithFrame:Rect(5, nameY, 100, vH)];
            name.text  = names[i];
            name.textColor = HexRGB(0x3a3a3a);
            name.backgroundColor = [UIColor clearColor];
            name.font = [UIFont systemFontOfSize:PxFont(Font22)];
            [self addSubview:name];
            
            CGFloat valueX = CGRectGetMaxX(name.frame) + 10;
            UILabel *value = [[UILabel alloc] initWithFrame:Rect(valueX, nameY, frame.size.width - valueX, vH)];
            value.numberOfLines = 0;
            value.backgroundColor = [UIColor clearColor];
            value.textColor = HexRGB(0x666666);
            value.font = [UIFont systemFontOfSize:PxFont(Font22)];
            [self addSubview:value];
            value.text = values[i];
            if (i == 0) {
                _receiver = value;
            }else if (i == 1)
            {
                _phone = value;
                UIImageView *arrow = [[UIImageView alloc] initWithFrame:Rect(frame.size.width - 30, nameY + 13, 25, 25)];
                [self addSubview:arrow];
                arrow.image = LOADPNGIMAGE(@"确认订单3");
                arrow.backgroundColor = [UIColor clearColor];
            }else
            {
                _address = value;
            }
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_block) {
        _block();
    }
}

-(void)setData:(DefaultAddressModel *)data
{
    _data = data;
    _receiver.text = data.contact;
    _phone.text = data.phone_num;
    _address.text = data.address;
}
@end

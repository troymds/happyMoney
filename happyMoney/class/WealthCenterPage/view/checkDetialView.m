//
//  checkDetialView.m
//  happyMoney
//
//  Created by promo on 15-4-10.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "checkDetialView.h"

@implementation checkDetialView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // tel
        UILabel *tel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:tel];
        tel.textColor = HexRGB(0x808080);
        tel.font = [UIFont systemFontOfSize:16];
        _tel = tel;
        
        // style
        UILabel *style = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:style];
        style.textColor = HexRGB(0x808080);
        style.font = [UIFont systemFontOfSize:16];
        _sty = style;
        
        //address
        UILabel *address = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:address];
        address.numberOfLines = 0;
        address.textColor = HexRGB(0x808080);
        address.font = [UIFont systemFontOfSize:16];
        _address = address;
        
    }
    return self;
}

- (void)setStyler:(KInfoStyle)styler
{
    CGFloat startY = 0;
    CGFloat start = 10;
    CGFloat addY = 0;
    if (styler == KInfoStyleWuliu) {
        //物流
        startY = 5;
        _tel.hidden = NO;
        _sty.text = @"物流";
    }else
    {
        startY = 10;
        _tel.hidden = YES;
        _sty.text = @"自提";
    }
    CGFloat space = 1;
    CGFloat titleh = (self.frame.size.height - startY * 2 - space)/2;
    _tel.frame = Rect(start, startY, 200, titleh);
    _tel.text = @"联系电话：13989786789";
    
    CGFloat styY = 0;
    if (styler == KInfoStyleWuliu) {
        addY = CGRectGetMaxY(_tel.frame) + space;
        styY = startY;
    }else
    {
        addY = self.frame.size.height / 2 - titleh/2;
        styY = addY;
    }
    _sty.frame = Rect(kWidth - 20 - 60, styY, 60, titleh);
    _address.frame = Rect(start, addY, kWidth, titleh);
    _address.text = @"送达地址：江苏南京洪武路09号";
}
@end

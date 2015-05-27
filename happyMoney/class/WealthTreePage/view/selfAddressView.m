//
//  selfAddressView.m
//  happyMoney
//
//  Created by promo on 15-4-21.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "selfAddressView.h"

@implementation selfAddressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = HexRGB(KCellLineColor).CGColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0f;
        
        //address
        CGFloat startX = 10;
        CGFloat addressH = 25;
        CGFloat startY = (frame.size.height - addressH)/2;
        UILabel *addressLB  = [[UILabel alloc] initWithFrame:Rect(startX, startY, frame.size.width - startX * 2, addressH)];
        _selfAddLB = addressLB;
        [self addSubview:addressLB];
        addressLB.adjustsFontSizeToFitWidth = YES;
        addressLB.textColor = HexRGB(0x808080);
        addressLB.font = [UIFont boldSystemFontOfSize:PxFont(Font24)];
        addressLB.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end

//
//  CargoBaseCell.m
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "CargoBaseCell.h"

@implementation CargoBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = HexRGB(0xffffff);
        
    }
    return self;
}

- (void)setType:(transeType)type
{
    _type = type;
}
@end

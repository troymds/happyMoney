//
//  BuyCarCell.m
//  happyMoney
//
//  Created by promo on 15-4-9.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "BuyCarCell.h"
#import "CarTool.h"
#import "ProductDetailModel.h"
#import "TGCenterLineLabel.h"

@implementation BuyCarCell
{

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        CGFloat startXY = 20;
        CGFloat imgWH = 60;
        CGFloat bottomSpace = 30;
        
        UIView *backGround = [[UIView alloc] initWithFrame:Rect(0, 0, kWidth, 146)];
        [self.contentView addSubview:backGround];
        backGround.backgroundColor = [UIColor whiteColor];
        //1 check box
        UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backGround addSubview:checkBtn];
        [checkBtn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [checkBtn setImage:[UIImage imageNamed:@"check_selected"] forState:UIControlStateSelected];
        CGFloat checkWH = 25;
        CGFloat checkY = startXY + (imgWH - checkWH)/2;
        checkBtn.frame  =  Rect(startXY, checkY, checkWH, checkWH);
        [checkBtn addTarget:self action:@selector(checkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectedBtn = checkBtn;
        
        //2 img
        CGFloat iconX = CGRectGetMaxX(checkBtn.frame) + startXY/2;
        UIImageView *icon  = [[UIImageView alloc] initWithFrame:Rect(iconX, startXY, imgWH, imgWH)];
        [backGround addSubview:icon];
        _img = icon;
        icon.backgroundColor  = [UIColor clearColor];
        
        //3 title
       CGFloat titleX = CGRectGetMaxX(icon.frame) + 10;
        CGFloat space = 5;
        CGFloat titleH = (imgWH - space * 2)/3;
        UILabel *title = [[UILabel alloc] initWithFrame:Rect(titleX, startXY, 100, titleH)];
        [backGround addSubview:title];
        _title  = title;
//        title.backgroundColor = [UIColor redColor];
        title.textColor = HexRGB(0x000000);
        title.font = [UIFont systemFontOfSize:PxFont(Font24)];
        title.text = @"标题 ";
        //4 now price
        UILabel *newPrice = [[UILabel alloc] initWithFrame:Rect(titleX, CGRectGetMaxY(title.frame) + space, 100, titleH)];
        [backGround addSubview:newPrice];
        _newprice  = newPrice;
        newPrice.text = @"¥ 108";
//        newPrice.backgroundColor = [UIColor redColor];
        newPrice.textColor = HexRGB(0xff7c70);
        newPrice.font = [UIFont systemFontOfSize:PxFont(Font24)];
        //5 old price
        TGCenterLineLabel *oldPrice = [[TGCenterLineLabel alloc] initWithFrame:Rect(titleX, CGRectGetMaxY(newPrice.frame) + space, 100, titleH)];
        [backGround addSubview:oldPrice];
        _oldPrice  = oldPrice;
//        oldPrice.backgroundColor = [UIColor redColor];
        oldPrice.textColor = HexRGB(0x808080);
        oldPrice.font = [UIFont systemFontOfSize:PxFont(Font24)];
        oldPrice.text = @"660";
        //6 line
        CGFloat lineXX = startXY - 5;
        UIView *line = [[UIView alloc] initWithFrame:Rect(lineXX, CGRectGetMaxY(icon.frame) + startXY, kWidth - lineXX * 2, 0.5)];
        [backGround addSubview:line];
        line.backgroundColor = HexRGB(KCellLineColor);
        //7 total price
        CGFloat totalLBW = 130;
        CGFloat actualW  = 80;
        CGFloat actuaY = CGRectGetMaxY(line.frame) + bottomSpace/3;
        CGFloat add = 60;
        UILabel *actual = [[UILabel alloc] initWithFrame:Rect(kWidth + add*1.5 - totalLBW - actualW, actuaY, actualW, 25)];
        [backGround addSubview:actual];
        actual.text = @"实付：";
        actual.font = [UIFont systemFontOfSize:15.0];
        actual.textColor = HexRGB(0x808080);
        
        UILabel *total = [[UILabel alloc] initWithFrame:Rect(kWidth + add - totalLBW, actuaY, totalLBW, 25)];
        [backGround addSubview:total];
        _totla = total;
        total.font = [UIFont systemFontOfSize:15.0];
        total.textColor = HexRGB(0x000000);
        total.text = @"¥ 108";
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:Rect(0, CGRectGetMaxY(total.frame) + 10, kWidth, 0.5)];
        [backGround addSubview:bottomLine];
        bottomLine.backgroundColor = HexRGB(KCellLineColor);
        
        //8 加减按钮
            CGFloat backW = 100;
            CGFloat backX = kWidth -20 - backW;
            CGFloat backY = newPrice.frame.origin.y;
            UIView *back = [[UIView alloc] initWithFrame:Rect(backX, backY, backW, 30)];
            [backGround addSubview:back];
            back.layer.masksToBounds = YES;
            back.layer.cornerRadius = 5.0;
            back.layer.borderWidth = 1.0;
            back.layer.borderColor = [UIColor grayColor].CGColor;
            
            NSArray *icons = @[@"heng",@"",@"add"];
        for (int i = 0; i < 3; i++) {
            CGFloat lineX = (backW/3) * (i + 1);
            UIView *line = [[UIView alloc] initWithFrame:Rect(lineX, 0, 1, backW)];
            [back addSubview:line];
            line.backgroundColor = [UIColor grayColor];
            
            CGFloat btnX = (backW/3) * i;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [back addSubview:btn];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = Rect(btnX, 0, backW/3, 30);
            [btn setBackgroundImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
            btn.tag = i;
            if (i == 1) {
//                btn.enabled = NO;
                _showBtn = btn;
                [btn setTitleColor :[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:PxFont(Font20)];
            }else if (i == 0)
            {
                _plusBtn = btn;
                btn.enabled = NO;//最少购买量是1
            }else
            {
                _addBun = btn;
            }
        }
    }
    return self;
}

-(void)setData:(ProductDetailModel *)data
{
    _data = data;
    [_img setImageWithURL:[NSURL URLWithString:data.image] placeholderImage:placeHoderImage];
    _title.text = data.name;
    _newprice.text = [NSString stringWithFormat:@"¥ %@",data.price];
    _oldPrice.text = [NSString stringWithFormat:@"¥ %@",data.old_price];
    _isSelected = data.isChosen;
    _selectedBtn.selected = data.isChosen;
    [_showBtn setTitle:[NSString stringWithFormat:@"%d",data.productCount] forState:UIControlStateNormal];
    if (_data.productCount == 1) {
        _plusBtn.enabled = NO;
    }else
    {
        _plusBtn.enabled = YES;
    }
    [self caculateTotalPrice];
}

-(void)btnClicked:(UIButton *)btn
{
    if (btn.tag == 2) {
        NSInteger count = _data.productCount;
        count++;
        if (count > 1) {
            //减号按钮显示
            _plusBtn.enabled = YES;
        }else
        {
            _plusBtn.hidden = NO;
        }

        [_showBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(CarClickedWithData:buttonType:)]) {
            [self.delegate CarClickedWithData:_data buttonType:kButtonAdd];
        }
//        [[CarTool sharedCarTool] addMenu:_detail];
        //jia
    }else if (btn.tag == 0)
    {
        //jian
        //1 更新数量,按钮的状态
        NSInteger count = _data.productCount;
        count--;
        if (count == 1) {
            //隐藏减号按钮
            _plusBtn.enabled = NO;
            
        }else
        {
            _plusBtn.enabled = YES;
        }

        [_showBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(CarClickedWithData:buttonType:)]) {
            [self.delegate CarClickedWithData:_data buttonType:kButtonReduce];
        }
//        [[CarTool sharedCarTool] plusMenu:_detail];
    }
    [self caculateTotalPrice];
    
}

-(void)checkBtnClicked:(UIButton *)btn
{
    //1 改变选中状态
    _selectedBtn.selected  = !_selectedBtn.selected;
    _isSelected = _selectedBtn.selected;
    _data.isChosen = _isSelected;
    //2 通知control 改变数值
    if ([_delegate respondsToSelector:@selector(changeCarValue)]) {
        [_delegate changeCarValue];
    }
}

-(void)caculateTotalPrice
{
    //计算总价
    CGFloat total = _data.productCount * [_data.price floatValue];
    _totla.text = [NSString stringWithFormat:@"¥ %.1f",total];
}
@end

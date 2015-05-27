//
//  TreeProductCell.m
//  happyMoney
//  财富树产品cell
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "TreeProductCell.h"
#import "ProductButton.h"
#import "CategoryModel.h"
#import "TreeProductItem.h"


@implementation TreeProductCell
{
    ProductButton *_selectedBtn;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = HexRGB(0xeeeeee);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置单元格中的按钮
        CGFloat w = kWidth / kProductPerRow;
        TreeProductItem *item = nil;
        int i;
        for (i = 0; i < kProductPerRow; i++) {
            item = [[TreeProductItem alloc] initWithFrame:CGRectMake(i * w , 0, w, kRowHeight)];
            [item setTag:kStartTag + i];
            item.backgroundColor = [UIColor clearColor];
            item.findBtn.tag = item.tag;
            // 给按钮添加监听方法
            [item.findBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:item];
        }
        if (i == 0) {
            _selectedBtn = item.findBtn;
        }
    }
    
    return self;
}

- (void)resetButttonWithArray:(NSArray *)array isfirst:(BOOL) isfirst
{
    /*
     每一排按钮的数量是固定的，如果存在对应的数组内容，
     显示按钮图像和标题，否则，隐藏按钮
     */
    for (NSInteger i = 0; i < kProductPerRow; i++) {
        TreeProductItem * item = (TreeProductItem *)[self viewWithTag:kStartTag + i];
        ProductButton *button =item.findBtn;
        
        if (i < array.count) {
            //设置数据
            CategoryModel * data = array[i];
            button.indexPath = _myIndexPath;
//            Product *p = [Product productWithName:data.nameGategory productImage:data.imageGategpry];
//            Product *p = [Product productWithName:array[i]];
            item.data = data;
            
            if (isfirst) {//如果是第一行，topline 离上面有8的距离
                [item.topLine setHidden:YES];
                CGRect rightRect = item.rightLine.frame;
                rightRect.origin.y += 8;
                rightRect.size.height -= 8;
                item.rightLine.frame = rightRect;
            }
        } else {
            [item setHidden: YES];
            [button setHidden:YES];
            [item.rightLine setHidden:YES];
        }
    }
}

#pragma mark - 按钮监听方法
- (void)clickButton:(ProductButton *)button
{
    // 通知代理执行协议方法
    [self.delegate productCell:self didSelectedButteon:button andIndex:_myIndexPath];
    
}

- (void)setMyIndexPath:(NSIndexPath *)myIndexPath
{
    _myIndexPath = myIndexPath;
}
@end

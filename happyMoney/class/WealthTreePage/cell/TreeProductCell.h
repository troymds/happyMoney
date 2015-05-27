//
//  TreeProductCell.h
//  happyMoney
//
//  Created by promo on 15-4-2.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kProductPerRow 3
#define kRowHeight 120
#define kStartTag 100

@class TreeProductCell;
@class ProductButton;

#pragma mark - 定义协议

@protocol ProductCellDelegate <NSObject>

- (void)productCell:(TreeProductCell *)productCell didSelectedButteon:(ProductButton *)button andIndex:(NSIndexPath *)indexPath;

@end

@interface TreeProductCell : UITableViewCell

@property (weak, nonatomic) id<ProductCellDelegate> delegate;

// 单元格所在的行数
@property (assign, nonatomic) NSInteger cellRow;
@property (strong, nonatomic) NSIndexPath * myIndexPath;
// 最开始的Y
@property (nonatomic, assign) CGFloat originY;
// 传入单元格需要使用的数组，设置表格行中的按钮信息
- (void)resetButttonWithArray:(NSArray *)array isfirst:(BOOL) isLast;
@end

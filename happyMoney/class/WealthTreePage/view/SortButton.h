//
//  SortButton.h
//  happyMoney
//
//  Created by promo on 15-4-17.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol sortDelegate <NSObject>
//-(void) sortwith:(NSString *)sort;
-(void) sort;
@end

typedef enum sortStatus {
    downToup,// 由低到高
    upTodown
} SortStatus;

#define KSortBtnStartTag 100
#define KSaleNum  100  //销量
#define KPrice    101  //价格

@interface SortButton : UIButton
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,assign) NSInteger btnTag;
@property (nonatomic,assign) SortStatus sortStatus;
@property (nonatomic,weak) id<sortDelegate> delegate;
-(void) rotateIcon;
-(void) changeArrowStatus;
@end

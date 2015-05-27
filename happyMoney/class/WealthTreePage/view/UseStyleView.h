//
//  UseStyleView.h
//  happyMoney
//
//  Created by promo on 15-4-7.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KUserTypeBones,
    KUserTypePay
}Usertype;

@protocol UseStyleDelegate <NSObject>
-(void)UserStyleWithIndex:(NSInteger )index;
@end

@interface UseStyleView : UIView
@property (nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,weak) id<UseStyleDelegate> delegate;

-(id) initWithFrame:(CGRect)frame userStyle:(NSInteger )count;
@end

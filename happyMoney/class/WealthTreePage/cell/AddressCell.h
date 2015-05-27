//
//  AddressCell.h
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DefaultAddressModel;

@protocol DeleteAddressDelegate <NSObject>
@optional
-(void) deleteAddress:(DefaultAddressModel *)address index:(NSInteger )index;
@end
typedef enum
{
    KAddressNomal,
    KAddressModefy
}AddressType;
@interface AddressCell : UITableViewCell
@property(nonatomic,assign) AddressType type;
@property(nonatomic,assign) DefaultAddressModel *data;
@property(nonatomic,assign) id<DeleteAddressDelegate> delegate;
@property(nonatomic,assign) NSInteger index;//行 
-(CGFloat)getHeight;
@end

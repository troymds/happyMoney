//
//  InOutRecordsCell.h
//  happyMoney
//
//  Created by promo on 15-4-8.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    KRecordOut, //支出是0
    KRecordIn
}recordType;

@class flowRecordModel;

@interface InOutRecordsCell : UITableViewCell
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) flowRecordModel *data;
@property (nonatomic, assign) recordType type;
@end

//
//  ChenkStatusController.m
//  happyMoney
//
//  Created by promo on 15-4-13.
//  Copyright (c) 2015年 promo. All rights reserved.
//

#import "ChenkStatusController.h"
#import "OrderProductView.h"
#import "FollowDetailView.h"
#import "FollowData.h"

@interface ChenkStatusController ()
{
    UIScrollView *_backScroll;
    CGFloat _ViewH ;
}
@end

@implementation ChenkStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看物流";
    
    [self initBackView];
    //1 top view
    CGFloat startXY = 10;
    CGFloat topViewH = 80;
    CGFloat averViewH = 40;
    UIView *topBack = [[UIView alloc] initWithFrame:Rect(0, 0, kWidth, topViewH)];
    [_backScroll addSubview:topBack];
    topBack.backgroundColor = HexRGB(0xeeeeee);
    
    UILabel *delivery = [[UILabel alloc] initWithFrame:Rect(startXY, startXY, kWidth, 30)];
    [_backScroll addSubview:delivery];
    delivery.textColor = HexRGB(0x3a3a3a);
    delivery.font = [UIFont systemFontOfSize:18.0];
    delivery.text = @"圆通快递";
    
    CGFloat numY = CGRectGetMaxY(delivery.frame) + 5;
    UILabel *numLB = [[UILabel alloc] initWithFrame:Rect(startXY, numY, kWidth, 30)];
    [_backScroll addSubview:numLB];
    numLB.textColor = HexRGB(0x808080);
    numLB.font = [UIFont systemFontOfSize:14.0];
    numLB.text = @"运单编号：460058989898989";
    
    
    //2 middle viewu
    _ViewH = topViewH;
    CGFloat orderViewH = 100;
    CGFloat num = 2;
    CGFloat midH = orderViewH * num + 40;
    UIView *midBack = [[UIView alloc] initWithFrame:Rect(0, _ViewH, kWidth, midH)];
    [_backScroll addSubview:midBack];
    midBack.backgroundColor = HexRGB(0xffffff);
    CGFloat proH = 100;
    CGFloat midHH = 0;
    for (int i = 0; i < num; i++) {
        
        OrderProductView *pro = [[OrderProductView alloc] init];
        pro.frame = Rect(0, proH * i, kWidth, proH);
        [midBack addSubview:pro];
        if (i == num - 1) {
            midHH = CGRectGetMaxY(pro.frame);
            
            CGFloat totalX = 80;
            CGFloat totalY = midHH + 10;
            CGFloat totalH = 40 - 10 * 2;
            UILabel *totalNum = [[UILabel alloc] initWithFrame:Rect(totalX, totalY, 120, totalH)];
            [midBack addSubview:totalNum];
            totalNum.textColor = HexRGB(0x808080);
            totalNum.font = [UIFont systemFontOfSize:18.0];
            totalNum.text = @"共2件商品";
            
            UILabel *totalCount = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(totalNum.frame) + 50, totalY, 60, totalH)];
            [midBack addSubview:totalCount];
            totalCount.textColor = HexRGB(0x808080);
            totalCount.font = [UIFont systemFontOfSize:18.0];
            totalCount.text = @"实付： ";
            
            UILabel *mone = [[UILabel alloc] initWithFrame:Rect(CGRectGetMaxX(totalCount.frame) + 5, totalY, 60, totalH)];
            [midBack addSubview:mone];
            mone.textColor = HexRGB(0x3a3a3a);
            mone.font = [UIFont systemFontOfSize:18.0];
            mone.text = @"¥ 216";
            
            midHH += 40;
            
            UIView *line2 = [[UIView alloc] initWithFrame:Rect(0, midHH, kWidth, 1)];
            [midBack addSubview:line2];
            line2.backgroundColor = [UIColor grayColor];
            

        }
    }
    //3 bottom view
    _ViewH += midH;
    CGFloat bottomY = _ViewH + 10;
    CGFloat bottomNum = 4;
    CGFloat followViewH = 60;
    CGFloat bottomViewH = followViewH * bottomNum + 40;
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:Rect(0, bottomY, kWidth, bottomViewH)];
    [_backScroll addSubview:bottomView];
    bottomView.backgroundColor = HexRGB(0xffffff);
    
    CGFloat follwoH = averViewH - startXY * 2;
    UILabel *followLB = [[UILabel alloc] initWithFrame:Rect(startXY, startXY, kWidth, follwoH)];
    [bottomView addSubview:followLB];
    followLB.textColor = HexRGB(0x3a3a3a);
    followLB.font = [UIFont systemFontOfSize:18.0];
    followLB.text = @"物流跟踪";
    
    UIView *line3 = [[UIView alloc] initWithFrame:Rect(startXY, averViewH, kWidth, 1)];
    [bottomView addSubview:line3];
    line3.backgroundColor = [UIColor grayColor];
    
    // 物流详情
    CGFloat detailY = averViewH + 1;
    CGFloat detailH = 60;
    NSArray *titles = @[@"正从上海南 已发出",@"快件到达 南京白下区 上一站是 南京",@"南京白下区的阳阳正在派件",@"快件已签收 签收人拍照签收"];
    NSArray *dates = @[@"2015-01-02 14:34:34",@"2015-01-03 14:34:33",@"2015-01-05 14:34:34",@"2015-01-08 15:33:14"];
    NSUInteger j = dates.count;
    for (int i = 0; i < dates.count; i ++) {
        FollowDetailView *detail = [[FollowDetailView alloc] initWithFrame:Rect(0, detailY + detailH * i, kWidth, detailH)];
        [bottomView addSubview:detail];
        FollowData *data = [[FollowData alloc] init];
        j--;
        if (j == dates.count - 1) {
            data.isLast = YES;
        }else
        {
            data.isLast = NO;
        }
        NSLog(@"%@",titles[j]);
        data.title = titles[j];
        data.date = dates[j];
        detail.data = data;
    }
    
    _backScroll.contentSize = CGSizeMake(kWidth, CGRectGetMaxY(bottomView.frame));
    
}


#pragma mark 底部scrollview
-(void) initBackView
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, KAppNoTabHeight)];
    [self.view addSubview:scroll];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.pagingEnabled = NO;
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.userInteractionEnabled = YES;
    _backScroll  = scroll;
}
@end

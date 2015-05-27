//
//  TGCover.h
//  团购
//
//  Created by apple on 13-11-15.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGCover : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;
@end



#import <UIKit/UIKit.h>
#import "ChangeItemDelegate.h"

@class Dock;

@protocol DockDelegate <NSObject>
@optional
- (void)dock:(Dock *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to;
//如果没有登录，准备先登入
-(void) loginWithSelectedIndex:(NSInteger )selectedIndex;
@end

@interface Dock : UIView<ChangeItemDelegate>
// 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title;

// 代理
@property (nonatomic, weak) id<DockDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

- (void)changeItemFrom:(NSInteger)from to:(NSInteger)to;

@end
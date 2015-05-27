

#import "Dock.h"
#import "DockItem.h"
#import "SystemConfig.h"

@interface Dock()
{
    DockItem *_selectedItem;
}
@end

@implementation Dock

#pragma mark 添加一个选项卡
- (void)addItemWithIcon:(NSString *)icon selectedIcon:(NSString *)selected title:(NSString *)title
{
    // 1.创建item
    DockItem *item = [[DockItem alloc] init];
    UIView *l =[[UIView alloc ]init];
    l.frame = CGRectMake(0, 0, kWidth, 1);
    [item addSubview:l];
    l.backgroundColor =HexRGB(0xe6e3e4);
    // 文字
    [item setTitle:title forState:UIControlStateNormal];
    // 图标
    [item setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    // 监听item的点击
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    // 2.添加item
    [self addSubview:item];
    NSUInteger count = self.subviews.count;
    // 默认选中第一个item
    if (count == 1) {
        [self itemClick:item];
        _selectedItem = item;
    }
    
    // 3.调整所有item的frame
    CGFloat height = self.frame.size.height; // 高度
    CGFloat width = self.frame.size.width / count; // 宽度
    for (int i = 0; i<count; i++) {
        DockItem *dockItem = self.subviews[i];
        dockItem.tag = i; // 绑定标记
        dockItem.frame = CGRectMake(width * i, 0, width, height);
    }
}


- (void)changeItem
{
    DockItem *item = self.subviews[1];
    [self itemClick:item];
}

- (void)changeItemFrom:(NSInteger)from to:(NSInteger)to
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[DockItem class]]) {
            DockItem *item = (DockItem *)subView;
            if (item.tag == to) {
                item.selected = YES;
                _selectedItem = item;
                _selectedIndex = _selectedItem.tag;
                
            }else{
                item.selected = NO;
            }
        }
    }
}

#pragma mark 监听item点击
- (void)itemClick:(DockItem *)item
{
    
    //如果点击的是第3个tab财富圈，要判断是否登录，没有登录，则弹出登录页面；
    if (item.tag == 2) {
        //判断是否已经登录
        if (![SystemConfig sharedInstance].isUserLogin) {
            //记录将要点击的tab index
            //            [SystemConfig sharedInstance].selectedIndex = item.tag;
            
            if ([self.delegate respondsToSelector:@selector(loginWithSelectedIndex:)]) {
                [self.delegate loginWithSelectedIndex:item.tag];
            }
        }else
        {
            // 0.通知代理
            if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
                [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
            }
            _selectedItem.selected = NO;
            
            // 2.选中点击的item
            item.selected = YES;
            
            // 3.赋值
            _selectedItem = item;
            
            _selectedIndex = _selectedItem.tag;
        }
    }else
    {
        // 0.通知代理
        if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
            [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
        }
        _selectedItem.selected = NO;
        
        // 2.选中点击的item
        item.selected = YES;
        
        // 3.赋值
        _selectedItem = item;
        
        _selectedIndex = _selectedItem.tag;
    }
    
    /*
    //如果点击的是非第一个tab，先判断是否登录，已经登录了，可以切换，如果没有，则弹出登录页面
    //否则，切换到第一个tab
    if (item.tag > 0) {
        //判断是否已经登录
        if (![SystemConfig sharedInstance].isUserLogin) {
            //记录将要点击的tab index
//            [SystemConfig sharedInstance].selectedIndex = item.tag;
            
            if ([self.delegate respondsToSelector:@selector(loginWithSelectedIndex:)]) {
                [self.delegate loginWithSelectedIndex:item.tag];
            }
        }else
        {
            // 0.通知代理
            if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
                [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
            }
            _selectedItem.selected = NO;
            
            // 2.选中点击的item
            item.selected = YES;
            
            // 3.赋值
            _selectedItem = item;
            
            _selectedIndex = _selectedItem.tag;
        }
    }else
    {
        if ([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]) {
            [_delegate dock:self itemSelectedFrom:_selectedItem.tag to:item.tag];
        }
        _selectedItem.selected = NO;
        
        // 2.选中点击的item
        item.selected = YES;
        
        // 3.赋值
        _selectedItem = item;
        
        _selectedIndex = _selectedItem.tag;
    }*/

}
@end
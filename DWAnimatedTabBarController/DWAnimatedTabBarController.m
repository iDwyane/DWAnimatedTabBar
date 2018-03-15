//
//  DWAnimatedTabBarController.m
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/22.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import "DWAnimatedTabBarController.h"
#import "DWBounceAnimation.h"

@interface DWAnimatedTabBarItem()
@property (weak, nonatomic) IBOutlet DWItemAnimation *animation;
@property (nonatomic, strong) UIImageView *iconViewIcon;
@property (nonatomic, strong) UILabel *iconViewTitle;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *iconColor;

@end

@implementation DWAnimatedTabBarItem

- (CGFloat)yOffset {
    return 5;
}

- (UIFont *)textFont {
    return [UIFont systemFontOfSize:10.0f];
}

- (UIColor *)textColor {
    return [UIColor blackColor];
}

- (UIColor *)iconColor {
    return [UIColor clearColor];
}

//选中时的动画
- (void)playAnimation {
    [self.animation playAnimation: self.iconViewIcon textLabel:self.iconViewTitle];
}
//取消选中时的动画
- (void)deselectAnimation {
    [self.animation deselectAnimation:self.iconViewIcon textLabel:self.iconViewTitle defaultTextColor:self.textColor defaultIconColor:self.iconColor];
}

- (void)selectedState {
    [self.animation selectedState:self.iconViewIcon textLabel:self.iconViewTitle];
}

@end

@interface DWAnimatedTabBarController ()<UITabBarDelegate>
{
    NSDictionary *containers;
}

@end

@implementation DWAnimatedTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self initialzeContainers];
}

- (void)initialzeContainers {

    //删除containers value下的所有子view
    for (UIView *subView in containers.allValues) {
        [subView removeFromSuperview];
    }
    //创建containers
    containers = [self createViewContainers];
    
    //创建自定义icon
    [self createCustomIcons:containers];
}

- (void)createCustomIcons:(NSDictionary *)containers {
    NSArray *items  = self.tabBar.items;
    
    //判断是否所有item都是DWAnimatedTabBarItem类型
//    if (items isKindOfClass:<#(__unsafe_unretained Class)#>) {
//        NSAssert(NO, @"哎呀呀,please add your ...");
//    }
    [items enumerateObjectsUsingBlock:^(DWAnimatedTabBarItem *item, NSUInteger index, BOOL * _Nonnull stop) {
        NSString *idxkey = [NSString stringWithFormat:@"container%ld", items.count - 1 - index]; //调换Viewcontainer的顺序
        UIView *container = containers[idxkey];
        container.tag = index;
        UIImage *iconImage= item.image;
        iconImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]; // 始终绘制图片原始状态，不使用Tint Color
        UIImageView *icon = [[UIImageView alloc] initWithImage:iconImage];
        icon.translatesAutoresizingMaskIntoConstraints = NO;
        [container addSubview:icon];
        item.iconViewIcon = icon;
        //约束每个自定义icon的位置
        CGSize itemSize = icon.image.size;
        [self createConstraintsWithView:icon container:container size:itemSize yOffset: -item.yOffset];
        
        UILabel *textLabel = [UILabel new];
        textLabel.text = item.title;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = item.textFont;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        //约束每个自定义textLabel的位置
        CGFloat textLabelWidth = self.tabBar.frame.size.width / (CGFloat)items.count - 5.0;
        [container addSubview:textLabel];
        item.iconViewTitle = textLabel;
        [self createConstraintsWithView:textLabel container:container width:textLabelWidth height:0 yOffset: 19-item.yOffset];
        
        if (0 == index) {
            [item selectedState]; //设置选中状态的属性
        }
        //移除底下tabbar的item图标以及标题
        item.image = nil;
        item.title = @"";
    }];
}

//约束
- (void)createConstraintsWithView:(UIView *)view container:(UIView *)container size:(CGSize)size yOffset:(CGFloat)yOffset {
    [self createConstraintsWithView:view container:container width:size.width height:size.height yOffset:yOffset];
}


//约束
- (void)createConstraintsWithView:(UIView *)view container:(UIView *)container width:(CGFloat)width height:(CGFloat)height yOffset:(CGFloat)yOffset {
    NSLayoutConstraint *viewX = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *viewY = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:container attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:yOffset];
    NSLayoutConstraint *viewW = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    if (height != 0) {
        NSLayoutConstraint *viewH = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
        [container addConstraint:viewH];
    }
    [container addConstraints:@[viewX, viewY, viewW]];
}

//创建每个View的容器
- (NSDictionary *)createViewContainers {
    NSArray *items  = self.tabBar.items;
    NSMutableDictionary *containersDict = [[NSMutableDictionary alloc] init];
    [items enumerateObjectsUsingBlock:^(DWAnimatedTabBarItem *item, NSUInteger index, BOOL * _Nonnull stop) {
        UIView *viewContainer = [self createViewContainer];
        NSString *containerkey = [NSString stringWithFormat:@"container%ld", index]; //第一个在最右边，第二个在右二，以此类推
        containersDict[containerkey] = viewContainer;
    }];
    
    //VFL语言
    NSString *formatString = @"H:|-(0)-[container0]";
    for (int i = 1; i < items.count; i++) {
        NSString *k = [NSString stringWithFormat:@"-(0)-[container%d(==container0)]", i];
        formatString = [formatString stringByAppendingString:k];
    }
    formatString = [formatString stringByAppendingString:@"-(0)-|"];
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:formatString options:NSLayoutFormatDirectionRightToLeft metrics:nil views:containersDict];
    [self.view addConstraints:constraints];

    return containersDict;
}

- (UIView *)createViewContainer {
    UIView *viewContainer = [UIView new];
    viewContainer.backgroundColor = [UIColor clearColor]; //for test
    viewContainer.translatesAutoresizingMaskIntoConstraints = NO;
    viewContainer.exclusiveTouch = YES;
    [self.view addSubview:viewContainer];
    
    
    //约束viewContiner的高度为60,leftX 和 leftY由VFL定义
    NSLayoutConstraint *con;
    if (@available(iOS 11.0, *)) { //适配
       con = [viewContainer.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor];
    }else {
        con = [viewContainer.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    }

    [NSLayoutConstraint activateConstraints:@[con]];
    NSLayoutConstraint *viewH = [NSLayoutConstraint constraintWithItem:viewContainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:49];
    [viewContainer addConstraint:viewH];
    
    //添加点击 add tapGesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [viewContainer addGestureRecognizer:tapGesture];
    
    return viewContainer;
}

- (void)tapAction:(UIGestureRecognizer *)gesture {
    NSArray *items = self.tabBar.items;
    
    NSInteger currentIdx = gesture.view.tag;
    
    UIViewController *controller = self.childViewControllers[currentIdx];
    //如果是当前tag，就return
    
    
    //选中是否当前item
    if (self.selectedIndex != currentIdx) {
        DWAnimatedTabBarItem *animationItem = items[currentIdx];
        [animationItem playAnimation];
        DWAnimatedTabBarItem *deselectItem = items[self.selectedIndex];
        [deselectItem deselectAnimation];
        
        UIView *container = animationItem.iconViewIcon.superview;
        container.backgroundColor = [UIColor clearColor];
        
        self.selectedIndex = gesture.view.tag;
    }else {
//        DWAnimatedTabBarItem *animationItem = items[currentIdx];
//        [animationItem playAnimation];
    }
    
}

@end

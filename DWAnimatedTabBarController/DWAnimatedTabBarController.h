//
//  DWAnimatedTabBarController.h
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/22.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWBounceAnimation.h"

@interface DWAnimatedTabBarItem : UITabBarItem

/**
 y偏移值
 */
@property (nonatomic, assign) CGFloat yOffset;
@property (nonatomic, strong) UIFont *textFont;
@end

@interface DWAnimatedTabBarController : UITabBarController

@end

//
//  DWItemAnimationProtocol.m
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/23.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import "DWItemAnimationProtocol.h"

@implementation DWItemAnimationProtocol

@end

@implementation DWItemAnimation : NSObject
- (CGFloat)duration {
    return 0.3;
}

- (UIColor *)textSelectedColor {
    return [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1];
}

- (UIColor *)iconSelectedColor {
    return [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1];
    
}
- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel {
    
}

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel {
    //如果设置统一，可在此写，有特殊设置可在各自的动画类写
    UIImage *iconImage = icon.image;
    UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.iconSelectedColor;
    textLabel.textColor = self.textSelectedColor;
}

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)textColor defaultIconColor:(UIColor *)iconColor {
    //如果设置统一，可在此写，有特殊设置可在各自的动画类写
    UIImage *iconImage = icon.image;
    UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    icon.image = renderImage;
    icon.tintColor = iconColor;
    textLabel.textColor = textColor;
    
}
@end

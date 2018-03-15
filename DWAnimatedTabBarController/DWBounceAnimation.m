//
//  DWBounceAnimation.m
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/23.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import "DWBounceAnimation.h"

// 角度转弧度
#define angle2Radion(angle) (angle / 180.0 * M_PI)

@implementation DWBounceAnimation

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel {
    [self playBounceAnimation:icon];
    textLabel.textColor = self.textSelectedColor;
}

- (void)playBounceAnimation:(UIImageView *)icon {
//    // 创建动画
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
//
//    anim.keyPath = @"transform.rotation";
//
//    // rotation旋转，需要添加弧度值
//    // angle2Radion() 角度转弧度的宏
//    // @() 包装为NSNumber对象
//    anim.values = @[@(angle2Radion(-5)),@(angle2Radion(5)),@(angle2Radion(-5))];
//
////    anim.repeatCount = MAXFLOAT;
//    anim.repeatCount = 10;
////    anim.duration = 1;
//
//    [icon.layer addAnimation:anim forKey:nil];
    
        // 创建动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.scale";
//    anim.values = @[@1.0, @1.4, @0.9, @1.15, @0.95, @1.02, @1.0];
    anim.values = @[@0.65, @0.75, @0.9, @1.0]; //仿QQ、飞猪、网易新闻点击
    anim.duration = self.duration;
    anim.calculationMode = kCAAnimationCubic;
    [icon.layer addAnimation:anim forKey:nil];
    
    UIImage *iconImage = icon.image;
    UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.iconSelectedColor;
}

@end

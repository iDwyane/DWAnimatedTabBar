//
//  DWRotationAnimation.m
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/24.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import "DWRotationAnimation.h"

typedef NS_ENUM(NSUInteger, direction) {
    directionLeft,
    directionLeftRight,
} DWRotationDirection;
@interface DWRotationAnimation()

/**
 Animation direction
 */
@property (nonatomic, strong) DWRotationAnimation *direction;
@end


@implementation DWRotationAnimation

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel {
    [self playRoatationAnimation:icon];
    textLabel.textColor = self.textSelectedColor;
}

- (void)playRoatationAnimation:(UIImageView *)icon {
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.fromValue = @0.0f;
    CGFloat toValue = M_PI * 2;
    if (self.direction != nil && self.direction == directionLeft) {
        toValue *= -1.0;
    }
    anim.toValue = [NSNumber numberWithFloat:toValue];
    anim.duration = self.duration;
    [icon.layer addAnimation:anim forKey:nil];

    UIImage *iconImage = icon.image;
    UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.iconSelectedColor;
}
@end

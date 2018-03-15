//
//  DWTransformAnimation.m
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/25.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import "DWTransformAnimation.h"

@implementation DWTransformAnimation

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel {
    [self playTransformAnimation:icon];
    textLabel.textColor = self.textSelectedColor;
}

- (void)playTransformAnimation:(UIImageView *)icon {
    
    //向上移动
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.removedOnCompletion = YES;
    animation.fromValue = [NSNumber numberWithFloat:0];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:-13];     //结束伸缩倍数
    [icon.layer addAnimation:animation forKey:nil];
    
    UIImage *iconImage = icon.image;
    UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    icon.image = renderImage;
    icon.tintColor = self.iconSelectedColor;
}

@end

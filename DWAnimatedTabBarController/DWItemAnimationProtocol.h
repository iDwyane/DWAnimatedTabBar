//
//  DWItemAnimationProtocol.h
//  DWAnimatedTabBar
//
//  Created by Dwyane on 2018/2/23.
//  Copyright © 2018年 Dwyane_Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DWItemAnimationProtocol <NSObject>
- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel;
- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel;
- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)textColor defaultIconColor:(UIColor *)iconColor;
@end

@interface DWItemAnimation : NSObject< DWItemAnimationProtocol>

/**
 动画持续时间
 */
@property (nonatomic, assign) CGFloat duration;

/**
 icon选中时的颜色  加上IBInspectable可以再xib或者sb那里设置
 */

@property (nonatomic, strong)IBInspectable UIColor *iconSelectedColor;
/**
 text选中时的颜色
 */

@property (nonatomic, strong)IBInspectable UIColor *textSelectedColor;
@end

@interface DWItemAnimationProtocol : NSObject
@end

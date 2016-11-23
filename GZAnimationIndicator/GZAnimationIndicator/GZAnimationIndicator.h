//
//  GZAnimationIndicator.h
//  GZAnimationIndicator
//
//  Created by armada on 2016/11/17.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZAnimationIndicator : UIView

/*!
 * @brief 初始化构造器
 * @param circleColor Circle color in the center
 * @param dotColor The color of dots around the circle.
 * @param lightedDotColor The color of dots after they are lighted
 */

- (instancetype)initWithFrame:(CGRect)frame
                  circleColor:(UIColor *)circleColor
                     dotColor:(UIColor *)dotColor
              lightedDotColor:(UIColor *)lightedDotColor;

@end

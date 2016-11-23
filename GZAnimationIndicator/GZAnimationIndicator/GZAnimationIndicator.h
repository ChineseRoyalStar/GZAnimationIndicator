//
//  GZAnimationIndicator.h
//  GZAnimationIndicator
//
//  Created by armada on 2016/11/17.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

/*                          水龙吟·次韵章质夫杨花词 苏轼
    似花还似非花，也无人惜从教坠。抛家傍路，思量却是，无情有思。萦损柔肠，困酣娇眼，欲开还闭。梦随风万里，寻郎去处，又还被、莺呼起。
    不恨此花飞尽，恨西园、落红难缀。晓来雨过，遗踪何在？一池萍碎。春色三分，二分尘土，一分流水。细看来，不是杨花，点点是离人泪。
 */

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

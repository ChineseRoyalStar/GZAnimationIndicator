//
//  GZAnimationIndicator.m
//  GZAnimationIndicator
//
//  Created by armada on 2016/11/17.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import "GZAnimationIndicator.h"

@interface GZAnimationIndicator ()

@property(nonatomic,strong) CAShapeLayer                *shapeLayer;
@property(nonatomic,strong) CAGradientLayer             *gradientLayer;
@property(nonatomic,strong) CABasicAnimation            *strokeEndAnimation;
@property(nonatomic,strong) NSTimer                     *timer;
@property(nonatomic,strong) NSMutableArray<CALayer *>    *dotLayers;
@property(nonatomic,assign) NSUInteger                   index;
@property(nonatomic,strong) UIColor                     *circleColor;
@property(nonatomic,strong) UIColor                     *dotColor;
@property(nonatomic,strong) UIColor                     *lightedDotColor;

@end

@implementation GZAnimationIndicator

- (instancetype)initWithFrame:(CGRect)frame
                  circleColor:(UIColor *)circleColor
                     dotColor:(UIColor *)dotColor
              lightedDotColor:(UIColor *)lightedDotColor {
    
    if(self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor grayColor];
        self.circleColor = circleColor;
        self.dotColor = dotColor;
        self.lightedDotColor = lightedDotColor;
        
        [self createLayer];
        [self createDotLayers];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0/12 target:self selector:@selector(changeColorOfDotLayer) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)changeColorOfDotLayer {
    
    if(self.index == 12) {
        self.index = 0;
        
        for(CALayer *layer in self.dotLayers){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                layer.backgroundColor = self.dotColor.CGColor;
            });
        }
    }
    CALayer *layer = [self.dotLayers objectAtIndex:self.index];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        layer.backgroundColor = self.lightedDotColor.CGColor;
    });
    self.index = self.index + 1;
}

- (void)createLayer {
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.width/3 startAngle:-M_PI_2 endAngle:(M_PI*2-M_PI_2) clockwise:YES];
    
    [self.shapeLayer setStrokeColor:self.circleColor.CGColor];
    [self.shapeLayer setFillColor:[UIColor clearColor].CGColor];
    self.shapeLayer.lineWidth = 3.0f;
    self.shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    
    //create GradientLayer
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
/*
    NSMutableArray *colors = [NSMutableArray array];
    for(float i=10.0;i>0.0;i--) {
        UIColor *cyan = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.1*i];
        [colors addObject:(id)[cyan CGColor]];
    }
    self.gradientLayer.colors = colors;
*/
    [self.gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[[UIColor redColor] CGColor],
                                   (id)[[UIColor greenColor] CGColor],
                                   (id)[[UIColor blueColor] CGColor],
                                   (id)[[UIColor redColor] CGColor],
                                   nil]];
    [self.gradientLayer setLocations:@[@0.3,@0.5,@0.7,@1]];
    self.gradientLayer.mask = self.shapeLayer;
    self.gradientLayer.startPoint = CGPointMake(0, 0);//开始点
    self.gradientLayer.endPoint = CGPointMake(1, 0);//结束点
    [self.layer addSublayer:self.gradientLayer];
    
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = 0.0f;
    [self.shapeLayer addAnimation:self.strokeEndAnimation forKey:@"strokeEnd"];
}

- (void)createDotLayers {
    
    double unit = M_PI*2/12;
    
    _dotLayers = [NSMutableArray array];
    for(int i=0;i<12;i++) {
        
        double arch = unit*i;
        
        CGPoint circleCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        CGFloat radius = self.bounds.size.width/3+20;
        CALayer *dotLayer = [CALayer layer];
        dotLayer.frame = CGRectMake( 0, 0, 10, 10);
        dotLayer.position = CGPointMake(radius*sin(arch)+circleCenter.x, circleCenter.y-radius*cos(arch));
        dotLayer.cornerRadius = dotLayer.frame.size.width/2;
        dotLayer.masksToBounds = YES;
        dotLayer.backgroundColor = self.dotColor.CGColor;
        [self.layer addSublayer:dotLayer];
        
        [self.dotLayers addObject:dotLayer];
    }
}


- (CABasicAnimation *)strokeEndAnimation {
    
    if(!_strokeEndAnimation) {
        _strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        _strokeEndAnimation.fromValue = @0;
        _strokeEndAnimation.toValue = @1;
        _strokeEndAnimation.duration = 2.0;
        _strokeEndAnimation.beginTime = CACurrentMediaTime() + 2.0/12;
        _strokeEndAnimation.repeatCount = HUGE;
        _strokeEndAnimation.removedOnCompletion = YES;
    }
    return _strokeEndAnimation;
}

@end

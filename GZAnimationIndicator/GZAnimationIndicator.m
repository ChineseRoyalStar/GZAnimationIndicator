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
@property(nonatomic,strong) NSMutableArray<UIView *>    *dotViews;
@property(nonatomic,assign) NSUInteger                   index;

@end

@implementation GZAnimationIndicator

- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor grayColor];
        
        [self createLayer];
        
        [self createDotViews];
        
        //[self changeColorOfDotview];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0/12 target:self selector:@selector(changeColorOfDotview) userInfo:nil repeats:YES];
    }
    return self;
}


- (void)changeColorOfDotview {
    
    if(self.index == 12) {
        self.index = 0;
        
        for(UIView *view in self.dotViews){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                view.backgroundColor = [UIColor redColor];
            });
        }
    }
    UIView *view = [self.dotViews objectAtIndex:self.index];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        view.backgroundColor = [UIColor cyanColor];
    });
    self.index = self.index + 1;
    
}

- (void)createLayer {
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.bounds.size.width/2-50 startAngle:-M_PI_2 endAngle:(M_PI*2-M_PI_2) clockwise:YES];
    
    [self.shapeLayer setStrokeColor:[UIColor cyanColor].CGColor];
    [self.shapeLayer setFillColor:[UIColor clearColor].CGColor];
    self.shapeLayer.lineWidth = 3.0f;
    self.shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    
    //create GradientLayer
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    
    NSMutableArray *colors = [NSMutableArray array];
    for(float i=10.0;i>0.0;i--) {
        
        UIColor *cyan = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.1*i];
        [colors addObject:(id)[cyan CGColor]];
    }
    
    self.gradientLayer.colors = colors;
    self.gradientLayer.mask = self.shapeLayer;
    self.gradientLayer.startPoint = CGPointMake(0, 0);//开始点
    self.gradientLayer.endPoint = CGPointMake(1, 0);//结束点
    [self.layer addSublayer:self.gradientLayer];
    
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = 0.0f;
    
    [self.shapeLayer addAnimation:self.strokeEndAnimation forKey:@"strokeEnd"];
    
}


- (void)createDotViews {
    
    double unit = M_PI*2/12;
    
    _dotViews = [NSMutableArray array];
    for(int i=0;i<12;i++) {
        
        double arch = unit*i;
        
        CGPoint circleCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        CGFloat radius = self.bounds.size.width/2-30;
        
        UIView *dot = [[UIView alloc]initWithFrame:CGRectMake(radius*sin(arch)+circleCenter.x, circleCenter.y-radius*cos(arch), 10, 10)];
        
        dot.layer.cornerRadius = dot.bounds.size.width/2;
        dot.layer.masksToBounds = YES;
        dot.backgroundColor = [UIColor redColor];
       
        [self.dotViews addObject:dot];
        [self addSubview:dot];
    }
}


- (CABasicAnimation *)strokeEndAnimation {
    
    if(!_strokeEndAnimation) {
        _strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
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

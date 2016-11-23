//
//  ViewController.m
//  GZAnimationIndicator
//
//  Created by armada on 2016/11/17.
//  Copyright © 2016年 com.zlot.gz. All rights reserved.
//

#import "ViewController.h"
#import "GZAnimationIndicator.h"

@interface ViewController ()

@property(nonatomic,strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GZAnimationIndicator *indicator = [[GZAnimationIndicator alloc]initWithFrame:CGRectMake(0, 0, 300, 300) circleColor:[UIColor redColor] dotColor:[UIColor yellowColor] lightedDotColor:[UIColor cyanColor]];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

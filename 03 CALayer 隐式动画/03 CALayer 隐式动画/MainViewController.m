//
//  MainViewController.m
//  03 CALayer 隐式动画
//
//  Created by Seven on 15/5/13.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MainViewController ()
@property(weak,nonatomic)CALayer *mylayer;
@property(strong,nonatomic) NSArray *colorArray;
@property(strong,nonatomic) NSArray *imageArray;
@end

@implementation MainViewController
/*
 *触摸屏幕开始动画
 *
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例化自定义图层
    CALayer *myLayer = [CALayer layer];
    //设置大小
    [myLayer setBounds:CGRectMake(0, 0, 100, 100)];
    //设置背景颜色
    [myLayer setBackgroundColor:[UIColor redColor].CGColor];
    [myLayer setPosition:CGPointMake(50, 50)];
    
    [self.view.layer addSublayer:myLayer];
    self.mylayer = myLayer;
    
    //2.定义数据
    self.colorArray = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    UIImage *iamge1 = [UIImage imageNamed:@"1.JPG"];
    UIImage *iamge2 = [UIImage imageNamed:@"2.JPG"];
    self.imageArray = @[iamge1,iamge2];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    //关闭动画
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    [CATransaction commit];
    //位置
    [self.mylayer setPosition:location];
    //颜色
    NSInteger r1 = arc4random_uniform(self.colorArray.count);
    [self.mylayer setBackgroundColor:[self.colorArray[r1] CGColor]];
    //透明度
    CGFloat alpha = (arc4random_uniform(5) + 1.0) / 10.0 + 0.5;
    [self.mylayer setOpacity:alpha];
    //尺寸
    NSInteger size = arc4random_uniform(50) + 51;
    [self.mylayer setBounds:CGRectMake(0, 0, size, size)];
    //圆角
    NSInteger r2 = arc4random_uniform(30);
    [self.mylayer setCornerRadius:r2];
    //旋转角度
    CGFloat angle = arc4random_uniform(180) /180.0 * M_PI;
    [self.mylayer setTransform:CATransform3DMakeRotation(angle, 0, 0, 1)];
    //设置content
    NSInteger r3 = arc4random_uniform(self.imageArray.count);
    UIImage *image = self.imageArray[r3];
    [self.mylayer setContents:(id)image.CGImage];
}
@end

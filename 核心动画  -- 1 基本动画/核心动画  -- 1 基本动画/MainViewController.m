//
//  MainViewController.m
//  核心动画  -- 1 基本动画
//
//  Created by Seven on 15/5/20.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MainViewController ()

@property(weak,nonatomic)UIView *myView;

@end

@implementation MainViewController
/*
    自定义一个视图，监听手势操作，在手势触摸屏幕时，差生动画效果。
    1.缩放
    2.旋转
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    [myView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:myView];
    self.myView = myView;
}
#pragma mark - 触摸监听方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self scaleAnimation];
    //判断myview是否旋转  如果已经旋转  就停止
    CAAnimation * anim = [self.myView.layer animationForKey:@"rotationAnim"];
    NSLog(@"%@",anim);
    if (anim) {
        //停止动画
        [self.myView.layer removeAllAnimations];

    }else{
        [self rotatopnAnimation];
    }
    
}
#pragma mark - 动画方法
#pragma mark 旋转动画
- (void)rotatopnAnimation
{
    //1.实例化基本动画
    //默认按照Z轴旋转
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [self.myView.layer setAnchorPoint:CGPointMake(1, 0.5)];
    //2.设置基本属性
    //旋转一周2pi
    [anim setToValue:@(2 * M_PI)];
    //HUGE_VALF  一个非常大的浮点数值，认为无线循环
    [anim setRepeatCount:HUGE_VALF];
    //动画时长
    [anim setDuration:0.5f];
    //3.将动画添加到图层
    //key可以随意指定 ， 判断图层中是否存在该动画
    [self.myView.layer addAnimation:anim forKey:@"rotationAnim"];

}
#pragma mark 动画的暂停和继续
- (void)pauseAnimation
{
    //1.取出当前的动画时间点
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定个在时间点

    //3.将动画的运行速度设置为0.默认为  1.0
    
    
}
#pragma mark 缩放
- (void)scaleAnimation
{
    //1.实例化基本动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //2.设置基本属性
    //fromValue   toValue
    //从当前大小缩小到一半  然后恢复初始大小
    [anim setFromValue:@(1.0)];
    [anim setToValue:@(0.5)];
    [anim setAutoreverses:YES];
    //动画时长
    [anim setDuration:0.5f];
    //3.将动画添加到图层
    [self.myView.layer addAnimation:anim forKey:nil];
}

@end

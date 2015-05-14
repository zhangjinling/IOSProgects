//
//  MainViewController.m
//  05 CALayer自定义图层-代理
//
//  Created by Seven on 15/5/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例化子图层
    CALayer *myLayer = [CALayer layer];
    //设置大小位置
    [myLayer setBounds:CGRectMake(0, 0, 200, 200)];
    [myLayer setBackgroundColor:[UIColor redColor].CGColor];
    [myLayer setPosition:CGPointMake(100, 100)];
    [self.view.layer addSublayer:myLayer];
    [myLayer setDelegate:self];
    //如果要重绘CALayer必须要调用setNeedDisplay方法
    [myLayer setNeedsDisplay];
    NSLog(@"%@",myLayer);
}
/*
 使用delegate的方式 绘制图层的方法相对简单
 但是 因为不能将layer的delagate设置为view，因此通常使用controller为代理，
 而用controller使用代理 ， 当controller的工作比较复杂时 此方法的可维护性不好。
 */
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"%@",layer);
    //在core animation 中，不能使用ui的方法，UI的方法仅适用于ios开发平台。
    //画一个蓝色矩形
//    [[UIColor blackColor]set];
    CGRect rect = CGRectMake(50, 50, 100, 100);
    
    CGContextSetRGBFillColor(ctx, 0.0, 0.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(ctx, 0.0, 1.0, 1.0, 1.0);
    CGContextAddRect(ctx, rect);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
//    UIRectFill(rect);
}

@end

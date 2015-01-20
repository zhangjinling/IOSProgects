//
//  ViewController.m
//  05.摇晃事件
//
//  Created by Seven on 15/1/20.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/*
1.在视图出现在屏幕时，让视图变成第一响应者
2.当视图离开屏幕，应用关闭或者切换到其他视图时，注销视图的第一响应者身份。
3.监听摇晃事件
 */
- (void)viewDidAppear:(BOOL)animated
{
    [self.view becomeFirstResponder];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.view resignFirstResponder];
}
#pragma mark - 监听运动事件
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (UIEventSubtypeMotionShake == motion) {
        NSLog(@"shake");
        //摇晃的后续处理
        /*
         记录用户位置
         去服务器查找当前摇晃手机的用户记录
         根据经纬度or Other选择n名用户
         数据返回给手机
         手机接收到数据  [self.tableview reloadData];
         */
    }
}
@end

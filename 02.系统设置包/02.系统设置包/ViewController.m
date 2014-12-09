//
//  ViewController.m
//  02.系统设置包
//
//  Created by Seven on 14/12/9.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)valueChanged
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    //键值对应的字符串就是root.plist对应的identifier
        NSString *str = [defaults stringForKey:@"name_preference"];
    //    //设置文本框的值
        [self.nameText setText:str];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1、观察者：NSNotificationCenter 系统默认的通知中心
    //2、通知对象：self
    //3、执行方法：valueChanged
    //4、观察的对象：系统偏好的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(valueChanged) name:NSUserDefaultsDidChangeNotification object:nil];
    
//	//显示用户在设置中输入的文本
//    //1.读取【系统偏好】读取设置中的内容和系统偏好一致
//
//    
}
- (void)viewDidAppear:(BOOL)animated
{
    //在多视图控制器之间来回切换，出现在屏幕时，才会执行，通常很少重写此方法
    //性能略差。如果应用程序已经运行，用户点击图标进入系统此方法不执行。
}

@end

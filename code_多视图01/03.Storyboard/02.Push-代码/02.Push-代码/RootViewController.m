//
//  RootViewController.m
//  02.Push-代码
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "RootViewController.h"
#import "NextViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 设置标题
//    [self.navigationItem setTitle:@"第一个"];
    [self setTitle:@"第一个???"];
    
    // 2. 返回按钮，是懒加载的
    NSLog(@"%@", self.navigationItem.backBarButtonItem);
//    [self.navigationItem.backBarButtonItem setTitle:@"aaa"];
    // 提示：target和action设置为空，系统会使用默认操作
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // 3. 左侧和右侧的按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    // 4. 跟踪子视图控制器
    NSLog(@"%@ %@", self.navigationController, self.parentViewController);
    NSLog(@"%@", self.navigationController.childViewControllers);
}

#pragma mark - Push NextViewController
- (IBAction)next
{
    // 1. 实例化Next
    NextViewController *next = [[NextViewController alloc]init];
    
    // 2. 用NavgationController Push
    [self.navigationController pushViewController:next animated:YES];
}

@end

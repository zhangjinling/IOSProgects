//
//  Test1ViewController.m
//  weibo02
//
//  Created by Seven on 15/6/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"
@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    Test2ViewController *test2 = [[Test2ViewController alloc]init];
    test2.title = @"test2测试控制器";
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:test2 animated:YES];
}

@end

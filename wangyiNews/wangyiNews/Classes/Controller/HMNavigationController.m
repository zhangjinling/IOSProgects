//
//  HMNavigationController.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMNavigationController.h"

@interface HMNavigationController ()

@end

@implementation HMNavigationController

+ (void)initialize
{
    UINavigationBar *appeaance = [UINavigationBar appearance];
    //设置导航栏的背景
    [appeaance setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}

@end

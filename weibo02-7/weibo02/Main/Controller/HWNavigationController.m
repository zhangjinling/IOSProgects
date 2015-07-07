//
//  HWNavigationController.m
//  weibo02
//
//  Created by Seven on 15/6/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWNavigationController.h"
@interface HWNavigationController ()

@end

@implementation HWNavigationController

+ (void)initialize
{
    //设置这个项目所有的item主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置普通状态
    //key都是Ns****attributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0f];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disabletextAttrs = [NSMutableDictionary dictionary];
    disabletextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
    disabletextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13.0f];
    [item setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];

    }
    [super pushViewController:viewController animated:animated];

}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end

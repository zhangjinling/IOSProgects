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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        //设置图片
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        //设置尺寸
        backBtn.size = backBtn.currentBackgroundImage.size;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        
        
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        
        //设置图片
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [moreBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        //设置尺寸
        moreBtn.size = backBtn.currentBackgroundImage.size;
        
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:moreBtn];

    }
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

//
//  HMMainViewController.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMMainViewController.h"
#import "HWLeftMenu.h"
#import "HMNavigationController.h"
#import "HMNewsViewController.h"

@interface HMMainViewController ()

@end

@implementation HMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加左侧的菜单
    HWLeftMenu *leftMenu = [[HWLeftMenu alloc]init];
    leftMenu.x = 0;
    leftMenu.y = 60;
    leftMenu.width = 200;
    leftMenu.height = 300;
//    leftMenu.backgroundColor = HWRandomColor;
    [self.view addSubview:leftMenu];
    
    //2.创建子控制器
    HMNewsViewController *news = [[HMNewsViewController alloc]init];
    news.view.backgroundColor = HWRandomColor;
    HMNavigationController *newsNav = [[HMNavigationController alloc]initWithRootViewController:news];

    //    news.view.frame = self.view.frame;
    newsNav.view.frame = self.view.frame;
    //不让他navNews销毁
    [self.view addSubview:newsNav.view];
    [self addChildViewController:newsNav];
}


/**
 *  修改statusbar的颜色
 *
 *  @return 返回高亮颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end

//
//  HMNavigationController.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMNavigationController.h"
#import "HMNavigationBar.h"
@interface HMNavigationController ()

@end

@implementation HMNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setValue:[[HMNavigationBar alloc]init] forKey:@"navigationBar"];
}
+ (void)initialize
{
    UINavigationBar *appeaance = [UINavigationBar appearance];
    //设置导航栏的背景
    [appeaance setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    for (UIButton *btn in self.navigationBar.subviews) {
//        if (![btn isKindOfClass:[UIButton class]]) {
//            continue;
//        }
//        if (btn.centerX < self.view.width * 0.5) {//左边按钮
//            btn.x = 0;
//        }else if (btn.centerX > self.view.width * 0.5){//右边按钮
//            btn.x = self.view.width - btn.width;
//        }
//    }
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    for (UIButton *btn in self.navigationBar.subviews) {
//        if (![btn isKindOfClass:[UIButton class]]) continue;
//        
//        if (btn.centerX < self.view.width * 0.5) {//左边按钮
//            btn.x = 0;
//        }else if (btn.centerX > self.view.width * 0.5){//右边按钮
//            btn.x = self.view.width - btn.width;
//        }
//    }

}
@end

//
//  FirstViewController.m
//  02.Tabbar-XIB1
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 在选项卡应用中 self.parentViewController = self.tabBarController
    // 可以根据self.tabBarItem设置其中的属性
    
    NSLog(@"%@ %@", self.parentViewController, self.tabBarController);
    NSLog(@"%@", self.tabBarController.viewControllers);

    // 遍历tabbar的所有子视图控制器，根据对应的视图控制器去设置
    for (UIViewController *controller in self.tabBarController.viewControllers) {
        // 判断是否是第二个视图控制器
        if ([controller isKindOfClass:[SecondViewController class]]) {
            [controller.view setBackgroundColor:[UIColor greenColor]];
        } else if ([controller isKindOfClass:[ThirdViewController class]]) {
            [controller.view setBackgroundColor:[UIColor redColor]];
        }
    }
//    
//    SecondViewController *second = self.tabBarController.viewControllers.lastObject;
//    [second.view setBackgroundColor:[UIColor greenColor]];
    
    [self.tabBarItem setTitle:@"第一项"];
    [self.tabBarItem setBadgeValue:@"10"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"tab1.png"]];
    
}

@end

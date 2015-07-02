//
//  AppDelegate.m
//  weibo02
//
//  Created by Seven on 15/6/16.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.设置跟控制器
    TabBarViewController *tabbarVc = [[TabBarViewController alloc]init];
    self.window.rootViewController = tabbarVc;
    
        //4.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    vc1.tabBarItem.title = @"首页";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
//    UIImage *homeSelectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
//    //声明这张图片按照原始的图片显示，不要自动渲染成其他颜色（例如蓝色）
//    vc1.tabBarItem.selectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //设置文字的样式
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
//    //选中字体的颜色
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//

//    [vc1.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    [vc1.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    vc1.view.backgroundColor = HWRandomColor;
//
//
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.tabBarItem.title = @"消息";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//    vc2.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    [vc2.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    [vc2.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    vc2.view.backgroundColor = HWRandomColor;
//
//    UIViewController *vc3 = [[UIViewController alloc]init];
//    vc3.tabBarItem.title = @"发现";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//    vc3.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [vc3.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    [vc3.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    vc3.view.backgroundColor = HWRandomColor;
//
//    UIViewController *vc4 = [[UIViewController alloc]init];
//    vc4.tabBarItem.title = @"我";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
//    vc4.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//    [vc4.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    [vc4.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    vc4.view.backgroundColor = HWRandomColor;
//

@end

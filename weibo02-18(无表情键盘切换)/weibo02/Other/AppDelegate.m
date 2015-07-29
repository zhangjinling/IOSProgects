//
//  AppDelegate.m
//  weibo02
//
//  Created by Seven on 15/6/16.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "AppDelegate.h"
#import "HWOAuthViewController.h"
#import "HWAccountTool.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //2.显示窗口
    [self.window makeKeyAndVisible];

    //3.设置跟控制器
//    self.window.rootViewController = [[HWOAuthViewController alloc]init];

    //获取account 登录信息
    HWAccount *account = [HWAccountTool account];
    if (account) {
        //切换控制器
        [self.window switchRootViewController];
    }else{
        //没有登录过
        self.window.rootViewController = [[HWOAuthViewController alloc]init];
    }

//    NSString *key = @"CFBundleVersion";
//    //存取在沙盒中上一次的版本号
//    //有可能为空   第一次进入
//     NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//    //获得软件当前的版本号info.plist中获得
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
//    //将版本号存入沙盒
//    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//    //内存中的数据马上同步到沙盒
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    //判断是否为新版本
//    if([currentVersion isEqualToString:lastVersion]){//这次打开的版本号相同
//        self.window.rootViewController = [[TabBarViewController alloc]init];
//    }else{//显示新特性
//        self.window.rootViewController = [[HWNewFeatureViewController alloc]init];
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }

    
        return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  当app进入后台
 *
 *  @param application <#application description#>
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    /**
     *  app状态：
        1.死亡状态，没有打开app
        2.前天运行 
        3.后台暂停状态  停止一切动画，多媒体，联网操作
        4.后台运行状态
     */
    //向操作系统申请后台运行资格，能为之多久不确定
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时过期时， 就会调用这个block
        [application endBackgroundTask:task];
    }];
    
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
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //1.取消下载
    [mgr cancelAll];
    //2.清楚内存下载的图片
    [mgr.imageCache clearMemory];
}
@end

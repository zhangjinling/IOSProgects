//
//  UIWindow+Extension.m
//  weibo02
//
//  Created by Seven on 15/7/6.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HWNewFeatureViewController.h"
#import "TabBarViewController.h"
@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    //说明之前已经登录过
    NSString *key = @"CFBundleVersion";
    //存取在沙盒中上一次的版本号
    //有可能为空   第一次进入
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //获得软件当前的版本号info.plist中获得
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //        //将版本号存入沙盒
    //        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    //        //内存中的数据马上同步到沙盒
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //判断是否为新版本
    if([currentVersion isEqualToString:lastVersion]){//这次打开的版本号相同
        self.rootViewController = [[TabBarViewController alloc]init];
    }else{//显示新特性
        self.rootViewController = [[HWNewFeatureViewController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
@end

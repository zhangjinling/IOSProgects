//
//  TabBarViewController.m
//  weibo02
//
//  Created by Seven on 15/6/17.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageCenterViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "HWNavigationController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.初始化子控制器
    //3.设置子控制器
    HomeViewController *home = [[HomeViewController alloc]init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectImage:@"tabbar_home_selected"];
    MessageCenterViewController *messageCenter = [[MessageCenterViewController alloc]init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_selected"];
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectImage:@"tabbar_discover_selected"];
    ProfileViewController *profile = [[ProfileViewController alloc]init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectImage:@"tabbar_profile_selected"];
    
    //    tabbarVc.viewControllers = @[vc1,vc2,vc3,vc4];
//    [tabbarVc addChildViewController:home];
//    [tabbarVc addChildViewController:messageCenter];
//    [tabbarVc addChildViewController:discover];
//    [tabbarVc addChildViewController:profile];
    //很多重复代码 -----》将重复代码抽取到一个方法中
    //1.相同的代码放到一个方法中
    //2.不同的方法 变成参数
    //3.在使用这个代码的地方 调用代码  传递参数


}

#pragma mark 添加一个子控制器
-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
//    childVc.tabBarItem.title = title;//设置tabbar的文字
//    childVc.navigationItem.title = title;//设置navigationbar的文字
    childVc.title = title;//同时设置tabbar和navigationbar的文字，等同于上面两句
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *homeSelectedImage = [UIImage imageNamed:selectImage];
    //声明这张图片按照原始的图片显示，不要自动渲染成其他颜色（例如蓝色）
    childVc.tabBarItem.selectedImage = [homeSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    //选中字体的颜色
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    childVc.view.backgroundColor = HWRandomColor;
    //先给外面的自控制器 包装一个navcontroller
    HWNavigationController *nav = [[HWNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav
     ];
}


@end

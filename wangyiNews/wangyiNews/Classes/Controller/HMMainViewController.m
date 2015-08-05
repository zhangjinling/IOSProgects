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
#import "HMReadingViewController.h"
#import "HMTitleView.h"

#define HMNavShowAnimDuration 0.2
#define HMCorverTag 100
@interface HMMainViewController ()<HWLeftMenuDelegate>
/** 正在显示的导航控制器 */
@property (nonatomic, weak)HMNavigationController *showingNavigationController;
@end

@implementation HMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.创建子控制器
    //2.1 创建新闻控制器
    HMNewsViewController *news = [[HMNewsViewController alloc]init];
    [self setupVc:news title:@"新闻"];
    //2.2订阅的控制器
    HMReadingViewController *reading = [[HMReadingViewController alloc]init];
    [self setupVc:reading title:@"订阅"];
    
    

    
    
    //1.添加左侧的菜单
    HWLeftMenu *leftMenu = [[HWLeftMenu alloc]init];
    leftMenu.delegate = self;
    leftMenu.x = 0;
    leftMenu.y = 60;
    leftMenu.width = 200;
    leftMenu.height = 300;
//    leftMenu.backgroundColor = HWRandomColor;
    [self.view insertSubview:leftMenu atIndex:1];
    
}
/**
 *  初始化子控制器
 */
- (void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    //1.设置背景色
    vc.view.backgroundColor = HWRandomColor;
    //2.标题
    HMTitleView *titleView = [[HMTitleView alloc]init];
    titleView.title = title;
    vc.navigationItem.titleView =titleView ;
    //3.设置左右按钮
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftMenu) image:@"top_navigation_menuicon"];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightMenu) image:@"top_navigation_infoicon"];
    HMNavigationController *nav = [[HMNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}
#pragma mark - 导航栏左右按钮点击
- (void)leftMenu
{
    NSLog(@"leftmenu");
    //控制器缩放
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        //取出当前正在显示的导航控制器的view
        UIView *shwoingView = self.showingNavigationController.view;

        if (CGAffineTransformIsIdentity(shwoingView.transform)) {
            //缩放比例
            CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * 60;
            CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
            //菜单左边距
            CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) *0.5;
            CGFloat translateX = 200 - leftMenuMargin;
            CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
            CGFloat translateY = topMargin - 60;
            
            //缩放
            CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
            //平移
            CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, -translateY / scale);
            
            shwoingView.transform = translateForm;
            
            //添加一个遮盖
            UIButton *corver = [[UIButton alloc]init];
            corver.tag = HMCorverTag;
            [corver addTarget:self action:@selector(corverClick:) forControlEvents:UIControlEventTouchUpInside];
            corver.frame = shwoingView.bounds;
            [shwoingView addSubview:corver];
            
        }else{
            shwoingView.transform = CGAffineTransformIdentity;
            
        }
    }];
}
- (void)corverClick:(UIView *)corver
{
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        self.showingNavigationController.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [corver removeFromSuperview];
    }];
    
}

- (void)rightMenu
{
    NSLog(@"rightMenu");
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
#pragma mark - HWLeftMenuDelegate
- (void)leftMenu:(HWLeftMenu *)menu didSelectButtonFromIndex:(int)index toIndex:(int)toIndex
{
    //0.移除当前正在显示的控制器
    HMNavigationController *oldNav = self.childViewControllers[index];
    [oldNav.view removeFromSuperview];
    //1.显示即将要显示的导航控制器
    HMNavigationController *newNav = self.childViewControllers[toIndex];
    [self.view addSubview:newNav.view];

    newNav.view.transform = oldNav.view.transform;
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-10, 0);
    newNav.view.layer.shadowOpacity = 0.2;
    //2.记录当前正在显示的控制器
    self.showingNavigationController = newNav;
//    [UIView animateWithDuration:0.3f animations:^{
//        newNav.view.transform = CGAffineTransformIdentity;
//    }];
//    //3.清除当前正在显示的控制器上的遮盖
//    [[newNav.view viewWithTag:HMCorverTag] removeFromSuperview];
    [self corverClick:[newNav.view viewWithTag:HMCorverTag]];
}

@end

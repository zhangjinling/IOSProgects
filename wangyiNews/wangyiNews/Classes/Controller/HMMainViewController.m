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
#import "HMRightMenuController.h"

#define HMNavShowAnimDuration 0.2
#define HMCorverTag 100
#define HWLeftMenuW 200
#define HWLeftMenuH 300
#define HWLeftMenuY 50

@interface HMMainViewController ()<HWLeftMenuDelegate>
/** 正在显示的导航控制器 */
@property (nonatomic, weak)HMNavigationController *showingNavigationController;
/** 左侧菜单 */
@property (nonatomic, weak)UIView *leftMenuView;
/** 右侧控制器 */
@property (nonatomic, strong) HMRightMenuController *rightVc;
@end

@implementation HMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildVc];
    //leftMenu
    [self setupLeftMenu];
    //rightMenu
    [self setupRightMenu];
}
/**
 *  添加所有的控制器
 */
- (void)setupAllChildVc
{
    //2.创建子控制器
    //2.1 创建新闻控制器
    HMNewsViewController *news = [[HMNewsViewController alloc]init];
    [self setupVc:news title:@"新闻"];
    //2.2订阅的控制器
    HMReadingViewController *reading = [[HMReadingViewController alloc]init];
    [self setupVc:reading title:@"订阅"];
}
/**
 *  初始化右侧菜单
 */
- (void)setupRightMenu
{
    HMRightMenuController *rightMenuVc = [[HMRightMenuController alloc]init];
    rightMenuVc.view.x = self.view.width - rightMenuVc.view.width;
    
    [self.view insertSubview:rightMenuVc.view atIndex:1];

    self.rightVc = rightMenuVc;
}
/**
 *  添加左侧菜单
 */
- (void)setupLeftMenu
{
    //1.添加左侧的菜单
    HWLeftMenu *leftMenu = [[HWLeftMenu alloc]init];
    leftMenu.delegate = self;
    leftMenu.x = 0;
    leftMenu.y = HWLeftMenuY;
    leftMenu.width = HWLeftMenuW;
    leftMenu.height = HWLeftMenuH;
    //    leftMenu.backgroundColor = HWRandomColor;
    [self.view insertSubview:leftMenu atIndex:1];
    self.leftMenuView = leftMenu;

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
    self.leftMenuView.hidden = NO;
    self.rightVc.view.hidden = YES;
    NSLog(@"leftmenu");
    //控制器缩放
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        //取出当前正在显示的导航控制器的view
        UIView *shwoingView = self.showingNavigationController.view;

        if (CGAffineTransformIsIdentity(shwoingView.transform)) {
            //缩放比例
            CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * HWLeftMenuY;
            CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
            //菜单左边距
            CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) *0.5;
            CGFloat translateX = HWLeftMenuW - leftMenuMargin;
            CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
            CGFloat translateY = topMargin - HWLeftMenuY;
            
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
    self.leftMenuView.hidden = YES;
    self.rightVc.view.hidden = NO;
    NSLog(@"rightMenu");
    //控制器缩放
    [UIView animateWithDuration:HMNavShowAnimDuration animations:^{
        //取出当前正在显示的导航控制器的view
        UIView *shwoingView = self.showingNavigationController.view;
        
        if (CGAffineTransformIsIdentity(shwoingView.transform)) {
            //缩放比例
            CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * HWLeftMenuY;
            CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
            //菜单左边距
            CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) *0.5;
            CGFloat translateX = self.rightVc.view.width - leftMenuMargin;
            CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
            CGFloat translateY = topMargin - HWLeftMenuY;
            
            //缩放
            CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
            //平移
            CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, -translateX / scale, -translateY / scale);
            
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
    }completion:^(BOOL finished) {
        [self.rightVc didShow];
    }];

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

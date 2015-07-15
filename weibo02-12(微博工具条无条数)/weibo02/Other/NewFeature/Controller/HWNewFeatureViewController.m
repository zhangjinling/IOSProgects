//
//  HWNewFeatureViewController.m
//  weibo02
//
//  Created by Seven on 15/7/2.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWNewFeatureViewController.h"
#import "TabBarViewController.h"
#define HWNewfeatureCount 4
@interface HWNewFeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic , strong)UIPageControl *pageControl;
@end

@implementation HWNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建scrollView，显示新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [scrollView setFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    //2.添加图片到scrollView
    CGFloat scrollWidth = scrollView.width;
    CGFloat scrollHeight = scrollView.height;
    for (int i = 0; i < HWNewfeatureCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollWidth;
        imageView.height = scrollHeight;
        imageView.y = 0;
        imageView.x = i * scrollWidth;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        [scrollView addSubview:imageView];
        //如果是最后一个imageView 就添加按钮，选择框
        if(i == HWNewfeatureCount - 1){
            [self setupLastImageView:imageView];
        }
    }
    //3.设置scrollView的其他属性
    //如果某个方向上的不让滚动就传入0；
    scrollView.contentSize = CGSizeMake(HWNewfeatureCount * scrollView.width, 0);
    scrollView.bounces = NO;//去除弹簧效果
    scrollView.pagingEnabled = YES;//分页
    scrollView.showsHorizontalScrollIndicator = NO;//水平滚动条
    scrollView.delegate = self;
    
    //pageControl 分页展示当前的第几页
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = HWNewfeatureCount;
    pageControl.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = HWColor(189, 189, 189);
    //UIPageControl没有宽高里面内容也能显示
//    pageControl.userInteractionEnabled = NO;
//    pageControl.width = 100;
//    pageControl.height = 50;
    pageControl.centerX = scrollWidth * 0.5;
    pageControl.centerY = scrollHeight - 70;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];

}
#pragma mark - 初始化最后一个imageView
- (void)setupLastImageView:(UIImageView *)imageView
{
    //imageView开启交互
    imageView.userInteractionEnabled = YES;
    //1.分享给大家
    UIButton *shareButton = [[UIButton alloc]init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [shareButton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.width = 280;
    shareButton.height = 30;
    shareButton.centerX = imageView.width * 0.5;
    shareButton.centerY = imageView.height * 0.65;
    
//    [shareButton setBackgroundColor:[UIColor redColor]];
//    [shareButton.imageView setBackgroundColor:[UIColor yellowColor]];
//    [shareButton.titleLabel setBackgroundColor:[UIColor blueColor]];
//    [shareButton setContentEdgeInsets:UIEdgeInsetsMake(20, 100, 0, 10)];
    [shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
//:控件看不见的可能
    /*
     1.没有创建
     2.没有设置尺寸
     3.控件的颜色与背景色一样
     4.透明多alpha ==0
     5.hidden==yes
     6.没有addSubview
     7.被其他控件挡住
     8.x、y坐标值错误
     9.可能是父控件存在问题（存在以上情况）
     10.特殊情况：imageView没有设置图片不是显示。或者图片名称不对
     11.uiLabel没有设置文字。或者颜色和背景一样
     12.UIPageControl 没有设置总数
     13.textfield  没有设置边框  看不见
     添加控件的建议：
        1.设置控件的背景色和尺寸
        2.控件的背景色和父控件不一样
        3.
     */
    
    [imageView addSubview:shareButton];
    
    //2.开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareButton.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    double page = scrollView.contentOffset.x / scrollView.width;
    NSLog(@"%f",page);
    self.pageControl.currentPage = (int)(page+0.5) ;
}
- (void)startClick
{
    //切换到TabbarController
    /*
     1.push  //依赖于naviagtion   push操作可逆可返回
     2.modal
     3.切换window的roowViewController
     
     */
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[TabBarViewController alloc]init];
}
- (void)shareClick:(UIButton *)shareButton
{
    //状态取反
    [shareButton setSelected:!shareButton.isSelected];
}


@end

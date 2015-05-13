//
//  MainViewController.m
//  02 CALayer的基本使用 自定义图层
//
//  Created by Seven on 15/5/12.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainViewController()

@property(weak,nonatomic)CALayer *myLayer;

@end


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.自定义图层
    CALayer *myLayer = [CALayer layer];
    
    //将自定义图层添加到跟图层之上
    [self.view.layer addSublayer:myLayer];
    self.myLayer = myLayer;
    //2.设置属性
    //2.1设置大小
    [myLayer setBounds:CGRectMake(0, 0, 200, 200)];
    //2.2设置背景颜色
    [myLayer setBackgroundColor:[UIColor redColor].CGColor];
    //2.3设置中心点   (默认对应的是类似uiview的中心点,所以显示四分之一)相对于父图层的位置
    [myLayer setPosition:CGPointMake(0, 0)];
    //2.4设置内容
    UIImage *image = [UIImage imageNamed:@"1.JPG"];
    //在指定cgimageRef时需要强行转换为id类型
    [myLayer setContents:(id)image.CGImage];
    //2.5锚点 或者定位点（x、y的范围都是 0~1），决定了position的含义
    //默认值为0.5--0.5
    //锚点的作用:主要控制图层的位置和旋转的轴,锚点（0，0）为左上角，（1，1）为右下角
    //position  是不变的，是相对于父图层的  锚点相对于当前图层的比例  ， 利用锚点的移动不需要知道图层的大小
    [myLayer setAnchorPoint:CGPointMake(1,1)];
    [myLayer setTransform:CATransform3DMakeRotation(M_PI, 0, 0, 1)];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.myLayer.anchorPoint.x == 0) {
        self.myLayer.anchorPoint = CGPointMake(1, 1);
    }else{
        self.myLayer.anchorPoint = CGPointMake(0, 0);
    }

}
@end

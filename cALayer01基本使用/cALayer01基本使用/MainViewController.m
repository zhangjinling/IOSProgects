//
//  MainViewController.m
//  cALayer01基本使用
//
//  Created by Seven on 15/5/10.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

/*
    如果使用clayer  必须导入QuartzCore框架 并在.m文件中导入该框架的头文件
 
 */


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self myUIimageLayerDemo];
//    [self myViewLayerDemo];
}
#pragma mark  - UIImageView 的demo
- (void)myUIimageLayerDemo
{
    UIImage *image = [UIImage imageNamed:@"1.JPG"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];

    [imageView setFrame:CGRectMake(50, 50, 200, 200)];
    
    [self.view addSubview:imageView];
    
    //1.圆角半径
    //提示imageview中 图层不止一个 如果要实现圆角效果 需要设置一个跟谁属性
    //setMasksToBounds  可以让imageview中所有的子图层跟谁imageview一起变化
    [imageView.layer setMasksToBounds:YES];
    imageView.layer.cornerRadius = 50.0f;
    
    //2.阴影
    //提示  如果设置了 setMasksToBounds属性 imageview的阴影属性无效
    [imageView.layer setShadowColor:[UIColor redColor].CGColor];
    [imageView.layer setShadowOffset:CGSizeMake(10.0, 10.0)];
    [imageView.layer setShadowOpacity:1.0f];
    
    //3.边框
    [imageView.layer setBorderColor:[UIColor blueColor].CGColor];
    [imageView.layer setBorderWidth:3.0f];
    
    //4.形变属性  在CAlyer中 形变属性是3d的  不再是2d的
    //注意  ： 形变参数在使用set方法是  只能使用一种形变
    //4.1  平移属性
//    [imageView.layer setTransform:CATransform3DMakeTranslation(0, 300, 0)];
//    //4.2 缩放苏醒
//    [imageView.layer setTransform:CATransform3DMakeScale(0.5, 0.5, 1.0)];
//    //4.2旋转属性  通常在旋转时  使用z轴即可  要沿着那个轴转 就设置为1   x,y 旋转90为不可见状态
//    [imageView.layer setTransform:CATransform3DMakeRotation(M_PI_4, 0, 0, 1)];
    
    //5.利用keyPath设置形变  但是属性不要出错  可以在文档中进行搜索（transform3D）
    //5.1平移
    [imageView.layer setValue:@-100 forKeyPath:@"transform.translation.x"];
    //5.2缩放
    [imageView.layer setValue:@0.5 forKeyPath:@"transform.scale"];
    //5.3旋转
    [imageView.layer setValue:@M_PI_2 forKeyPath:@"transform.rotation.z"];
}

#pragma mark - 自定义视图的layer演练
- (void)myViewLayerDemo
{
    //1.自定义uiview的图层属性、
    UIView *myview = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    [myview setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:myview];
    //1.1 圆角半径
    myview.layer.cornerRadius = 50.0f;
    //1.2阴影
    //引文核心动画是跨平台的 基于QuartzCore  ， 所以在Core Animation中 不能使用任何ui有关的方法
    //是因为uiKit框架只能适用于IOS
    //要设置阴影 要设置阴影  还要设置其他属性  偏移量和透明度
    [myview.layer setShadowColor:[UIColor lightGrayColor].CGColor];
    //>>>setShadowOffset  阴影的偏移量
    [myview.layer setShadowOffset:CGSizeMake(10, 10)];
    //>>>>setShadowOpacity  设置阴影的透明度
    [myview.layer setShadowOpacity:1.0];
    //1.3边框
    [myview.layer setBorderColor:[UIColor blueColor].CGColor];
    //边框宽度
    [myview.layer setBorderWidth:3.0f];

}
@end

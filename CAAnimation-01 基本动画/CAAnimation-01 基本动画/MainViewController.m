//
//  MainViewController.m
//  CAAnimation-01 基本动画
//
//  Created by Seven on 15/5/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface MainViewController ()

@property (weak,nonatomic) UIView *myView;

@end

@implementation MainViewController
/*要实现简单动画通过touchBegin方法来触发
    1.平移动画
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    [myView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:myView];
    self.myView = myView;

}
#pragma mark - 动画代理方法
#pragma mark 动画开始代理（极少使用）
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"动画开始");
}
#pragma mark 动画结束代理（通常在动画结束后，做动画后续处理）
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *type = [anim valueForKey:@"animationType"];
    if ([type isEqualToString:@"translationto"]) {
        //通过键值取出需要移动到的目标点
        CGPoint point = [[anim valueForKey:@"targetPoint"]CGPointValue];
        NSLog(@"--目标点--%@",NSStringFromCGPoint(point));
        //设置myview的坐标点
        [self.myView setCenter:point];
    }

    NSLog(@"动画结束 ,myView ： %@",    NSStringFromCGRect(self.view.frame));
}


#pragma mark - touch事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
//    [self.myView setCenter:location];
    //将myView平移到指定的坐标点
    //[self translationAnimTo:location];
//    if ([touch view] == self.myView) {
//        NSLog(@"muView");
//    }
    
    [UIView animateWithDuration:1.0f animations:^{
        [self.myView setCenter:location];
    } completion:^(BOOL finished) {
        NSLog(@"%@",NSStringFromCGRect(self.myView.frame));
    }];
}
#pragma mark - CABasic动画
#pragma makr 平移动画到指定点
- (void)translationAnimTo:(CGPoint)point
{
    //1.实例化动画
    //如果没有指定图层锚点 position 对应UIView的中心点
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    //2.设置动画属性
    //1> formValue（当前坐标） & ToValue
    [anim setToValue:[NSValue valueWithCGPoint:point]];
    //2>动画时长
    [anim setDuration:1.0f];

    //4.让动画停留在目标位置
    /*
        通过设置动画在完成后不删除，以及向前填充，可以做到平移动画
        UIView的看起来停留在了目标位置，但是其本身的frame并没有发生变化。
     */
    [anim setRemovedOnCompletion:NO];
    //kCAFillModeForwards:逐渐逼近目标点
    [anim setFillMode:kCAFillModeForwards];
    
    //设置代理
    [anim setDelegate:self];
    
    //5.修复坐标点的位置 ， 可以利用setValue方法
    [anim setValue:[NSValue valueWithCGPoint:point] forKey:@"targetPoint"];
    [anim setValue:@"translationto" forKey:@"animationType"];
    
    //3.将动画添加到图层
    //将动画添加到图层之后，系统会按照自定义好的属性开始动画，通常程序员不在于动画进行交互。
    [self.myView.layer addAnimation:anim forKey:nil];
    
    
    
}
@end

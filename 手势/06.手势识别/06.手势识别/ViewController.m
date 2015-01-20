//
//  ViewController.m
//  06.手势识别
//
//  Created by Seven on 15/1/20.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"
#define KimageInitFrame CGRectMake (10,130,300,196)
@interface ViewController ()

@end

@implementation ViewController
/*
手势使用的步骤：
    1、实例化手势
    2、指定手势参数
    3、将手势附加到指定视图
    4、编写手势监听方法
提示：imageview默认不支持点击等交互
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    //1.将imageview添加到视图
    UIImage *image = [UIImage imageNamed:@"img"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:KimageInitFrame];
    [self.view   addSubview:imageView];
    //设置imageview可以支持点按交互
    [imageView setUserInteractionEnabled:YES];
    //1.点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    //点按次数，例如双击是2；
    //注意：在ios中很少使用双击，如果一定要使用，要有一个图形化界面告知用户可以双击
    [tap setNumberOfTapsRequired:2];
    //用几根手指点按
    [tap setNumberOfTouchesRequired:1];
    //将手势识别添加到imageView
    [imageView addGestureRecognizer:tap];
    
    //2.长按手势
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    [imageView addGestureRecognizer:longTap];
}
#pragma mark - 手势监听方法

#pragma mark 点按手势
- (void) tap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"点按手势");
    //向下移出屏幕，然后返回
    // recognizer.view 就是识别到的手势视图，也就是手势绑定到的视图。
    CGRect initFrame = recognizer.view.frame;
    CGRect targetFrame = recognizer.view.frame;
    targetFrame.origin.y += 360;
    [UIView animateWithDuration:1.0f animations:^{
        //自动反向重复动画
        [UIView setAnimationRepeatAutoreverses:YES];
        //设置动画重复次数
        [UIView setAnimationRepeatCount:2];
        [recognizer.view setFrame:targetFrame];
    } completion:^(BOOL finished) {
        //[UIView animateWithDuration:1.0f animations:^{
            [recognizer.view setFrame:initFrame];
       // }];
    }];
}
#pragma mark 长按手势
- (void)longTap:(UILongPressGestureRecognizer *)recognizer
{
    /*旋转半圈动画 动画完成后恢复
     长按手势 是 连续手势是需要 处理状态的。
     因为长按通常只有一根手指，因此在begin状态下长按手势已经被识别了
     针对长按的处理最好在begin里。
     ＝＝＝＝＝39分钟＝＝＝＝＝＝＝
     */
    if (UIGestureRecognizerStateBegan == recognizer.state) {
        [UIView animateWithDuration:1.0f animations:^{
            [recognizer.view setTransform:CGAffineTransformMakeRotation(M_PI)];
        }completion:^(BOOL finished) {
            //CGAffineTransformIdentity 将视图的形变复原（平移，旋转个，缩放）
            [recognizer.view setTransform:CGAffineTransformIdentity];
        }];
    }else if(UIGestureRecognizerStateEnded == recognizer.state){
//        [UIView animateWithDuration:1.0f animations:^{
//            [recognizer.view setTransform:CGAffineTransformMakeRotation(M_PI)];
//        }completion:^(BOOL finished) {
//            //CGAffineTransformIdentity 将视图的形变复原（平移，旋转个，缩放）
//            [recognizer.view setTransform:CGAffineTransformIdentity];
//        }];
    }
}
@end

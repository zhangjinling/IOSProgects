//
//  ViewController.m
//  02.多点触摸
//
//  Created by Seven on 15/1/17.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setMultipleTouchEnabled:YES];
    [self.view setBackgroundColor:[UIColor blackColor]];
    UIImage *image1 = [UIImage imageNamed:@"spark_red.png"];
    UIImage *image2 = [UIImage imageNamed:@"spark_blue.png"];
    self.images = @[image1,image2];
}
/*
    在ios开发中 ， 视图默认不支持多点触摸。
    通常在使用uitouch开发时 ， 为了避免不必要的麻烦，也最好不要支持多点。
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //遍历touches集合 来添加图像
//    NSInteger i = 0;
//    for (UITouch *touch in touches) {
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.images[i]];
//        
//        CGPoint location = [touch locationInView:self.view];
//        [imageView setCenter:location];
//        [self.view addSubview:imageView];
//        i++;
//    }
    //一根手指
//    if (touches.count == 1) {
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.images[0]];
//        UITouch *touch = [touches anyObject];
//        
//        CGPoint location = [touch locationInView:self.view];
//        [imageView setCenter:location];
//        [self.view addSubview:imageView];
//    }else{
//    }
}
#pragma mark - touchesMoved方法中，集合的顺序不会改变
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSInteger i = 0;
    for (UITouch *touch in touches) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:self.images[i]];
        
        CGPoint location = [touch locationInView:self.view];
        
        [imageView setCenter:location];
        [UIView animateWithDuration:2.0f animations:^{
            [imageView setAlpha:0.5f];
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }] ;
        [self.view addSubview:imageView];
        i++;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%d",self.view.subviews.count);
    
}
@end

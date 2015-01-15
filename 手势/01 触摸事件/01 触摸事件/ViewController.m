//
//  ViewController.m
//  01 触摸事件
//
//  Created by Seven on 15/1/15.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak,nonatomic)UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(60, 130, 200, 200)];
    [redView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:redView];
    self.redView = redView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 在触摸方面开发时，只针对touches进行处理
#pragma mark - 触摸开始 在一次触摸事件中 只会执行一次
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"开始%@",touches);
}
#pragma mark - 触摸移动  在一次触摸事件中会执行多次
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.从nsset中取出touch对象
    //通常在单点触摸时。可以使用[touches anyObject] 取出UITouch对象
    UITouch *touch = [touches anyObject];
    //2.要知道手指触摸的位置
    CGPoint location = [touch locationInView:self.view];
    //2.1对位置进行修正
    
    CGPoint pLocation = [touch previousLocationInView:self.view];
    CGPoint deltaP = CGPointMake(location.x - pLocation.x, location.y-pLocation.y);
    CGPoint newCenter = CGPointMake(self.redView.center.x + deltaP.x, self.redView.center.y + deltaP.y);
    [self.redView setCenter:newCenter];
    
    NSLog(@"(%f,%f)---(%f,%f)",location.x,location.y,pLocation.x,pLocation.y);
}
#pragma mark - 触摸结束  再一次触摸事件中会执行一次
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   // NSLog(@"结束%@",touches);
}
#pragma mark - 触摸取消
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSLog(@"取消%@",touches);
}
@end

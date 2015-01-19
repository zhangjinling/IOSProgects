//
//  ViewController.m
//  03.触摸事件拦截
//
//  Created by Seven on 15/1/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"
#import "RedView.h"
#import "GreenView.h"
#import "BlueView.h"
@interface ViewController ()
@property (weak, nonatomic) RedView *redView;
@property (weak, nonatomic) BlueView *blueView;
@property (weak, nonatomic) GreenView *greenView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RedView *view1 = [[RedView alloc]initWithFrame:CGRectMake(20, 210, 280, 40)];
    [self.view addSubview:view1];
    self.redView = view1;
    
    BlueView *view2 = [[BlueView alloc]initWithFrame:CGRectMake(60, 130, 200, 200)];
    [self.view addSubview:view2];
    [view2 setAlpha:0.5];
    self.blueView = view2;
    
    GreenView *view3 = [[GreenView alloc]initWithFrame:CGRectMake(80, 150, 160, 160)];
    [self.view addSubview:view3];
    [view3 setAlpha:0.5];
    self.greenView = view3;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end

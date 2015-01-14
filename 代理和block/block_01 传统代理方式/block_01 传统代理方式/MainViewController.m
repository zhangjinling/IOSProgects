//
//  MainViewController.m
//  block_01 传统代理方式
//
//  Created by Seven on 15/1/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()

@property(weak,nonatomic)UILabel *label;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(110, 210, 100, 40)];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 40)];
    [self.view addSubview:label];
    self.label = label;
}
- (void)click
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    [detail setDelegate:self];
    [self presentViewController:detail animated:YES completion:nil];
}
#pragma mark - 明细代理
- (void)detailDone:(NSString *)text
{
    [self.label setText:text];
}
@end

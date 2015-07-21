//
//  Test2ViewController.m
//  weibo02
//
//  Created by Seven on 15/6/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "Test2ViewController.h"
#import "Test3ViewController.h"
@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    Test3ViewController *test3 = [[Test3ViewController alloc]init];
    [self.navigationController pushViewController:test3 animated:YES];
}
@end

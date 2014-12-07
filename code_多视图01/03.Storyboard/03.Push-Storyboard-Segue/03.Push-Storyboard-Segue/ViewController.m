//
//  ViewController.m
//  03.Push-Storyboard-Segue
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 使用连线会调用的方法（modal&push）
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%@", segue);
    NSLog(@"%@", segue.sourceViewController);
    NSLog(@"%@", segue.destinationViewController);
}

@end

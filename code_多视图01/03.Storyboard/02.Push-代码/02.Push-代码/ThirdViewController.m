//
//  ThirdViewController.m
//  02.Push-代码
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@", self.navigationController.childViewControllers);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

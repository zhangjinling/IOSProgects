//
//  SecondViewController.m
//  02.Tabbar-XIB1
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tabBarItem setTitle:@"第二项"];
    [self.tabBarItem setBadgeValue:@"5"];
    [self.tabBarItem setImage:[UIImage imageNamed:@"tab2.png"]];
}

@end

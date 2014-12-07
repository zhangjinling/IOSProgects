//
//  RootViewController.m
//  02.组合应用
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "RootViewController.h"
#import "NextViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(clickNext)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickNext
{
    NextViewController *next = [[NextViewController alloc]init];
    
    [self.navigationController pushViewController:next animated:YES];
}

@end

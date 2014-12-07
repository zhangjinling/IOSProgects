//
//  NextViewController.m
//  02.Push-代码
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NextViewController.h"
#import "ThirdViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@", self.navigationController.childViewControllers);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新建" style:UIBarButtonItemStyleDone target:self action:@selector(toThird)];
}

- (void)toThird
{
    ThirdViewController *third = [[ThirdViewController alloc]init];
    
    [self.navigationController pushViewController:third animated:YES];
}

@end

//
//  EditPersonViewController.m
//  03.Push-Storyboard-Segue
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "EditPersonViewController.h"

@interface EditPersonViewController ()

@end

@implementation EditPersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回上一级窗口
- (IBAction)backToList:(id)sender
{
    // 用出栈的方式，弹出当前的视图控制器
    NSLog(@"%@", self.navigationController.childViewControllers);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

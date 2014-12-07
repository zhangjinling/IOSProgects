//
//  MainViewController.m
//  02.Tabbar-代码
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MainViewController.h"
#import "ModalViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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

// 模态方式弹出新的视图控制器
- (IBAction)modal
{
    ModalViewController *modal = [[ModalViewController alloc]init];
    
    // 模态弹出视图控制器
    [self presentViewController:modal animated:YES completion:^{
        NSLog(@"弹出完成");
    }];
    
}
@end

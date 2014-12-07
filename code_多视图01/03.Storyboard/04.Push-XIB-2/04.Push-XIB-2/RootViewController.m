//
//  RootViewController.m
//  04.Push-XIB-2
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "RootViewController.h"
#import "NextViewController.h"
#import "ModalViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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

#pragma mark - Push
- (IBAction)Next
{
    NextViewController *next = [[NextViewController alloc]init];
    
    [self.navigationController pushViewController:next animated:YES];
}

#pragma mark - 模态
- (IBAction)modal
{
    ModalViewController *modal = [[ModalViewController alloc]init];
    
    [self presentViewController:modal animated:YES completion:nil];
}
@end

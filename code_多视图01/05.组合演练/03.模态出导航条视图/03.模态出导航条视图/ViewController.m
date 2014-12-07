//
//  ViewController.m
//  03.模态出导航条视图
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    
    [self presentViewController:picker animated:YES completion:nil];
    
}
@end

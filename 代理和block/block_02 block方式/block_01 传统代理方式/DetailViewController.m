//
//  DetailViewController.m
//  block_01 传统代理方式
//
//  Created by Seven on 15/1/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    textFieldChangedBlock _changedBlock;
}
@property(weak,nonatomic) UITextField *textField;
@end

@implementation DetailViewController

-(id)initWithBlock:(textFieldChangedBlock)block
{
    self = [super init];
    if (self) {
        _changedBlock = block;
    }
    return self;
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    UITextField *textFileld = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
    [textFileld setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:textFileld];
    self.textField = textFileld;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 20, 100, 40)];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:button];
}

- (void)click
{
    //返回
    _changedBlock(self.textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

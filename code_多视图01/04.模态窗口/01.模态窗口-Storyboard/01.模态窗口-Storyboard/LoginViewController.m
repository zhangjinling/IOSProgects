//
//  LoginViewController.m
//  01.模态窗口-Storyboard
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

#pragma mark - Actions
- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)login
{
    NSString *pwd = self.passwordText.text;
    
    if ([pwd isEqualToString:@"123"]) {
        NSLog(@"密码正确");
        
        // 委托代理执行方法
        [self.delegate loginViewLogonSuccessedWithUserName:self.userNameText.text];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}
@end

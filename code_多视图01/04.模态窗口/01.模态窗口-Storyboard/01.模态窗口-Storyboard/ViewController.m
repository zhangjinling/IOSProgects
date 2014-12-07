//
//  ViewController.m
//  01.模态窗口-Storyboard
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 是否登录的标记
@property (assign, nonatomic) BOOL isLogon;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LoginViewController *login = segue.destinationViewController;
    
    [login setDelegate:self];
}

#pragma mark - 登录视图控制器代理方法
- (void)loginViewLogonSuccessedWithUserName:(NSString *)userName
{
    NSLog(@"%@", userName);
    // 1. 设置消息标签
    NSString *str = [NSString stringWithFormat:@"登录用户是：%@", userName];
    [self.messageLabel setText:str];
    
    // 2. 修改登录按钮文字
    [self.loginButton setTitle:@"注销"];
    
    // 3. 用属性记录已经登录
    self.isLogon = YES;
}

#pragma mark - Actions
- (IBAction)login:(id)sender
{
    NSLog(@"点了");

    if (self.isLogon) {
        // ActionSheet
        /**
         参数
         
         1. 标题
         2. 代理 self
         3. 取消按钮标题
         4. 有破坏性的按钮标题
         5. 其他按钮标题
         
         */
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"是否注销" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"是否注销？" otherButtonTitles:nil, nil];
        
        [sheet showInView:self.view];
    } else {
        /**
         注释：因为Sotryboard中已经定义了Login视图控制器，因此在此不能实例化新的LoginViewController
         */
//    LoginViewController *login = [[LoginViewController alloc]init];
//
//    [self presentViewController:login animated:YES completion:nil];
        [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
    }
}

#pragma mark - ActionSheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d", buttonIndex);
    if (0 == buttonIndex) {
        // 1. 设置消息标签
        [self.messageLabel setText:@"用户未登录"];
        
        // 2. 修改登录按钮文字
        [self.loginButton setTitle:@"登录"];
        
        // 3. 用属性记录已经注销
        self.isLogon = NO;
    }
}

@end

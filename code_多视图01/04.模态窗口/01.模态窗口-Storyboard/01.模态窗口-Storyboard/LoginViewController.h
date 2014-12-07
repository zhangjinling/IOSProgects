//
//  LoginViewController.h
//  01.模态窗口-Storyboard
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate;

#pragma mark - 定义接口
@interface LoginViewController : UIViewController

@property (weak, nonatomic) id<LoginViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;

- (IBAction)goBack:(id)sender;
- (IBAction)login;

@end

#pragma mark - 定义协议
@protocol LoginViewControllerDelegate <NSObject>

- (void)loginViewLogonSuccessedWithUserName:(NSString *)userName;

@end
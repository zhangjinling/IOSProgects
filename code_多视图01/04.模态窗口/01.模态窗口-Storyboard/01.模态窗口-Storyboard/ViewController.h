//
//  ViewController.h
//  01.模态窗口-Storyboard
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface ViewController : UIViewController <LoginViewControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loginButton;

- (IBAction)login:(id)sender;

@end

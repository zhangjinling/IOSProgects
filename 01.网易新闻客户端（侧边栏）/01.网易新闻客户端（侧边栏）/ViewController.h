//
//  ViewController.h
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RightViewController.h"

@interface ViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,RightViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)leftButton:(id)sender;
- (IBAction)rightButton:(id)sender;

@end

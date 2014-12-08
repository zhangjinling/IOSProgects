//
//  RightViewController.m
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

#pragma mark - 选择照片
- (IBAction)selectPhoto:(id)sender
{

    [self.delegate rightViewControllerDidSelectPhoto];
}
@end

//
//  LeftViewController.h
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuModel.h"
//协议声明
@protocol LeftViewControllerDelegate;

@interface LeftViewController : UITableViewController

//定义代理,tableView的代理不能是delegate，因为已经占用
@property (weak,nonatomic) id<LeftViewControllerDelegate>menuDelegate;
@end

@protocol LeftViewControllerDelegate <NSObject>

#pragma mark - 定义协议
//左侧控制器选中了菜单项
- (void)LeftViewController:(LeftViewController *)controller className:(NSString *)className;

@end
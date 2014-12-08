//
//  RightViewController.h
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RightViewControllerDelegate;

@interface RightViewController : UIViewController

//显示照片
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
//选择照片
- (IBAction)selectPhoto:(id)sender;

//设置代理
@property(weak,nonatomic)id<RightViewControllerDelegate> delegate;

@end

//设置协议
@protocol RightViewControllerDelegate <NSObject>

-(void)rightViewControllerDidSelectPhoto;

@end
//
//  ViewController.h
//  02.系统设置包
//
//  Created by Seven on 14/12/9.
//  Copyright (c) 2014年 seven. All rights reserved.
//
/*
    观察者模式
    1、观察者 -- - 负责观察
    2、观察对象 --- 观察内容
    3、通知对象 -----条件满足时，通知对象，做后续处理。
 */
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@end

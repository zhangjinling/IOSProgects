//
//  DetailViewController.h
//  block_01 传统代理方式
//
//  Created by Seven on 15/1/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    1.定义快代码
    2.定义实例化方法
    3.实例化时传入快代码
    4.需要执行块代码
 */
//定义快代码
typedef void(^textFieldChangedBlock)(NSString *text);
@interface DetailViewController : UIViewController
//实例化方法
- (id)initWithBlock:(textFieldChangedBlock)block;
@end


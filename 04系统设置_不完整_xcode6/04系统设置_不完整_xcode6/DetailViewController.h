//
//  DetailViewController.h
//  04系统设置_不完整_xcode6
//
//  Created by Seven on 15/1/13.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myswitch.h"
/*
关于block：
    1.定义block：指定参数，返回类型
    2.定义使用到block的方法，通常使用可以是init或者其他类似的方法
        - (id)initWithBlock:(switchValueChangedBlock)block;
    3.定义一个成员变量  在init方法中记录以参数形式block
    4.在需要的时候，直接一block(参数)执行代码块
    值得注意的是 block是对C语言的扩展  问不是oc的 因此调用时不要使用[self block]的方式
 */
/*
    block 是对c语言的扩展 在oc中可以使用，方便预定义一些方法 已被执行
 */
typedef void(^switchValueChangedBlock)(myswitch *Myswitch);
@interface DetailViewController : UITableViewController
//定义使用到block的方法
- (id)initWithBlock:(switchValueChangedBlock)block;

//数据文件的文件名
@property(strong,nonatomic) NSString *dataFileName;
@end

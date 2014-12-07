//
//  FirstViewController.h
//  02.Tabbar-XIB1
//
//  Created by apple on 13-9-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/**
 UITabbar的小结
 
 1. 经常使用的属性：
 1> viewControllers 所有的子视图
 2> title: 子项目的标题
 3> badgeValue: 字符串类型的数字，显示在右上角
 4> image: 需要打开alpha通道，可以找美工帮忙，小于32*32，png格式
 
 2. 如果使用代码方式设置tabbar中的内容，需要在第一个视图控制器中遍历所有的子视图控制器
 
 遍历方法使用 isKindOfClass 方法，判断对应的试图控制器是否是我们需要的。
 
 提示：isKindOfClass方法，在iOS开发的子视图遍历中使用的非常频繁！
 
 */
#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@end

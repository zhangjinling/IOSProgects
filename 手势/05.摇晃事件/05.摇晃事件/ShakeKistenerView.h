//
//  ShakeKistenerView.h
//  05.摇晃事件
//
//  Created by Seven on 15/1/20.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
    因为UIResponder的canBecomeFirstResponder属性，默认为no
    在监听摇晃事件时需要把跟视图变成第一响应者，因此需要自定义一个摇晃监听视图
 */
@interface ShakeKistenerView : UIView

@end

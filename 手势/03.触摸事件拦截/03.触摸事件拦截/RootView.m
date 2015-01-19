//
//  RootView.m
//  03.触摸事件拦截
//
//  Created by Seven on 15/1/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "RootView.h"
#import "RedView.h"
#import "GreenView.h"
#import "BlueView.h"
@interface RootView ()
@property (weak, nonatomic) RedView *redView;
@property (weak, nonatomic) BlueView *blueView;
@property (weak, nonatomic) GreenView *greenView;
@end


@implementation RootView
#pragma mark - 通过storyBoard或xib创建的视图 ， initwithFrame方法不会被执行。

- (void)awakeFromNib
{
    
        RedView *view1 = [[RedView alloc]initWithFrame:CGRectMake(20, 210, 280, 40)];
        [self addSubview:view1];
        self.redView = view1;
        
        BlueView *view2 = [[BlueView alloc]initWithFrame:CGRectMake(60, 130, 200, 200)];
        [self addSubview:view2];
        [view2 setAlpha:0.5];
        self.blueView = view2;
        
        GreenView *view3 = [[GreenView alloc]initWithFrame:CGRectMake(80, 150, 160, 160)];
        [self addSubview:view3];
        [view3 setAlpha:0.5];
        self.greenView = view3;

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"clcik me root");
}
/*
 重写hittext方法，拦截用户触摸视图的顺序
hitTest方法的都用是由window来负责触发的。
 
 如果希望用户按下屏幕 ， 就立刻做出响应 ， 使用touchesBegin
 如果希望用户离开屏幕 ， 就立刻做出响应 ， 使用touchesEnd
 通常情况下使用touchesBegin。
 */

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //1.判断当前视图是否能接受用户响应
    /*self.UserInteractionEnabled=YES
      self.alpha > 0.01;
      self.hidden = no;
     */
    //2.遍历其中的所有的子视图，能否对用户触摸做出相应的响应
    //3.把event交给上级视图活上级视图控制器处理
    //4.return nil;如果发挥nil，说明当前视图及其子视图均不对用户触摸做出反应。
    /*
     参数说明：
        point：参数是用户触摸位置相对于当前视图坐标系的点；
     注视：以下两个是联动使用的，以递归的方式判断具体响应用户事件的子视图
            - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
            - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
        这两个方法仅在拦截触摸事件时使用，他会打断响应者链条，平时不要调用。
     提醒：如果没有万不得已的情况，最好不要自己重写hitTest方法；
     */
    CGPoint redP = [self convertPoint:point toView:self.redView];
    //转换绿色视图的点
    CGPoint greenP = [self convertPoint:point toView:self.greenView];
    //pointInside  使用指定视图中的坐标点来判断是否在视图内部，最好不要在日常开发中都用。
    if ([self.greenView pointInside:greenP withEvent:event]) {
        return self.greenView;
    }
    NSLog(@"%@",NSStringFromCGPoint(redP));
    if ([self.redView pointInside:redP withEvent:event]) {
        
        return self.redView;

    }
    return [super hitTest:point withEvent:event];
}

@end

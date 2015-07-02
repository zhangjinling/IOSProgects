//
//  HWDropdownMenu.m
//  weibo02
//
//  Created by Seven on 15/6/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWDropdownMenu.h"
@interface HWDropdownMenu()
//用来显示具体内容的创建
@property (strong ,nonatomic) UIImageView *containerView;
@end

@implementation HWDropdownMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIImageView *)containerView
{
    if (!_containerView) {
        NSLog(@"contentView");
        
        //添加一个灰色控件
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.width = 217;
        containerView.height = 217;
        containerView.userInteractionEnabled = YES; //开启交互功能
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;

}

+ (instancetype)menu
{
    return [[self alloc]init];
}
-(void)showFrom:(UIView *)from
{
    //1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //2.添加到窗口上
    [window addSubview:self];
    //3.设置于主窗口同样大小
    self.frame = window.bounds;
    
    //默认情况下 frame是以父控件左上角为坐标原点
    //可以通过坐标系原点 来改变frame的参照点
    CGRect newframe = [from.superview convertRect:from.frame toView:window];

    //调整自己的位置（灰色图片的位置）
    self.containerView.centerX =CGRectGetMidX(newframe);
    self.containerView.y =CGRectGetMaxY(newframe);
    
    
}
- (void)setContent:(UIView *)content
{
    _content = content;
    //调整内容的位置
    content.x = 10;
    content.y = 15;
    
    //设置内容的宽度
//    content.width = self.containerView.width - 2 * content.x;
    
    //设置灰色图片的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    //设置会的的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    //添加内容到黑色区域
    [self.containerView addSubview:content];
}
- (void)setContentControler:(UIViewController *)contentControler
{
    _contentControler = contentControler;
    self.content = contentControler.view;
}
-(void)dismiss
{
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end

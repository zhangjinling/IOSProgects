//
//  HWLeftMenu.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWLeftMenu.h"
#import "HMLeftMenuButton.h"
@interface HWLeftMenu ()
@property (nonatomic, weak)HMLeftMenuButton *selectedButton;
@end


@implementation HWLeftMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //leftMenu背景透明
        self.backgroundColor = [UIColor clearColor];
        CGFloat alpha = 51;
        HMLeftMenuButton *btn = [self setupButtonWithIcon:@"sidebar_nav_news" title:@"新闻"  bgcolor:HWColora(202, 68, 73, alpha)];
        [self buttonClick:btn];
        
        [self setupButtonWithIcon:@"sidebar_nav_reading" title:@"订阅" bgcolor:HWColora(190, 111, 69, alpha)];
        [self setupButtonWithIcon:@"sidebar_nav_photo" title:@"图片" bgcolor:HWColora(76, 132, 190, alpha)];
        [self setupButtonWithIcon:@"sidebar_nav_video" title:@"视频" bgcolor:HWColora(110, 170, 78, alpha)];
        [self setupButtonWithIcon:@"sidebar_nav_comment" title:@"跟帖" bgcolor:HWColora(170, 172, 73, alpha)];
        [self setupButtonWithIcon:@"sidebar_nav_radio" title:@"电台" bgcolor:HWColora(190, 62, 110, alpha)];

    }
    return self;
}
- (HMLeftMenuButton *)setupButtonWithIcon:(NSString *)icon title:(NSString *)title bgcolor:(UIColor *)bgcolor
{
    HMLeftMenuButton *btn = [[HMLeftMenuButton alloc]init];
    //监听按钮点击事件
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    //设置高亮的背景
//    [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    //设置高亮是不要让图标变色
    btn.adjustsImageWhenHighlighted = NO;
    //设置按钮选中的背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgcolor] forState:UIControlStateSelected];
    //设置按钮左对齐(垂直对齐)
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    [self addSubview:btn];
    return btn;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    for (NSUInteger i = 0; i < btnCount; i++) {
        HMLeftMenuButton *btn = self.subviews[i];
        btn.tag = i;
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH;
    }
}
- (void)setDelegate:(id<HWLeftMenuDelegate>)delegate
{
    _delegate = delegate;
    //默认选中的按钮
    [self buttonClick:[self.subviews firstObject]];
}
/**
 *  监听按钮点击事件
 *
 *  @param button 点击的按钮
 */
- (void)buttonClick:(HMLeftMenuButton *)button
{
    //通知代理
    if([self.delegate respondsToSelector:@selector(leftMenu:didSelectButtonFromIndex:toIndex:)]){
        [self.delegate leftMenu:self didSelectButtonFromIndex:self.selectedButton.tag toIndex:button.tag];
    }

    //控制按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}




@end

//
//  HWTabbar.m
//  weibo02
//
//  Created by Seven on 15/7/1.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWTabbar.h"

@interface HWTabbar()
@property (nonatomic ,weak)UIButton *plusBtn;

@end

@implementation HWTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc]init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;

    }
    return self;
}

- (void)layoutSubviews
{
    //必须调用[super layoutSubviews];
    [super layoutSubviews];
    //1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height *0.5;
    
    //这只其他tabbarbutton
    CGFloat tabbarButtonW = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置宽度
            child.width = tabbarButtonW;
            //设置x
            child.x = tabbarButtonIndex * tabbarButtonW;
            //增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
    
//    NSUInteger count = self.subviews.count;
//    HWLog(@"%@",self.subviews);
//    for (int i = 0; i< count ; i++) {
//        UIView *child = self.subviews[i];
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([child isKindOfClass:class]) {
//            //设置宽度
//            child.width = tabbarButtonW;
//            //设置x
//            child.x = tabbarButtonIndex * tabbarButtonW;
//            //增加索引
//            tabbarButtonIndex ++;
//            if (tabbarButtonIndex == 2) {
//                tabbarButtonIndex++;
//            }
//        }
//    }
}

- (void)plusClick
{
    //通知代理
    if([self.delagate respondsToSelector:@selector(tabbarDidClickPlusButton:)]){
        [self.delagate tabbarDidClickPlusButton:self];
    }

}
@end

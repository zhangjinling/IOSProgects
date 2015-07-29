//
//  HWEmotionTabbar.m
//  weibo02
//
//  Created by Seven on 15/7/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWEmotionTabbar.h"
#import "HWEmotionTabbarButton.h"

@interface HWEmotionTabbar ()
@property (nonatomic, weak) HWEmotionTabbarButton *selectedBtn;
@end

@implementation HWEmotionTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:HWEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:HWEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:HWEmotionTabBarButtonTypeLxh];

        
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮上的文字
 */
- (HWEmotionTabbarButton *)setupBtn:(NSString *)title buttonType:(HWEmotionTabBarButtonType)buttonType
{
    HWEmotionTabbarButton *btn = [[HWEmotionTabbarButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    //默认选中按钮
    if (buttonType == HWEmotionTabBarButtonTypeDefault) {
        [self btnClick:btn];
    }
    [self addSubview:btn];
    
    //根据位置设置背景图片
    NSString *image = nil;
    NSString *selectImage = nil;
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }else{
        image = @"compose_emotion_table_mid_normal";
        selectImage = @"compose_emotion_table_mid_selected";
    }
    //设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    return btn;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        HWEmotionTabbarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}
/**
 *  监听按钮点击
 *
 *  @param btn 被点击的按钮
 */
- (void)btnClick:(HWEmotionTabbarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled  =NO;
    self.selectedBtn = btn;
    //通知代理
    if([self.delegate respondsToSelector:@selector(emotionTabbar:didSelectBtn:)]){
        [self.delegate emotionTabbar:self didSelectBtn:btn.tag];
    
    }
}
@end

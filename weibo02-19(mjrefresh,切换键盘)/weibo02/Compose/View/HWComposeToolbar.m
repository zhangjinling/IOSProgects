//
//  HWComposeToolbar.m
//  weibo02
//
//  Created by Seven on 15/7/25.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWComposeToolbar.h"

@interface HWComposeToolbar()

/** 表情按钮 */
@property (nonatomic, weak) UIButton *emotionButtom;


@end

@implementation HWComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:HWComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:HWComposeToolbarButtonTypePicture];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:HWComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:HWComposeToolbarButtonTypeTrend];
        self.emotionButtom = [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:HWComposeToolbarButtonTypeEmotion];
    }
    return self;
}
/**
 *  创建一个按钮
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 */
- (UIButton *)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(HWComposeToolbarButtonType)type
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    
    [self addSubview:btn];
    return btn;
}

- (void) setShowEmotionBtn:(BOOL)showEmotionBtn
{
    _showEmotionBtn = showEmotionBtn;
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    if (!showEmotionBtn) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }    //显示表情图标
    [self.emotionButtom setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButtom setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;

    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width =btnW;
        btn.height = btnH;
        btn.x = i * btnW;
    }
}
- (void)btnClick:(UIButton *)btn
{
    HWLog(@"%.0f",btn.x / btn.width);
    //判断是否有实现这个代理方法
    if ([self.delegate respondsToSelector:@selector(composeToolbar:DidClickButton:)]) {
        [self.delegate composeToolbar:self DidClickButton:btn.tag];
    }
}
@end

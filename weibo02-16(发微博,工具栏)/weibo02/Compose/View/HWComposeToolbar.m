//
//  HWComposeToolbar.m
//  weibo02
//
//  Created by Seven on 15/7/25.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWComposeToolbar.h"

@implementation HWComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted"];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted"];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted"];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted"];
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted"];
    }
    return self;
}
/**
 *  创建一个按钮
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 */
- (void)setupBtn:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
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
@end

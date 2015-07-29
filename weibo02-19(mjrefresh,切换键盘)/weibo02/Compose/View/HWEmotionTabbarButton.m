//
//  HWEmotionTabbarButton.m
//  weibo02
//
//  Created by Seven on 15/7/29.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWEmotionTabbarButton.h"

@implementation HWEmotionTabbarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    //按钮一切高亮都不显示
}

@end

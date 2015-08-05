//
//  HMNavigationBar.m
//  wangyiNews
//
//  Created by Seven on 15/8/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMNavigationBar.h"

@implementation HMNavigationBar


- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIButton *btn in self.subviews) {
        if (![btn isKindOfClass:[UIButton class]]) continue;

        if (btn.centerX < self.width * 0.5) {//左边按钮
            btn.x = 0;
        }else if (btn.centerX > self.width * 0.5){//右边按钮
            btn.x = self.width - btn.width;
        }
    }


}
@end

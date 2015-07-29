//
//  HWEmotionKeyboard.m
//  weibo02
//
//  Created by Seven on 15/7/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabbar.h"

@interface HWEmotionKeyboard()
/** 表情列表 */
@property (nonatomic, weak) HWEmotionListView *listView;
/** tab页 */
@property (nonatomic, weak) HWEmotionTabbar *emotionTabbar;
@end


@implementation HWEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1、表情的内容
        HWEmotionListView *listView = [[HWEmotionListView alloc]init];
        listView.backgroundColor = HWRandomColor;
        [self addSubview:listView];
        self.listView = listView;
        //2、表情的内容
        HWEmotionTabbar *emotionTabbar = [[HWEmotionTabbar alloc]init];
        emotionTabbar.backgroundColor = HWRandomColor;
        [self addSubview:emotionTabbar];
        self.emotionTabbar = emotionTabbar;
        

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.tabar
    self.emotionTabbar.height = 44;
    self.emotionTabbar.y = self.height - self.emotionTabbar.height;
    self.emotionTabbar.width = self.width;
    //2.表情
    self.listView.width = self.width;
    self.listView.x = self.width;
    self.listView.height = self.emotionTabbar.y;
}
@end

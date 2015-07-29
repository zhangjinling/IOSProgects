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
#import "HWEmotion.h"
#import "MJExtension.h"

@interface HWEmotionKeyboard()<HWEmotionTabbarDelegate>
/** 容纳表情控件容器 */
@property (nonatomic, weak) UIView *contentView;
/** 表情列表 */
@property (nonatomic, strong) HWEmotionListView *recentListView;
@property (nonatomic, strong) HWEmotionListView *defaultListView;
@property (nonatomic, strong) HWEmotionListView *emojiListView;
@property (nonatomic, strong) HWEmotionListView *lxhListView;

/** tab页 */
@property (nonatomic, weak) HWEmotionTabbar *emotionTabbar;
@end


@implementation HWEmotionKeyboard

#pragma mark - 懒加载
- (HWEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[HWEmotionListView alloc]init];
        self.recentListView.backgroundColor = HWRandomColor;
    }
    return _recentListView;
}
- (HWEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[HWEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultEmotions = [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
        self.defaultListView.emotions = defaultEmotions;
        self.defaultListView.backgroundColor = HWRandomColor;

    }
    return _defaultListView;
}
- (HWEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[HWEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions = [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.emojiListView.emotions = emojiEmotions;
        self.emojiListView.backgroundColor = HWRandomColor;

    }
    return _emojiListView;
}
- (HWEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[HWEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [HWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        self.lxhListView.emotions = lxhEmotions;
        self.lxhListView.backgroundColor = HWRandomColor;
    }
    return _lxhListView;
}
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1、表情的内容
        UIView *contentView = [[UIView alloc]init];
        [self addSubview:contentView];
        self.contentView = contentView;
        //2、表情的内容
        HWEmotionTabbar *emotionTabbar = [[HWEmotionTabbar alloc]init];
        emotionTabbar.delegate = self;
        [self addSubview:emotionTabbar];
        self.emotionTabbar = emotionTabbar;
        
        

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.tabar
    self.emotionTabbar.height = 37;
    self.emotionTabbar.y = self.height - self.emotionTabbar.height;
    self.emotionTabbar.width = self.width;
    //2.contentView
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.height;
    
}
#pragma mark - 底部tabbar的代理方法
- (void)emotionTabbar:(HWEmotionTabbar *)tabbar didSelectBtn:(HWEmotionTabBarButtonType)buttonType
{
    //移除contentView的内容
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //根据按钮类型 切换congtentView的内容
    switch (buttonType) {
        case HWEmotionTabBarButtonTypeDefault:
        {
            [self.contentView addSubview:self.defaultListView];
            break;
        }
        case HWEmotionTabBarButtonTypeRecent:
            HWLog(@"re");
            [self.contentView addSubview:self.recentListView];
            break;
        case HWEmotionTabBarButtonTypeEmoji:
        {
            [self.contentView addSubview:self.emojiListView];
            break;
        }
        case HWEmotionTabBarButtonTypeLxh:
        {
            [self.contentView addSubview:self.lxhListView];
            break;

        }
    }
    //设置frame
    UIView *child = [self.contentView.subviews lastObject];
    child.frame = self.contentView.bounds;

}
@end

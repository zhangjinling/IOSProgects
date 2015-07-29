//
//  HWEmotionTabbar.h
//  weibo02
//
//  Created by Seven on 15/7/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//  表情键盘的tab页

#import <UIKit/UIKit.h>
typedef enum {
    HWEmotionTabBarButtonTypeRecent,
    HWEmotionTabBarButtonTypeDefault,
    HWEmotionTabBarButtonTypeEmoji,
    HWEmotionTabBarButtonTypeLxh,
} HWEmotionTabBarButtonType;

@class HWEmotionTabbar;

@protocol HWEmotionTabbarDelegate <NSObject>

@optional
- (void)emotionTabbar:(HWEmotionTabbar *)tabbar didSelectBtn:(HWEmotionTabBarButtonType) buttonType;

@end

@interface HWEmotionTabbar : UIView

@property (nonatomic, weak)id <HWEmotionTabbarDelegate> delegate;

@end

//
//  HWComposeToolbar.h
//  weibo02
//
//  Created by Seven on 15/7/25.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWComposeToolbarButtonTypeCamera,//拍照
    HWComposeToolbarButtonTypePicture,//相册
    HWComposeToolbarButtonTypeMention,//@
    HWComposeToolbarButtonTypeTrend,//###
    HWComposeToolbarButtonTypeEmotion//表情
} HWComposeToolbarButtonType;

@class HWComposeToolbar;
@protocol HWComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(HWComposeToolbar *)toolbar DidClickButton:(HWComposeToolbarButtonType)buttonType;

@end

@interface HWComposeToolbar : UIView

@property (nonatomic, weak) id<HWComposeToolbarDelegate>delegate;
/** 是否显示表情按钮 */
@property (nonatomic, assign) BOOL showEmotionBtn;
@end

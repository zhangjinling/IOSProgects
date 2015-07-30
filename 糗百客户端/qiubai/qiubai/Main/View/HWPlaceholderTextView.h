//
//  HWPlaceholderTextView.h
//  weibo02
//
//  Created by Seven on 15/7/25.
//  Copyright (c) 2015年 seven. All rights reserved.
//  带有占位文字的textview

#import <UIKit/UIKit.h>

@interface HWPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, copy) UIColor *placeholderColor;

@end

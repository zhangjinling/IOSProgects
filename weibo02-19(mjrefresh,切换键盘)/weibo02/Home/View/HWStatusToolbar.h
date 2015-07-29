//
//  HWStatusToolbar.h
//  weibo02
//
//  Created by Seven on 15/7/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWStatus;
@interface HWStatusToolbar : UIView

+ (instancetype)toolbar;
@property (nonatomic, strong) HWStatus *status;
@end

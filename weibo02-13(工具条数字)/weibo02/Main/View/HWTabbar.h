//
//  HWTabbar.h
//  weibo02
//
//  Created by Seven on 15/7/1.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWTabbar;
//因为HWTabbar集成子UITabBar，所以也必须实现UITabbar的代理
@protocol HWTabbarDelegate <UITabBarDelegate>

@optional
-(void)tabbarDidClickPlusButton:(HWTabbar *)tabbar;

@end

@interface HWTabbar : UITabBar
@property (weak,nonatomic)id<HWTabbarDelegate> delagate;
@end

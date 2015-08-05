//
//  HWLeftMenu.h
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWLeftMenu;

@protocol HWLeftMenuDelegate <NSObject>

@optional
- (void)leftMenu:(HWLeftMenu *)menu didSelectButtonFromIndex:(int)index toIndex:(int)toIndex;

@end

@interface HWLeftMenu : UIView
@property (nonatomic, weak) id <HWLeftMenuDelegate>delegate;
@end

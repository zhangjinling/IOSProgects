//
//  HWDropdownMenu.h
//  weibo02
//
//  Created by Seven on 15/6/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWDropdownMenu;
@protocol HWDropdownMenuDelegate <NSObject>

@optional
- (void)dropDownMenuDidDismiss:(HWDropdownMenu *)menu;
- (void)dropDownMenuDidShow:(HWDropdownMenu *)menu;

@end

@interface HWDropdownMenu : UIView

@property (nonatomic ,weak) id<HWDropdownMenuDelegate>delegate;

+(instancetype)menu;
//显示
-(void)showFrom:(UIView *)from;
//隐藏
- (void)dismiss;
//内容
@property(strong ,nonatomic)UIView *content;
//内容控制器
@property(strong ,nonatomic)UIViewController *contentControler;
@end

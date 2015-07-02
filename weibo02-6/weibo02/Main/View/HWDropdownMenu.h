//
//  HWDropdownMenu.h
//  weibo02
//
//  Created by Seven on 15/6/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDropdownMenu : UIView
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

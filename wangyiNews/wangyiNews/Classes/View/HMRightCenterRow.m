//
//  HMRightCenterRow.m
//  wangyiNews
//
//  Created by Seven on 15/8/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMRightCenterRow.h"

@interface HMRightCenterRow ()
@property (weak, nonatomic) IBOutlet UIButton *ttileView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation HMRightCenterRow

+ (instancetype)centerViewRow
{
    return [[[NSBundle mainBundle]loadNibNamed:@"Empty" owner:nil options:nil]lastObject];
    
}
- (void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    self.iconView.image = [UIImage imageNamed:icon];
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    [self.ttileView setTitle:title forState:UIControlStateNormal];
}
@end

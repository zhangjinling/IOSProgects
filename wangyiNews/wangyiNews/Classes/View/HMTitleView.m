//
//  HMTitleView.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMTitleView.h"

@implementation HMTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self setImage:[UIImage imageNamed:@"navbar_netease"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:23];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.height = self.currentImage.size.height;
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    [self setTitle:title forState:UIControlStateNormal];
    NSDictionary *attrs = @{NSFontAttributeName:self.titleLabel.font};
    CGFloat titlew = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    self.width = titlew + self.titleEdgeInsets.left + self.currentImage.size.width;
    
}
@end

//
//  HWTitleButton.m
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//  标题按钮

#import "HWTitleButton.h"

@implementation HWTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片居中不拉伸
//        self.imageView.contentMode = UIViewContentModeCenter;
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
//目的：想在系统设置完尺寸之后在设置一下尺寸
/**
 *  重写setFrame目的：拦截设置按钮尺寸的过程
 *  如果想在系统设置完控件尺寸后  在做修改，一半都在setFrame里设置
 *  @param frame
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.width += 10;
    [super setFrame:frame];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //1.计算titlelabel的frame

    self.titleLabel.x = self.imageView.x;
    
    //2.计算imageView 的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
    

}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end

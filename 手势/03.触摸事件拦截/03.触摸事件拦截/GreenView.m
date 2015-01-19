//
//  GreenView.m
//  03.触摸事件拦截
//
//  Created by Seven on 15/1/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "GreenView.h"

@implementation GreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了green视图");
}

@end

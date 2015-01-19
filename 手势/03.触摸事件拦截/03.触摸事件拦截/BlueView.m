//
//  BlueView.m
//  03.触摸事件拦截
//
//  Created by Seven on 15/1/18.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blueColor]];
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了blue视图");
}

@end

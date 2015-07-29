//
//  HWUser.m
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//  微博用户模型

#import "HWUser.h"

@implementation HWUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

@end

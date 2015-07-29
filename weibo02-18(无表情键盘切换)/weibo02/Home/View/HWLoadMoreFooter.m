//
//  HWLoadMoreFooter.m
//  weibo02
//
//  Created by Seven on 15/7/9.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil]lastObject];
}

@end

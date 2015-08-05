//
//  HMRightCenterRow.m
//  wangyiNews
//
//  Created by Seven on 15/8/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMRightCenterRow.h"

@implementation HMRightCenterRow


+ (instancetype)centerViewRow
{
    return [[[NSBundle mainBundle]loadNibNamed:@"Empty" owner:nil options:nil]lastObject];
    
}

@end

//
//  HWStatus.m
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//  微博

#import "HWStatus.h"
#import "MJExtension.h"
#import "HWPhoto.h"

@implementation HWStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[HWPhoto class]};
}

@end

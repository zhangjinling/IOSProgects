//
//  ZJLUser.m
//  qiubai
//
//  Created by Seven on 15/7/31.
//  Copyright (c) 2015年 seven. All rights reserved.
//  糗百用户模型

#import "ZJLUser.h"
#import "MJExtension.h"
@implementation ZJLUser

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"idstr": @"id"};
}


@end

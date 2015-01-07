//
//  SettingItem.m
//  04.系统设置不完整new
//
//  Created by Seven on 15/1/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem
+(id)settingItemWithDict:(NSDictionary *)dict
{
    SettingItem *s = [[SettingItem alloc]init];
    
    s.name = dict[@"name"];
    s.detail = dict[@"detail"];
    s.identifier = dict[@"id"];
    
    return s;
}
@end

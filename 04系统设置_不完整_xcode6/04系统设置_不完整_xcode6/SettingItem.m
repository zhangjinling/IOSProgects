//
//  SettingItem.m
//  04系统设置_不完整_xcode6
//
//  Created by Seven on 15/1/13.
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
    
    s.hasSwitch = [dict[@"hasSwitch"]boolValue];
    s.switchValue = [dict[@"switchValue"]boolValue];
    return s;
}
@end

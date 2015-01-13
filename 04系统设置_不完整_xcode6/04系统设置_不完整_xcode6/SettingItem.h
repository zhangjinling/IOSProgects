//
//  SettingItem.h
//  04系统设置_不完整_xcode6
//
//  Created by Seven on 15/1/13.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject

+ (id)settingItemWithDict:(NSDictionary *)dict;

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *detail;
@property(strong,nonatomic) NSString *identifier;

//一下是开关控件的设置
@property(assign,nonatomic)BOOL hasSwitch;
@property(assign,nonatomic)BOOL switchValue;
@end

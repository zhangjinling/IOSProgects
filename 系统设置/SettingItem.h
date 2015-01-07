//
//  SettingItem.h
//  04.系统设置不完整new
//
//  Created by Seven on 15/1/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject

+ (id)settingItemWithDict:(NSDictionary *)dict;

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *detail;
@property (strong,nonatomic) NSString *identifier;
@end

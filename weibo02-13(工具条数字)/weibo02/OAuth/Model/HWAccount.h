//
//  HWAccount.h
//  weibo02
//
//  Created by Seven on 15/7/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject<NSCoding>

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSNumber *expires_in;

@property (nonatomic, copy) NSString *uid;

//accessToken的创建时间
@property (nonatomic, strong) NSDate *created_time;
//用户昵称
@property (nonatomic, copy) NSString *name;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end

//
//  HWUser.h
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface HWUser : NSObject
//用户ID
@property (nonatomic, copy) NSString *idstr;
//用户昵称
@property (nonatomic, copy) NSString *name;
//头像
@property (nonatomic, copy) NSString *profile_image_url;
//会员类型  >2  代表是会员
@property (nonatomic, assign) int mbtype;
//会员等级
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign ,getter=isVip) BOOL vip;
@end

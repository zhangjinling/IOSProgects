//
//  HWAccountTool.h
//  weibo02
//
//  Created by Seven on 15/7/6.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWAccount.h"

@interface HWAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(HWAccount *)account;

/**
 *  获得账户信息 并判断是否过期
 *
 *  @return 返回账户模型(如果过期 返回nil)
 */
+ (HWAccount *)account;
@end

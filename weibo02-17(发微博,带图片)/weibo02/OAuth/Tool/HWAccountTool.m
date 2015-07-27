//
//  HWAccountTool.m
//  weibo02
//
//  Created by Seven on 15/7/6.
//  Copyright (c) 2015年 seven. All rights reserved.
//  处理账号相关的所有操作：1.存储账号   2.取出账号

//账号的存储路径
#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"account.archive"]

#import "HWAccountTool.h"
#import "HWAccount.h"

@implementation HWAccountTool


/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(HWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];

}
/**
 *  返回账号信息
 *
 *  @return 返回账号信息（过期返回nil）
 */
+ (HWAccount *)account
{
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    long expires_in = [account.expires_in longLongValue];
    
    //判断是否过期
    NSDate *expiteTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    //获得当前时间
    NSDate *now = [NSDate date];
    //若果now大于expiteTime  意味着过期
    //NSOrderedAscending = -1L----》升序：右边  >  左边
    //NSOrderedSame,        ------》 相同
    //NSOrderedDescending    ------》 降序： 右边 < 左边
    NSComparisonResult result = [expiteTime compare:now];
    if(result != NSOrderedDescending){//过期
        return nil;
    }
    HWLog(@"%@---%@",expiteTime,now);
    
    return account;
}
@end

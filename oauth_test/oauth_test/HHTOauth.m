//
//  HHTOauth.m
//  oauth_test
//
//  Created by Seven on 15/8/21.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HHTOauth.h"
#import <CommonCrypto/CommonDigest.h>

#define sessionkey @"cclient"
#define secret @"2635220a1f53"


@implementation HHTOauth
+ (NSDictionary *)HHTOauthWithDictionary:(NSMutableDictionary *)dict
{
    //加密要使用的字典键值：出去restauth和Filedata
    dict[@"sessionkey"] = @"cclient";
    dict[@"resttime"] = [self timeStamp];
    NSMutableArray *keyArr = [NSMutableArray array];
    for (NSString *str in dict) {
        [keyArr insertObject:str atIndex:0];
    }
    
    NSArray *sortedArray = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];

//    NSMutableDictionary *prarma = [NSMutableDictionary dictionary];
    NSString *queryString = [NSString string];
    for (NSString *str in sortedArray) {
//        [prarma setValue:dict[str] forKey:str];
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",str,dict[str]]];
    }
    queryString = [queryString stringByAppendingString:secret];
    NSLog(@"待加密的字符串：%@",queryString);
    dict[@"restauth"] = [self MD5WithString:queryString];
    return dict;
}

/**
 *  返回一个1970年到现在的字符串
 *
 *  @return 返回1970到现在的秒数
 */
+ (NSString *)timeStamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval second=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", second];
//    return timeString;
    return @"1440137713";
}

/**
 *  MD5加密字符串
 *
 *  @param str 待加密的字符串
 *
 *  @return 返回已加密的字符串
 */
+ (NSString *)MD5WithString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result);
    return [[NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ] lowercaseString];
}
@end

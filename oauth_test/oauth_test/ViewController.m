//
//  ViewController.m
//  oauth_test
//
//  Created by Seven on 15/8/17.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"
#import "OrderedDictionary.h"
#import "SortDictionary.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    MutableOrderedDictionary *dict = [MutableOrderedDictionary dictionary];
    [dict insertObject:@"76104" forKey:@"teacherid" atIndex:0];
    [dict insertObject:@"10" forKey:@"pageSize" atIndex:0];
    [dict insertObject:@"1" forKey:@"currentPage" atIndex:0];


    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    dict[@"time"] = timeString;
    
    dict[@"secret"] = @"52f4133a5d45";

    NSLog(@"%@",[[SortDictionary sortDictionary:dict] stringByAppendingString:dict[@"secret"]]);
//    for (NSString *str in sortDict) {
//        //queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",str,sortDict[str]]];
//        NSLog(@"%@",str);
//    }
    
//    dict[@"secret"] = @"52f4133a5d45";
//    NSLog(@"queryString:%@",queryString);
//    NSString *preMD5 = [queryString stringByAppendingString:dict[@"secret"] ];
//
//
//
//    NSLog(@"MD5后：%@",[self md5:preMD5]);
    NSString *restauth = [NSString stringWithString:[self md5:[[SortDictionary sortDictionary:dict] stringByAppendingString:dict[@"secret"]]]];
    
    [dict insertObject:restauth forKey:@"restauth" atIndex:0];
    NSLog(@"restauth:%@",dict);
//
//    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://edu.honghe-tech.com/api/hwork/howeowrkList" parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

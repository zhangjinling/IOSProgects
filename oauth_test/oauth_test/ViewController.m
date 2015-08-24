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
#import "SortDictionary.h"
#import "HHTOauth.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //30135f69d25be9ca5e7e459c8693833b
    //d7c74bd2e161cd4196cfb00e0f621585
    //resttime=1440137713&sessionkey=cclient&classid=385&restauth=d7c74bd2e161cd4196cfb00e0f621585&classname=%E6%B5%8B%E8%AF%951&uid=77302
//
    dict[@"classid"] = @"385";
    dict[@"classname"] = @"测试1";
    dict[@"uid"] = @"77302";

    dict[@"sessionkey"] =@"cclient";
    NSLog(@"未被处理的：dict:%@",dict);
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    dict[@"resttime"] = @"1440137713";

    NSString *queryString = [SortDictionary sortDictionary:dict];
    dict[@"secret"] = @"2635220a1f53";
    NSLog(@"queryString:%@",queryString);
    NSString *preMD5 = [queryString stringByAppendingString:dict[@"secret"] ];

    NSLog(@"MD5后：%@",[self md5:preMD5]);
    dict[@"secret"] = @"2635220a1f53";

    NSString *preString =[SortDictionary sortDictionary:dict];
    NSString *pprestring = [preString stringByAppendingString:dict[@"secret"]];
    NSLog(@"加密前：%@",preString);
    NSString *restauth = [NSString stringWithString:[self md5:pprestring]];
    restauth = [restauth lowercaseString];
    

    
    dict[@"restauth"] =restauth;
    NSLog(@"restauth:%@",dict);

    [dict removeObjectForKey:@"secret"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:@"http://edu.honghe-tech.com/api/group/teacherByParentid" parameters:dict success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"************%@",responseObject);
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


/**
 *  测设api
 *
 *  @param sender 点击的button
 */
- (IBAction)testTheOauth:(UIButton *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //?sessionkey=cclient&
//    resttime=1440041669&
//    restauth=34aaf25463e733632d61c40066b9d2c8&
//    teacherId=76104

    dict[@"classid"] = @"385";
    dict[@"classname"] = @"测试1";
    dict[@"uid"] = @"77302";
    NSMutableDictionary *parama = [NSMutableDictionary dictionaryWithDictionary:[HHTOauth HHTOauthWithDictionary:dict]];
    NSLog(@"test:%@",parama);
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:@"http://edu.honghe-tech.com/api/appnew/searchIndexs" parameters:parama success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功：%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

@end

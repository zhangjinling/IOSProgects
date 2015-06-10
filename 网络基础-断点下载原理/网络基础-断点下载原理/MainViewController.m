//
//  MainViewController.m
//  网络基础-断点下载原理
//
//  Created by Seven on 15/6/9.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self download];
}
#pragma mark - 下载
- (void)download
{
    //1.NSURL
    NSURL *url = [NSURL URLWithString:@"http://localhost/upload/upload/1.docx"];
    //2.NSURLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //使用head方法获取目标文件信息，而不做实际的下载工作。
//    [request setHTTPMethod:@"HEAD"];
    /*
     实现断点续传的思路：
     HeaderField：头域（请求头部的字段）
     可以通过指定range的范围逐步下载指定范围的数据，待下载完成之后，拼接成文件。
     */
    [request setValue:@"bytes=0-499" forHTTPHeaderField:@"range"];

    //NSURLConnection
    NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSLog(@"文件大小：%lld %lu",[response expectedContentLength],(unsigned long)data.length);
    
}


@end

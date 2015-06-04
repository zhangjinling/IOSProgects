//
//  MainViewController.m
//  UIWebview
//
//  Created by Seven on 15/5/30.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property(weak,nonatomic)UIWebView *webView;
@end

@implementation MainViewController
/**
 
 //webView加载本地文件 可以使用加载数据的方式
 //NSData:本地文件对应的数据
 //MIMEType  ： 类型
 //textEncodingName  编码
 //baseURL  一般加载本地文件不使用，可以再指定的baseURL中查找相关文件

 UIWebView加载内容的三种方式：
    1.加载本地数据文件
    2.加载html字符串
    3.加载NSUrlRequest
 **/
#pragma mark - 设置界面
- (void)setupUI
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    //检测所有数据类型
    [webView setDataDetectorTypes:UIDataDetectorTypeAll];
    self.webView =webView;
    [self.view addSubview:webView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

//    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.txt" ofType:nil];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSLog(@"%@",[self mimeType:url]);
////    NSData *data = [NSData dataWithContentsOfFile:path];
//    [self.webView loadHTMLString:@"<h1>zhangjinling</h1>" baseURL:nil];
    NSURL *url = [NSURL URLWithString:@"http://localhost/01"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.webView loadRequest:request];
    
    
}
#pragma mark - 加载html
- (void)loadHtml
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.html" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSLog(@"%@",[self mimeType:url]);
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"UFT-8" baseURL:nil];
    

}
#pragma mark - 加载pdf
- (void)loadPDF
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.pdf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSLog(@"%@",[self mimeType:url]);
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"UFT-8" baseURL:nil];
    
}
#pragma mark - 加载文本文件
- (void)loadTxt
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"1.txt" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSLog(@"%@",[self mimeType:url]);
    NSData *data = [NSData dataWithContentsOfFile:path];
    [self.webView loadData:data MIMEType:@"text/plain" textEncodingName:@"UFT-8" baseURL:nil];
    
}
#pragma mark - 获取指定URL的MIME type 类型
- (NSString *)mimeType:(NSURL *)url
{
    //1.NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2.NSURLConnection
    //从NSURLResponse 可以获取服务器返回的MIMEType
    //使用同步方法获取MIME
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
     return response.MIMEType;
}
@end

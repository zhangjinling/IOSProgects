//
//  HWOAuthViewController.m
//  weibo02
//
//  Created by Seven on 15/7/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HWAccountTool.h"
@interface HWOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建webView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //webView加载登陆界面
    //参数：client_id   redirect_uri
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2827338198&redirect_uri=http://jianshu.com&display=mobile"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
#pragma mark - webView 的代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //加载失败
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获得url
    NSString *url = request.URL.absoluteString;
    //判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        //获取code后面的数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        HWLog(@"获得的 code： %@",code);
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    //1.请求的管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"2827338198";
    params[@"client_secret"] = @"890a7f92e04163af403f66a9c85079de";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://jianshu.com";
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        HWLog(@"%@",responseObject);
        //存储账号
        HWAccount *account = [HWAccount accountWithDict:responseObject];
        [HWAccountTool saveAccount:account];
        //切换窗口的跟控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        //UIWindow 的分类，windowTool
        //UIViewController的分类  、controllerTool
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];

        HWLog(@"请求失败%@",error);
    }];
}
@end

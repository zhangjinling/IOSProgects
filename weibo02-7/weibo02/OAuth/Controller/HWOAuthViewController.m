//
//  HWOAuthViewController.m
//  weibo02
//
//  Created by Seven on 15/7/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWOAuthViewController.h"
#import "AFNetworking.h"
#import "TabBarViewController.h"
#import "HWNewFeatureViewController.h"
#import "HWAccount.h"
#import "MBProgressHUD+MJ.h"
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
        //将返回的账号数据--->转换为model，存入沙盒
        //沙盒路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString * path = [doc stringByAppendingPathComponent:@"account.archive"];
        HWAccount *account = [HWAccount accountWithDict:responseObject];
        //account模型写入文件,自定义对象的存储必须使用NSKeyedArchiver
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        //切换窗口的跟控制器
        //说明之前已经登录过
        NSString *key = @"CFBundleVersion";
        //存取在沙盒中上一次的版本号
        //有可能为空   第一次进入
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        //获得软件当前的版本号info.plist中获得
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
        //        //将版本号存入沙盒
        //        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //        //内存中的数据马上同步到沙盒
        //        [[NSUserDefaults standardUserDefaults] synchronize];
        //判断是否为新版本
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if([currentVersion isEqualToString:lastVersion]){//这次打开的版本号相同
            window.rootViewController = [[TabBarViewController alloc]init];
        }else{//显示新特性
            window.rootViewController = [[HWNewFeatureViewController alloc]init];
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];

        HWLog(@"请求失败%@",error);
    }];
}
@end

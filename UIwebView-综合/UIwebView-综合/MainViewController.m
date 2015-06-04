//
//  MainViewController.m
//  UIwebView-综合
//
//  Created by Seven on 15/5/31.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITextFieldDelegate>
@property(weak,nonatomic)UIWebView *webView;
@end

@implementation MainViewController
/*
 1.在地址栏中输入要访问的地址，按下回车，webview中加载地址栏中的内容
 2.输入file://开口的地址加载沙箱中的文件
 */
#pragma mark - 设置UI
- (void)setupUI
{
    //1.顶部toolbar
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 20, 320, 44)];
    [self.view addSubview:toolbar];
    //1>.1个textField (textField 以自定义视图的形式加入到toolbar)
    UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(10, 26, 200, 32)];
    //设置边框、设置对其、设置清楚按钮
    [textfield setBorderStyle:UITextBorderStyleRoundedRect];
    [textfield setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [textfield setClearButtonMode:UITextFieldViewModeWhileEditing];
    [textfield setDelegate:self];
    UIBarButtonItem *addressItem = [[UIBarButtonItem alloc]initWithCustomView:textfield];
    //2>.三个按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBack)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForward)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    //将UIBarButtonItem加入boolbar
    [toolbar setItems:@[addressItem,item1,item2,item3]];
    //2.UIWebView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height - 64)];
    [self.view addSubview:webView];
    self.webView = webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}
#pragma mark - UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //1.关闭键盘
    [textField resignFirstResponder];
    //2.让webview加载地址栏中的内容,如果没有内容不加载
    //关于字符串的比较  是属于消耗性能的 在判断是否有内容时，可以使用长度是否为0
    if(textField.text.length > 0){
        [self loadContentWithURLString:textField.text];
    }
    
    return YES;
}
#pragma mark - 加载内容
- (void)loadContentWithURLString:(NSString *)urlString
{
    //针对urlStrig进行判断
    //1.如果是http开头说明是web地址
    if([urlString hasPrefix:@"http://"]){
        [self loadURL:[NSURL URLWithString:urlString]];
    }else if ([urlString hasPrefix:@"file://"]){
        NSRange range = [urlString rangeOfString:@"file://"];
        NSString *fileName = [urlString substringFromIndex:range.length];
        
        NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        [self loadURL:url];
        NSLog(@"%@",fileName);
        
    }else{
        NSLog(@"error");
    }
    //2.如果是file开头说明是加载沙箱的文件
        //1》取出文件名
        //2>加载文件
    //3.错误判断 输入错误地址 提示用户
    
    
//    NSString *newurlString = [NSString stringWithFormat:@"http://%@",urlString];

}
- (void)loadURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}
#pragma mark - Actions
#pragma mark 后对
- (void)goBack
{
    [self.webView goBack];
    NSLog(@"后退");
}
#pragma mark 前进
- (void)goForward
{
    [self.webView goForward];
    NSLog(@"前进");
}
#pragma mark 刷新
- (void)refresh
{
    [self.webView reload];
    NSLog(@"刷新");
}

@end

//
//  HWComposeViewController.m
//  weibo02
//
//  Created by Seven on 15/7/22.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWComposeViewController.h"
#import "HWAccountTool.h"
#import "HWPlaceholderTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HWComposeToolbar.h"

@interface HWComposeViewController ()<UITextViewDelegate>
/** 输入控件 */
@property (nonatomic, weak)HWPlaceholderTextView *textview;
/** 发微博工具条 */
@property (nonatomic, weak) HWComposeToolbar *toolbar;
@end

@implementation HWComposeViewController
#pragma mark - 系统初始化方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏内容
    [self setNav];
    //添加输入控件
    [self setTextView];
    
    //添加工具条
    [self setupToolbar];
    //默认是yes，当scrollview遇到uinavigationbar，uitabbar等控件时，默认会设置contentInsert
//    self.automaticallyAdjustsScrollViewInsets = YES;
}
- (void) dealloc
{
    [HWNotificationCenter removeObserver:self];
}
#pragma mark - 初始化方法
/**
 *  设置导航栏
 */
- (void)setNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" 取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" 发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [HWAccountTool account].name;
    NSString *prefix = @"发微博";

    if (name) {
        UILabel *titleView = [[UILabel alloc]init];
        //    titleView.text =[NSString stringWithFormat:@"发微博%@",[HWAccountTool account].name];
        titleView.width = 200;
        titleView.height = 44;
        titleView.numberOfLines = 0;
        NSString *name = [HWAccountTool account].name;
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        //创建一个带有属性的字符串（字体颜色，属性）
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        //添加属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        titleView.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = titleView;
        
    }else{
        self.navigationItem.title = prefix;
    }
    

    //    self.navigationItem.title = [NSString stringWithFormat:@"发微博\r\n%@",[HWAccountTool account].name];
    

}
/**
 *  设置微博发送的工具栏
 */
- (void)setupToolbar
{
    HWComposeToolbar *toolbar = [[HWComposeToolbar alloc]init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    [self.view addSubview:toolbar];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    self.toolbar = toolbar;
//    self.textview.inputAccessoryView = toolbar;
    //inputView设置(把键盘替换)键盘
//    self.textview.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //在系统键盘的顶部会出现button
//    self.textview.inputAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}
- (void)setTextView
{
    HWPlaceholderTextView *textView = [[HWPlaceholderTextView alloc]init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
//    textView.placeholderColor = [UIColor redColor];
    textView.frame = self.view.bounds;
    //垂直方向上允许拖拽 （弹簧效果）
    textView.alwaysBounceVertical = YES;
    //遵守textview代理
    textView.delegate = self;
    self.textview = textView;
    [self.view addSubview:textView];
    //一旦成为第一响应者（能输入文本的控件）就能呼出响应的键盘
    [textView becomeFirstResponder];
    //文字改变的通知，监听发送按钮的状态
    [HWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //键盘弹出关闭的通知
    [HWNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
#pragma mark - 监听方法
/**
 *  键盘的frame发生改变时调用（显示、隐藏）
 *
 *  @param notification 键盘通知内容
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
//    HWLog(@"%@",notification);
    //notification 的内容
    /**
     //键盘弹出开始时的高度
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 409}, {375, 258}},
     UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 796},
     UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}},
     //键盘弹出结束时的高度
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 667}, {375, 258}},
     //键盘弹出耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 538},
     //键盘弹出或者隐藏的动画执行节奏
     UIKeyboardAnimationCurveUserInfoKey = 7
     **/
    NSDictionary *userInfo = notification.userInfo;
    //动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //执行动画。
    [UIView animateWithDuration:duration animations:^{
        //工具条的Y值 = 键盘的Y值 - 工具条的高度
        self.toolbar.y = keyboardFrame.origin.y - self.toolbar.height;
    }];
    
}
- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    [self.view endEditing:YES];
    //https://api.weibo.com/2/statuses/update.json
    //1.请求的管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textview.text;
    params[@"access_token"] = [HWAccountTool account].access_token;
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HWLog(@"%@",responseObject);
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        HWLog(@"请求失败%@",error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  设置发送按钮是否可用
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textview.hash;
}
#pragma mark - UITextView代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end

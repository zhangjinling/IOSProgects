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
#import "HWComposePhohosView.h"
#import "HWEmotionKeyboard.h"

@interface HWComposeViewController ()<UITextViewDelegate,HWComposeToolbarDelegate,UINavigationBarDelegate,UIImagePickerControllerDelegate>
/** 输入控件 */
@property (nonatomic, weak)HWPlaceholderTextView *textview;
/** 发微博工具条 */
@property (nonatomic, weak) HWComposeToolbar *toolbar;
/** 相册（存放从相册或拍照那个中选择的图片） */
@property(nonatomic, weak)HWComposePhohosView *photosView;
/** 表情键盘 */
@property (nonatomic, strong) HWEmotionKeyboard *emotionKeyboard;
/** 是否修改键盘toolbar的frame的标志位 */
@property (nonatomic, assign) BOOL *switchKeyboard;
@end

@implementation HWComposeViewController

#pragma mark - 懒加载
- (HWEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[HWEmotionKeyboard alloc]init];
    }
    return _emotionKeyboard;
}

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
    
    //添加相册
    [self setupPhotosView];
}
- (void) dealloc
{
    [HWNotificationCenter removeObserver:self];
}
#pragma mark - 初始化方法
/**
 *  添加相册
 */
- (void)setupPhotosView
{
    HWComposePhohosView *photosView = [[HWComposePhohosView alloc]init];
//    photosView.backgroundColor = HWRandomColor;
    photosView.y = 100;
    photosView.width = self.view.width;
    photosView.height = self.view.height;//此高度可以随便设置
    [self.textview addSubview:photosView];
    self.photosView = photosView;
}

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
    toolbar.delegate = self;
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
    if (self.switchKeyboard) return;
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
    
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *  发布带图片的微博
 */
- (void)sendWithImage
{
    //1.请求的管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textview.text;
    params[@"access_token"] = [HWAccountTool account].access_token;
    

    //发送有图的微博
    [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSMutableData *data =[NSMutableData data];
        [data appendData:UIImageJPEGRepresentation(image, 1.0)];
        UIImage *image2 = [self.photosView.photos lastObject];
        [data appendData:UIImageJPEGRepresentation(image2, 1.0)];

        [formData appendPartWithFileData:data name:@"pic" fileName:@"pic" mimeType:@"image/jpeg"];
        
        

    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HWLog(@"%@",responseObject);
        [MBProgressHUD showSuccess:@"发布成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        HWLog(@"请求失败%@",error);
        
    }];

}
/**
 *  发布有图的微博
 */
-(void)sendWithoutImage
{
    //1.请求的管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    //2.请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textview.text;
    params[@"access_token"] = [HWAccountTool account].access_token;
    

    //3.发送请求 发无图的微博
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HWLog(@"%@",responseObject);
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        HWLog(@"请求失败%@",error);
    }];

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
#pragma mark - HWComposerToolbarDelegate
- (void)composeToolbar:(HWComposeToolbar *)toolbar DidClickButton:(HWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HWComposeToolbarButtonTypeCamera://拍照
            [self openCamera];
            break;
        case HWComposeToolbarButtonTypePicture://相册
            [self openAlbum];
            break;
        case HWComposeToolbarButtonTypeMention://@
            HWLog(@"%lu--@@@",(unsigned long)index);

            break;
        case HWComposeToolbarButtonTypeTrend://#话题
            HWLog(@"%lu--话题",(unsigned long)index);

            break;
        case HWComposeToolbarButtonTypeEmotion://表情、键盘
            [self switchKeyboward];
            break;
            
        default:
            break;
    }
}
#pragma mark - 其他方法
- (void)switchKeyboward
{
    self.switchKeyboard = YES;
    if (self.textview.inputView == nil) {
        //切换为表情键盘
        HWEmotionKeyboard *emotionKeyword = self.emotionKeyboard;
        emotionKeyword.width = self.view.width;
        emotionKeyword.height = 216;
        self.textview.inputView = emotionKeyword;
        //显示键盘表情
        self.toolbar.showEmotionBtn = NO;
    }else{
        //切换为表情键盘（当前使用的是系统键盘)
        self.textview.inputView = nil;
        self.toolbar.showEmotionBtn = YES;

    }
    //退出键盘的几种方法
    [self.view endEditing:YES];
//    [self.textview endEditing:YES];
//    [self.textview resignFirstResponder];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textview becomeFirstResponder];
        self.switchKeyboard = NO;
    });
}
- (void)openCamera
{
    //如果向自己写一个续篇选择控件，可以利用AccetsLibrary.framework 利用这个框架可以获得手机的所有图片
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
- (void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) {
        HWLog(@"相机不可以使用");
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark -UIImagePickerControllerDelegate代理方法
/**
 *  从控制器选择玩图片后（拍照完毕或者选择图片完毕）
 *
 *  @param picker <#picker description#>
 *  @param info   <#info description#>
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    HWLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //添加图片到photosView中
    [self.photosView addPhoto:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end

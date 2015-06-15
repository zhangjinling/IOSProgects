//
//  ViewController.m
//  afnetworking
//
//  Created by Seven on 15/6/13.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)upload:(UIButton *)sender;
@property(weak,nonatomic)UIActionSheet *sheet;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self playUpload];
}

#pragma mark - 拍照上传
- (void)playUpload
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册",nil ];
    self.sheet = sheet;
    [sheet showInView:self.view.window];
    //查看图片源或者相机是否可用
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"不可用");
//        return;
//    }
//    //1.上传手机上的图片(拍照 相册)
//    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
//    //设置图片来源
//    //    UIImagePickerControllerSourceTypePhotoLibrary,
//    //    UIImagePickerControllerSourceTypeCamera,
//    //    UIImagePickerControllerSourceTypeSavedPhotosAlbum
//
//    //照相机
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//    //图片库
////    ipc.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
//    //设置代理
//    ipc.delegate = self;
//    
//    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate 代理
//在选择玩图片调用：info 中包含图片信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //销毁信号片 或者 图像view
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    NSLog(@"%@",image);
}
#pragma mark - actionsheet代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];

    switch (buttonIndex) {
        case 0://拍照
        {
            //查看图片源或者相机是否可用
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                NSLog(@"不可用");
                return;
            }
            //1.上传手机上的图片(拍照 相册)
            //设置图片来源
            //    UIImagePickerControllerSourceTypePhotoLibrary,
            //    UIImagePickerControllerSourceTypeCamera,
            //    UIImagePickerControllerSourceTypeSavedPhotosAlbum
            
            //照相机
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            //图片库
            //    ipc.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        case 1://相册
        {
            //查看图片源或者相机是否可用
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                NSLog(@"不可用");
                return;
            }
            //1.上传手机上的图片(拍照 相册)
            //设置图片来源
            //    UIImagePickerControllerSourceTypePhotoLibrary,
            //    UIImagePickerControllerSourceTypeCamera,
            //    UIImagePickerControllerSourceTypeSavedPhotosAlbum
            
            //照相机
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //图片库
            //    ipc.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        }
        default:
            break;
    }
    //设置代理
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:nil];
    

}
#pragma mark - 文件上传
- (void)fileUpload
{
    //1.创建一个管理职
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.发送一个请求
    NSString *url = @"http://localhost/upload/upload.php";
    //封装参数(字典只能放份文件参数)
    NSDictionary *dict = @{
                           @"username":@"123",
                           @"age":@33
                           };
    [mgr POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //在发送请求之前会自动调用这个方法
        //在这个block添加文件参数到formdata中
        /*
         第一种：
         fileURL:需要上传文件的URL路径
         name：服务器接收文件用的参数名
         filename：所上传文件的文件名称
         mimeType：所上传的文件的文件类型
         */
        //bundle 中获取文件
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"123" withExtension:@"txt"];
        [formData appendPartWithFileURL:url name:@"file" fileName:@"hehe.txt" mimeType:@"text/plain" error:nil];
        /*
         第二种：
         fileData:需要上传文件的具体数据
         name：服务器接收文件用的参数名
         filename：所上传文件的文件名称
         mimeType：所上传的文件的文件类型
         */
//        UIImage *image = [UIImage imageNamed:@"123.jpg"];
//        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//        [formData appendPartWithFileData:data name:@"file" fileName:@"haha.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传成功，%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败-----%@",error);
    }];
    

}
#pragma mark - post 请求  返回json
- (void)postJson
{
    //1.创建一个操作请求的管理证
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //请求参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"username"] = @"zhangjl";
    dict[@"password"] = @"zhjl";
    NSString *url = @"http://localhost/01/post.php";
    [mgr POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSLog(@"formdata--- %@",formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功-%@",responseObject[@"message"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败--%@",error);
    }];
}
#pragma mark - 获得数据
- (void)getData
{
    //1.创建请求对象管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //声明一下 服务器返回使用http 默认的方式返回数据，不是xml json比如下载文件
    //不要对数据库返回的数据格式化
    //如果是文件下载 肯定是这个
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //2.接下来发送get请求
    NSString *url = @"http://localhost/01/get.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"张金玲";
    params[@"password"] = @"zhjl";
    [mgr GET: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功的时候调用
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict[@"message"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败时候调用
        NSLog(@"请求失败");
    }];
    
}
#pragma mark - get请求xml
- (void)getXML
{
    //1.创建请求对象管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //声明一下 服务器返回的是xml格式数据
    mgr.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //2.接下来发送get请求
    NSString *url = @"http://localhost/01/xml.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"username"] = @"张金玲";
//    params[@"password"] = @"zhjl";
    [mgr GET: url parameters:params success:^(AFHTTPRequestOperation *operation, NSXMLParser *responseObject) {
        //请求成功的时候调用
        //xml  自己解析
        NSLog(@"请求成功---%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败时候调用
        NSLog(@"请求失败");
    }];

}
#pragma mark - get请求gson
- (void) getJSON
{
    //1.创建请求对象管理
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //声明一下 服务器返回的是json格式数据  默认就是json
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];

    //2.接下来发送get请求
    NSString *url = @"http://localhost/01/get.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"张金玲";
    params[@"password"] = @"zhjl";
    [mgr GET: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功的时候调用
        NSLog(@"请求成功---%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //请求失败时候调用
        NSLog(@"请求失败");
    }];

}
- (IBAction)uploadBtn:(id)sender {
}
- (IBAction)upload:(UIButton *)sender {
    if (self.imageView.image == nil) {
//        [self.sheet showInView:self.view.window];
    }else{
        //1.创建一个管理职
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        
        //2.发送一个请求
        NSString *url = @"http://localhost/upload/upload.php";
        //封装参数(字典只能放份文件参数)
        NSDictionary *dict = @{
                               @"username":@"123",
                               @"age":@33
                               };
        [mgr POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 1.0f);
        [formData appendPartWithFileData:data name:@"file" fileName:@"haha.jpg" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"上传成功，%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"上传失败-----%@",error);
        }];

    }
}
@end

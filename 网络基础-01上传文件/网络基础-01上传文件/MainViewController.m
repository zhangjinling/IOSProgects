//
//  MainViewController.m
//  网络基础-01上传文件
//
//  Created by Seven on 15/6/9.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property(weak,nonatomic)UIImageView *imageView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //定义imageView并设置图像
    UIImage *image = [UIImage imageNamed:@"1.png"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:CGRectMake(60, 20, 200, 200)];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    //添加一个上传按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(60, 240, 200 , 40)];
    [button setTitle:@"上传" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}
#pragma mark - 上传图像
- (void)uploadImage
{
    //需要使用http的POST方法，上传文件
    //调用的URL是http://localhost/upload/
    //URL数据体的参数名：file
    //1.建立URL
    NSURL *url = [NSURL URLWithString:@"http://localhost/upload/upload.php"];
    //2.建立NSURLMutableRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //2-1设置request属性的主体
    [request setHTTPMethod:@"POST"];
    //2-2设置数据体
    //2-2-1设置boundary的字符串，以便复用
    NSString *boundary = @"uploadBoundary";
    //2-2-2头部字符串
    NSMutableString *startStr = [NSMutableString string];
    [startStr appendFormat:@"--%@",boundary];
    [startStr appendString:@"Content-Disposition: form-data;name=\"file\"; filename=\"1.png\"\n"];
    [startStr appendString:@"Content-type: image/png\n\n"];
    //2-2-3尾部字符串
    NSMutableString *endStr = [NSMutableString string];
    [endStr appendFormat:@"--%@\n",boundary];
    [endStr appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [endStr appendString:@"Submit\n"];
    [endStr appendFormat:@"--%@--",boundary];
    //2-2-4拼接数据体
    NSMutableData *bodyData = [NSMutableData data];
    [bodyData appendData:[startStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *imagedata = UIImagePNGRepresentation(self.imageView.image);
    [bodyData appendData:imagedata];
    [bodyData appendData:[endStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:bodyData];
    //2-2-5指定content-type
    NSString *contentStr = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
    [request setValue:contentStr forHTTPHeaderField:@"Content-type"];
    //2-2-6指定content-length
    NSUInteger lenght = [bodyData length];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)lenght] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:bodyData];

    //3.建立NSURLMutableConnection同步方法上传文件，因为需要用户确认文件是否上传成功
    //在http上传文件是有大小限制的，一般不会超过2M
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *resutlStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",resutlStr);
    
    
    
    
    NSLog(@"upload");
}

@end

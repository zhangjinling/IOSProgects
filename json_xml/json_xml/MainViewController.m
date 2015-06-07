//
//  MainViewController.m
//  json_xml
//
//  Created by Seven on 15/6/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import "Video.h"
#import "VideoCell.h"

static NSString *ID = @"MyCell";


#define kBaseURL @"http://localhost/02/"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong ,nonatomic) NSArray *dataList;
@property (strong ,nonatomic) UITableView *tableView;
@end

@implementation MainViewController

#pragma mark - 实例化视图
- (void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    //1.tableview
    CGRect frame = self.view.bounds;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
    //1.1数据源
    [tableView setDataSource:self];
    //1.2代理
    [tableView setDelegate:self];
    //1.3设置表格高度
    [tableView setRowHeight:80.0];
    //1.4设置分割线
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    //2.toolbar
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, tableView.bounds.size.height-24,320, 44)];
    [self.view addSubview:toolbar];
    //添加toolbar按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"load json" style:UIBarButtonItemStyleDone target:self action:@selector(loadjson)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"load xml" style:UIBarButtonItemStyleDone target:self action:@selector(loadxml)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:@[item3,item1,item3,item2,item3]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //注册可重用单元格
    [self.tableView registerClass:[VideoCell class] forCellReuseIdentifier:ID];
}
#pragma mark - UITableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.使用可重用标示符查询可常用单元格
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //注册可重用单元格之后就不用使用以下实例化方法
    
    //    if (cell == nil) {
//        cell = [[VideoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    //设置单元格内容
    Video *v = self.dataList[indexPath.row];
    cell.textLabel.text = v.name;
    cell.detailTextLabel.text = v.teacher;
    cell.lengthlabel.text = v.lengthStr;
    //设置右侧箭头
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    //1>.同步加载网络图片
    //注意：在开发网络应用时  ， 不要使用同步加载图片  否则会严重影响用户体验
//    NSString *imagePath = [NSString stringWithFormat:@"%@%@",kBaseURL,v.imageURL];
//    NSURL *imageURL = [NSURL URLWithString:imagePath];
//    
//    NSData *data = [NSData dataWithContentsOfURL:imageURL];
//    UIImage *image = [UIImage imageWithData:data];
    //2>.异步加载网络图片
    //gcd , nsoperation , nsthread
    //网络连接本身就有异步命令sendAsync
    if(v.cacheImage == nil){
        //表示缓存图像不存在,既能保证有图像，又能占位
        UIImage *image = [UIImage imageNamed:@"3.gif"];
        [cell.imageView setImage:image];

        //开启异步联接加载图像，因为加载完成后要刷新对应的行
        [self loadImageAsyncWithIndexPath:indexPath];
    }else{
        [cell.imageView setImage:v.cacheImage];
    }
    return cell;
}
#pragma mark - ACTIONS
#pragma mark 异步加载网络图片
//由于UITableViewCell是可重用的  ，避免用户频繁快速刷新表格，造成数据冲突，
//不能直接将iangeView传入异步方法
//正确的解决方法：将表格的indexPath传入异步方法，加载完成图像后，直接刷新指定行
- (void)loadImageAsyncWithIndexPath:(NSIndexPath *)indexPath
{
    Video *v = self.dataList[indexPath.row];
    //加载图片
    NSString *imagePath = [NSString stringWithFormat:@"%@%@",kBaseURL,v.imageURL];
    NSURL *imageURL = [NSURL URLWithString:imagePath];

    //1.request
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    //2.connection sendAsync
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //将网络数据保存至video的cacheImage缓存图像
        v.cacheImage = [UIImage imageWithData:data];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }];
}
#pragma mark 处理json数据
- (void)handlerJsonData:(NSData *)data
{
    //json文件中的[]表示的是一个数组
    //1.反序列化json数据
    /*
     序列化：  将NSObject转换成序列数据，以便可以通过互联网进行传输
     反序列化： 将网络上获取的数据 反向生成为对象
     */
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //提示 如果开发网络应用，可以讲反序列化出来的对象，保存至沙箱 以便后续开发使用
    NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docs[0] stringByAppendingPathComponent:@"json.plist"];
    NSLog(@"%@",path);
    [array writeToFile:path atomically:YES];
    
    //给列表赋值
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Video *video = [[Video alloc]init];
        //给video赋值
        [video setValuesForKeysWithDictionary:dict];
        [arrayM addObject:video];
    }
    self.dataList = arrayM;
    [self.tableView reloadData];
    NSLog(@"%@",arrayM);
}
#pragma mark 加载json
- (void)loadjson
{
    //从web服务器直接加载数据
    NSString *str = @"http://localhost/02/";
    //提示NSData本身具有同步方法 但在开发中不要使用
    //在使用nsdata方法时，无法制定超时时间， 如果服务器不正常 会影响用户体验
    //NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];

    //1.建立NSURL
    NSURL *url = [NSURL URLWithString:str];
    //2.建立NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0f];
    //3.利用nsurlconnection同步方法加载数据
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //错误处理
    if(data != nil){
        //result仅用跟踪调试使用
//        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //json数据处理
        [self handlerJsonData:data];
    }else if (data == nil && error != nil){
        NSLog(@"空数据");
    }else{
        NSLog(@"%@",error.localizedDescription);
    }
}
#pragma mark 加载xml
-(void)loadxml
{
    NSLog(@"loadxml");
}
@end

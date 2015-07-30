//
//  ZJLTableViewController.m
//  qiubai
//
//  Created by Seven on 15/7/30.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ZJLTableViewController.h"
#import "AFNetworking.h"
@interface ZJLTableViewController ()

@property (nonatomic, strong)NSArray *qbArray;
@end

@implementation ZJLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(login) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(send) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //1.创建请求管理着
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [mgr GET:@"http://m2.qiushibaike.com/article/list/text?count=30&readarticles=%5B112017805%2C112016424%5D&page=1&AdID=14382569338301C984F54B" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HWLog(@"%@",responseObject);
        self.qbArray = responseObject[@"items"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"%@",error);
    }];

}


#pragma mark - tableView 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    

    
    UIImage *image = [UIImage imageNamed:@"navigationbar_friendsearch_highlighted"];
    cell.imageView.image = image;
    NSDictionary *dict =self.qbArray[indexPath.row];
    HWLog(@"%@",dict);
    cell.detailTextLabel.text = dict[@"content"];
    cell.textLabel.text = dict[@"user"][@"login"];
    return cell;

    
}

#pragma mark - 监听方法
- (void)send
{
    HWLog(@"send");
}
- (void)login
{
    HWLog(@"login");
}
@end

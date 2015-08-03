//
//  ZJLTableViewController.m
//  qiubai
//
//  Created by Seven on 15/7/30.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ZJLTableViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ZJLQiubai.h"
#import "ZJLUser.h"
#import "MJRefresh.h"
#import "ZJLQiubaiCell.h"
#import "ZJLDetailController.h"

@interface ZJLTableViewController ()

@property (nonatomic, strong)NSMutableArray *qbArray;
@property (nonatomic, assign)int *currentPage;
@end

@implementation ZJLTableViewController

- (NSMutableArray *)qbArray
{
    if (!_qbArray) {
        self.qbArray = [[NSMutableArray alloc]init];
    }
    return _qbArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//
//    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(login) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(send) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}
- (void)loadMoreData
{
    HWLog(@"loadMoreData");
    self.currentPage = self.currentPage + 1;
    [self loadQiubaiDataWithPage:self.currentPage];
    [self.tableView.footer endRefreshing];

}
- (void)loadNewData
{
    HWLog(@"loadNewdata");
    self.currentPage = 1;
    [self loadQiubaiDataWithPage:1];
    [self.tableView.header endRefreshing];
}

-(NSArray *)loadQiubaiDataWithPage:(int)page
{
    //1.创建请求管理着
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"] = @"30";
    params[@"readarticles"] = @"%2%2C112016424%5D";
    params[@"page"] = @(page);
    params[@"AdID"] = @"d";
    
    [mgr GET:@"http://m2.qiushibaike.com/article/list/text" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *newQiubai = [ZJLQiubai objectArrayWithKeyValuesArray:responseObject[@"items"]];

        NSArray *newFrames = [self statusFramesWithStatues:newQiubai];
        if (page == 1) {
            [self.qbArray removeAllObjects];
            [self.qbArray addObjectsFromArray:newFrames];
        }else{
            [self.qbArray addObjectsFromArray:newFrames];
        }
        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"%@",error);
    }];
    return self.qbArray;
}
- (NSArray *)statusFramesWithStatues:(NSArray *)statues
{
    //将hwstatusFrame 转为HWStatusFrame 数组
    NSMutableArray *frames = [NSMutableArray array];
    for (ZJLQiubai *qiubai in statues) {
        ZJLQiubaiFrame *f = [[ZJLQiubaiFrame alloc]init];
        f.qiubai = qiubai;
        [frames addObject:f];
    }
    return frames;
}

#pragma mark - tableView 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HWLog(@"------------------%lu",(unsigned long)self.qbArray.count);
    return self.qbArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ZJLQiubaiCell *cell = [ZJLQiubaiCell cellWithTableView:tableView];
    //给cell传递模型
    cell.qiubaiFrame = self.qbArray[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJLQiubaiFrame *frame = self.qbArray[indexPath.row];
    return frame.cellHeight;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJLDetailController *detail = [[ZJLDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark - 监听方法
- (void)send
{
    HWLog(@"%@",self.qbArray);
    HWLog(@"send");
}
- (void)login
{
    HWLog(@"login");
}

- (void)test
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"count"] = @"30";
    params[@"readarticles"] = @"%5B112017805%2C112016424%5D";
    params[@"page"] = @"1";
    params[@"AdID"] = @"14382569338301C984lF54B";
    
    [mgr GET:@"http://m2.qiushibaike.com/article/list/text" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *newQiubai = [ZJLQiubai objectArrayWithKeyValuesArray:responseObject[@"items"]];
        //将HWStatus数组转换为HWStatusFrames数组
        NSArray *newFrames = [self statusFramesWithStatues:newQiubai];
        [self.qbArray addObjectsFromArray:newFrames];
        
        HWLog(@"%@",responseObject);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"%@",error);
    }];


}
@end

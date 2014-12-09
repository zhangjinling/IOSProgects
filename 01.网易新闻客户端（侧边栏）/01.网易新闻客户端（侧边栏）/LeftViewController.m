//
//  LeftViewController.m
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@property (strong,nonatomic)NSArray *dataList;
@end

@implementation LeftViewController
/*
    选中表格行的处理的事情：
        1>.通知上级视图的控制器关闭菜单栏视图
        2>.通知上级视图控制器加载选中项对应的视图控制器
 */
#pragma mark - 实例化视图
- (void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 130, 460) style:UITableViewStylePlain];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数据
    //1>菜单内容项（文字，图像）
    NSString *path = [[NSBundle mainBundle]pathForResource:@"navMenu" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        MenuModel *m = [MenuModel menuModelWdithDict:dict];
        [arrayM addObject:m];
    }
    self.dataList = arrayM;
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:nil];
    MenuModel *m = self.dataList[indexPath.row];
    [cell.textLabel setText:m.title];
    [cell.imageView setImage:m.image];
    [cell.detailTextLabel setText:@"明细"];
    return cell;
}
#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuModel *menu = self.dataList[indexPath.row];
    [self.menuDelegate LeftViewController:self className:menu.className];
}
@end

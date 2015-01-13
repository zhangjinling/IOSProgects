//
//  MainViewController.m
//  04系统设置_不完整_xcode6
//
//  Created by Seven on 15/1/13.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import "SettingItem.h"
#import "DetailViewController.h"

@interface MainViewController ()
@property(strong,nonatomic) NSArray *dataList;
@end

@implementation MainViewController
//静态表格是分组的，因此要重写实例化视图方法
-(void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.初始化数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"settings" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSArray *sectionArray in array) {
        NSMutableArray *sectionArrayM = [NSMutableArray arrayWithCapacity:sectionArray.count];
        for (NSDictionary *dict in sectionArray) {
            SettingItem *item = [SettingItem settingItemWithDict:dict];
            
            [sectionArrayM addObject:item];
        }
        [arrayM addObject:sectionArrayM];
    }
    self.dataList = arrayM;
    self.title = @"设置";
}
#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataList[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.取出数据
    SettingItem *item = self.dataList[indexPath.section][indexPath.row];
    //2.根据数据库中是否有detail，来判断实例化哪种单元格
    UITableViewCell *cell = nil;
    if (item.detail == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    }else{
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];

    }
    [cell.textLabel setText:item.name];
    [cell.detailTextLabel setText:item.detail];
    //小尖尖
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingItem *item = self.dataList[indexPath.section][indexPath.row];

    //实例化明细视图控制器
    DetailViewController *detail = [[DetailViewController alloc]initWithBlock:^(myswitch *Myswitch) {
        if (Myswitch.isOn) {
            NSLog(@"打开了");
        }else{
            NSLog(@"关闭了");
        }
    }];
    //指定视图控制器 加载的数据文件名
    [detail setDataFileName:item.identifier];
    //push出明细视图控制器
    [self.navigationController pushViewController:detail animated:YES];
    
}
@end

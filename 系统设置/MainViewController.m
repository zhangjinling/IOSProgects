//
//  MainViewController.m
//  04.系统设置不完整new
//
//  Created by Seven on 15/1/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "MainViewController.h"
#import "SettingItem.h"
@interface MainViewController ()
@property (strong,nonatomic)NSArray *dataList;
@end


@implementation MainViewController
//静态表格是分组的，因此需要重写实例化视图方法
- (void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化数据的工作
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
    self.title = @"设置";
}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    return cell;
}



@end

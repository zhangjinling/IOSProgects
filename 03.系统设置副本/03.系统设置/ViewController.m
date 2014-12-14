//
//  ViewController.m
//  03.系统设置
//
//  Created by Seven on 14/12/10.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import "ViewController.h"
#import "MySwitch.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (0 == indexPath.section) {
        [cell.textLabel setText:@"蓝牙"];
    }else{
        [cell.textLabel setText:@"飞行模式"];
    }
    
    MySwitch *mySwitch = [[MySwitch alloc]init];
    [mySwitch setOn:YES];
    [mySwitch setIndexPath:indexPath];
    [mySwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [cell setAccessoryView:mySwitch];
    return cell;
}

- (void)switchValueChanged:(MySwitch *)mySwitch
{
    NSLog(@"mySwitch%@---%d",mySwitch.indexPath,mySwitch.isOn);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did select row,%@",indexPath);
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点 胖按钮%@",indexPath);
}
@end

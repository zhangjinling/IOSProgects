//
//  HWTitleMenuViewController.m
//  weibo02
//
//  Created by Seven on 15/6/28.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWTitleMenuViewController.h"

@interface HWTitleMenuViewController ()

@end

@implementation HWTitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    }else if  (indexPath.row == 1) {
        cell.textLabel.text = @"情人";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"明星";
    }
    return cell;

}

@end

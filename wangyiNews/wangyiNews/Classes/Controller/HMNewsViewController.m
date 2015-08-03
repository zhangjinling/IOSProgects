
//
//  HMNewsViewController.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMNewsViewController.h"
#import "HMTitleView.h"
@interface HMNewsViewController ()

@end

@implementation HMNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.标题
    HMTitleView *titleView = [[HMTitleView alloc]init];
    titleView.title = @"新闻";
    self.navigationItem.titleView =titleView;
    //2.左右按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftMenu) image:@"top_navigation_menuicon"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightMenu) image:@"top_navigation_infoicon"];
}
- (void)leftMenu
{
    
    //控制器缩放
    [UIView animateWithDuration:0.5 animations:^{
        
        if (CGAffineTransformIsIdentity(self.navigationController.view.transform)) {
            //缩放比例
            CGFloat scale = 300.0 / [UIScreen mainScreen].bounds.size.height;
            //菜单左边距
            CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) *0.5;
            CGFloat translateX = 200 - leftMenuMargin;
            CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
            CGFloat translateY = topMargin - 60;
            
            //缩放
            CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
            //平移
            CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, -translateY / scale);
            
            self.navigationController.view.transform = translateForm;
        }else{
            self.navigationController.view.transform = CGAffineTransformIdentity;

        }
    }];
}
- (void)rightMenu
{
    NSLog(@"rightMenu");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

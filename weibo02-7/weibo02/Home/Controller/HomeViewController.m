//
//  HomeViewController.m
//  weibo02
//
//  Created by Seven on 15/6/17.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HomeViewController.h"
#import "HWSearchBar.h"
#import "HWDropdownMenu.h"
#import "HWTitleMenuViewController.h"
@interface HomeViewController ()<HWDropdownMenuDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    HWLog(@"HomeViewController  view did load");
    //设置中间的下拉框
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.width = 150;
    titleButton.height = 30;
    //标题按钮
    //设置图片和文字
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0,0, 60);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
 
}
- (void)titleClick:(UIButton *)titleButton
{
    //创建下拉菜单
    HWDropdownMenu *menu = [HWDropdownMenu menu];
    menu.delegate = self;
//    menu.content = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 200)];
    //设置内容
    HWTitleMenuViewController *vc = [[HWTitleMenuViewController alloc]init];
    vc.view.height = 150;
    vc.view.width = 150;
    menu.contentControler = vc;
    //3显示
    [menu showFrom:titleButton];
    NSLog(@"%@",menu.content);
    
}
- (void)friendsearch
{
    NSLog(@"friendsearech");

}
-(void)pop
{
    NSLog(@"pop");

}
#pragma mark - 菜单被销毁
- (void)dropDownMenuDidDismiss:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];

}
#pragma mark - 菜单显示
- (void)dropDownMenuDidShow:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
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

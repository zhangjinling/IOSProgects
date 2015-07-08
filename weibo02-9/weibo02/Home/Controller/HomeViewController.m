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
#import "AFNetworking.h"
#import "HWAccountTool.h"
#import "HWTitleButton.h"
#import "UIImageView+WebCache.h"
@interface HomeViewController ()<HWDropdownMenuDelegate>
/**
 *  微博数组（里面放的是字典，一个字典是一个数组）
 */

@property (nonatomic, strong) NSArray *statuses;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航
    [self setNav];
    //设置用户昵称
    [self setupUserInfo];
    //加载微博最新数据
    [self loadNewStatus];
    
}
- (void)loadNewStatus
{
    //https://api.weibo.com/2/statuses/friends_timeline.json
    //1.创建请求管理着
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =[HWAccountTool account].access_token;
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HWLog(@"%@",responseObject);
        //取得微博数组
        self.statuses = responseObject[@"statuses"];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
/**
 *  设置导航
 */
- (void)setNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    HWLog(@"HomeViewController  view did load");
    //设置中间的下拉框
    HWTitleButton *titleButton = [[HWTitleButton alloc]init];
    //标题按钮
    //设置图片和文字
    NSString *name = [HWAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
/**
 *  获得用户信息
 */
-(void)setupUserInfo
{
    //从沙盒中获取账户信息
    HWAccount *account = [HWAccountTool account];
    
    //https://api.weibo.com/2/users/show.json
    //1.创建请求管理着
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =account.access_token;
    params[@"uid"] =account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        NSString *name =responseObject[@"name"];
        [titleButton setTitle:name forState:UIControlStateNormal];

        //存储昵称
        account.name = name;
        [HWAccountTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
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


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.statuses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //这出一条微博字典
    NSDictionary *status = self.statuses[indexPath.row];
    //取出这条微博的作者
    NSDictionary *users = status[@"user"];
    cell.textLabel.text = users[@"name"];
    //设置头像
    NSString *imageUrl = users[@"profile_image_url"];
    UIImage *placeHolder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeHolder];
    //设置微博内容
    cell.detailTextLabel.text = status[@"text"];
    return cell;
}

@end

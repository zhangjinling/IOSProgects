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
@interface HomeViewController ()<HWDropdownMenuDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNav];
    
    [self setupUserInfo];
    
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
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.width = 150;
    titleButton.height = 30;
    //标题按钮
    //设置图片和文字
    NSString *name = [HWAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);
//    titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0,0, 60);
    HWLog(@"%f",[UIScreen mainScreen].scale);
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = titleButton.titleLabel.font;
    CGFloat titleW = [titleButton.currentTitle sizeWithAttributes:attrs].width;
    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
    CGFloat left = titleW + imageW;
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
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

@end

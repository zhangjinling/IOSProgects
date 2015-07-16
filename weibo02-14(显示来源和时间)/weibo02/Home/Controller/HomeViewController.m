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
#import "HWUser.h"
#import "HWStatus.h"
#import "MJExtension.h"
#import "HWLoadMoreFooter.h"
#import "HWStatusCell.h"
#import "HWStatusFrame.h"
@interface HomeViewController ()<HWDropdownMenuDelegate>
/**
 *  HWStatusFrame.h数组（里面放的是模型，一个字典是一个数组）
 */

@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation HomeViewController

- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [[NSMutableArray alloc]init];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = HWColor(211, 211, 211);
//    self.tableView.contentInset = UIEdgeInsetsMake(HWStatusCellMargin, 0, 0, 0);
    //设置导航
    [self setNav];
    //设置用户昵称
    [self setupUserInfo];
    //加载微博最新数据
//    [self loadNewStatus];
    //集成下拉刷新控件
    [self setupDownRefresh];
    //集成上拉刷新
    [self setupUpRefresh];
    //隐藏导航栏
//    self.navigationController.navigationBar.hidden = YES;
    //获取唯独数目
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setupUnReadCount) userInfo:nil repeats:YES];
    //意味着主线程也会抽时间处理一下timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setupUnReadCount
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    //发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        HWLog(@"%d",status.intValue);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败---%@",error);
    }];
}
/**
 *  集成上拉刷新
 */
-(void) setupUpRefresh
{
    HWLoadMoreFooter *footer  = [HWLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}
- (void)setupDownRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    //只有用户下拉才会刷新
    [control addTarget:self action:@selector(refreshStatusesChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    // 2.马上进入刷新状态（仅仅是显示刷新状态）
    [control beginRefreshing];
    // 马上加载数据
    [self refreshStatusesChange:control];
}
- (void)refreshStatusesChange:(UIRefreshControl *)control
{
    //https://api.weibo.com/2/statuses/friends_timeline.json
    //1.创建请求管理着
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] =[HWAccountTool account].access_token;
    HWStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        //如果存在第一条微博。
        params[@"since_id"] = firstStatusF.status.idstr;

    }

    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        HWLog(@"%@",responseObject);
        //将字典数组转换为微博模型数组
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将hwstatusFrame 转为HWStatusFrame 数组
        NSArray *newFrames = [self statusFramesWithStatues:newStatuses];
        
        //将最新的微博数据加载到 总微博数据的前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];

        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        //显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //结束刷新
        [control endRefreshing];
    }];
    
}
/**
 *  将HWStatus 模型转换成HWStatusFrames模型
 *
 *  @param statues
 *
 *  @return
 */
- (NSArray *)statusFramesWithStatues:(NSArray *)statues
{
    //将hwstatusFrame 转为HWStatusFrame 数组
    NSMutableArray *frames = [NSMutableArray array];
    for (HWStatus *status in statues) {
        HWStatusFrame *f = [[HWStatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}
/**
 *  显示新微薄的数量
 *
 *  @param count 新微薄的数量
 */
- (void)showNewStatusCount:(NSInteger)count
{
    //当上拉刷新完成时，清空微博的数量
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    //1.创建label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    //2.设置其他属性
    if (count == 0) {
        label.text = [NSString stringWithFormat:@"没有新的微博数据"];
    }else{
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",(long)count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    //3.添加
    label.y = 64 - label.height;
//    [self.navigationController.view addSubview:label];
    //将label添加到导航控制器中   并且在导航栏的下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //4.动画
    CGFloat duration = 1.0;//动画时间
    [UIView animateWithDuration:duration animations:^{
//        label.y += label.height;
        //或者使用transform
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay  = 1.0f;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
//            label.y -=label.height;
            //另一种方法
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    //如果某个动画执行前又要回到执行前的状态，建议使用transform
    
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
        HWUser *user = [HWUser objectWithKeyValues:responseObject];
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
//        NSString *name =responseObject[@"name"];
        NSString *name = user.name;
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
    
    return self.statusFrames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusCell *cell = [HWStatusCell cellWithTableView:tableView];
    //给cell传递模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}
/*
 1.字典转换为模型。
 2.下拉刷新最新的微博数据
 3.能够上拉加载更多数据
 
 */
/**
 *  加载更多微博数据
 */
- (void)loadMoreStatus
{
   //1.实例化请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2.拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最后面的微博，最新的微博，ID最大的微博
    HWStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        long long maxId = lastStatusF.status.idstr.longLongValue -1;
        params[@"max_id"] = @(maxId);
    }
    //3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //将HWStatus数组转换为HWStatusFrames数组
        NSArray *newFrames = [self statusFramesWithStatues:newStatuses];
        
        [self.statusFrames addObjectsFromArray:newFrames];
        [self.tableView reloadData];
        //结束刷新隐藏 footer
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HWLog(@"请求失败");
        self.tableView.tableFooterView.hidden = YES;
    }];
}
/**
 *  表格滚动事件
 *
 *  @param scrollView 滚动条
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden == NO) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    //当最后一个cell完全在眼前时，contentOffset.y
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom -scrollView.height-self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) {
        //显示footer  加载数据
        self.tableView.tableFooterView.hidden = NO;
        //加载更多数据
        [self loadMoreStatus];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}





//- (void)loadNewStatus
//{
//    //https://api.weibo.com/2/statuses/friends_timeline.json
//    //1.创建请求管理着
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    //2.拼接请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] =[HWAccountTool account].access_token;
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        HWLog(@"%@",responseObject);
//        //将字典数组转换为微博模型数组
//
//        self.statuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        [self.tableView reloadData];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//    }];
//
//}

@end

//
//  DetailViewController.m
//  04系统设置_不完整_xcode6
//
//  Created by Seven on 15/1/13.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "DetailViewController.h"
#import "SettingItem.h"
#import "myswitch.h"
@interface DetailViewController ()
{
    //开关快代码
    switchValueChangedBlock _switchBlock;
}
@property(strong,nonatomic)NSArray *dataList;

@end

@implementation DetailViewController
/*
    1.实例化视图
    2.用dataFileName的setter方法加载数据
    3.数据源方法
 */

#pragma mark - 使用快代码实例化对象
- (id)initWithBlock:(switchValueChangedBlock)block
{
    self = [super init];
    if (self) {
        _switchBlock = block;
    }
    return self;
}
-(void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    self.title = self.dataFileName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle]pathForResource: self.dataFileName ofType:@"plist"];
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

}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataList[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    SettingItem *item = self.dataList[indexPath.section][indexPath.row];
    [cell.textLabel setText:item.name];
    if (item.hasSwitch) {
        myswitch *myswitch1 = [[myswitch alloc]init];
        [myswitch1 setOn:item.switchValue];
        [cell setAccessoryView:myswitch1];
        [myswitch1 setIndexPath:indexPath];
        [myswitch1 addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}
- (void)switchValueChanged:(myswitch *)sw
{
    NSLog(@"%@",sw.indexPath);
    _switchBlock(sw);
}

@end

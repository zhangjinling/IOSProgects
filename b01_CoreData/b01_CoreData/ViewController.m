//
//  ViewController.m
//  b01_CoreData
//
//  Created by Seven on 15/8/10.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Employee.h"
#import "Department.h"
#import "Status.h"

@interface ViewController ()
@property (nonatomic,strong) NSManagedObjectContext *context;

@property (nonatomic,strong) NSManagedObjectContext *company;
@property (nonatomic,strong) NSManagedObjectContext *weibo;

@end

@implementation ViewController
/**
 *  添加员工和微博信息
 *
 *  @param sender <#sender description#>
 */
- (IBAction)Employee_Status:(id)sender {
    //创建员工
    Employee *emp  = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.company];
    emp.name = @"张金玲";
    emp.age = @25;
    emp.height = @1.76;
    [self.company save:nil];
    
    //创建微博
    Status *sta = [NSEntityDescription insertNewObjectForEntityForName:@"Status" inManagedObjectContext:self.weibo];
    sta.text = @"zhangjinlingweibo";
    sta.author = @"the fiest ";
    sta.createDate = [NSDate date];
    [self.weibo save:nil];
    
}
#pragma mark - 关联查询
- (IBAction)manyTable:(id)sender {
    //查找ios部门的员工
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"depart.name like %@",@"A*"];
    request.predicate = pre;
    //读取信息
    NSError *error = nil;
    NSArray *employees = [self.context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"%@",employees);
        for (Employee *emp in employees) {
            NSLog(@"%@--%@--%@--%@",emp.name,emp.age,emp.height,emp.depart.name);
        }
    }else{
        NSLog(@"%@",error);
    }

    
}
#pragma mark - 模糊查询
- (IBAction)likeSearch:(id)sender {
    //查询以李四开头的员工
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    //过滤 查询以李四开头的
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH%@",@"李"];
    //以118结尾
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH%@",@"118"];
    //包含 某个字符创
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name CONTAINS%@",@"11"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like%@",@"--*"];
    request.predicate = pre;
    //读取信息
    NSError *error = nil;
    NSArray *employees = [self.context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"%@",employees);
        for (Employee *emp in employees) {
            NSLog(@"%@--%@--%@",emp.name,emp.age,emp.height);
        }
    }else{
        NSLog(@"%@",error);
    }

    
}
#pragma mark - 更新员工信息
- (IBAction)modifyEmployee:(id)sender {
    //把李四117的身高修改为1234
    //1.查找李四117
    NSArray *emps = [self findEmployeeWithName:@"李四117"];
    NSLog(@"%@",emps);
    //2.更新
    for (Employee *emp in emps) {
//        Employee *emp = emps[0];
        emp.height = @1234;
    }
    //3.同步数据
    [self.context save:nil];
}
#pragma mark - 删除员工
- (IBAction)deleteEmployee:(id)sender {
    [self deleteEmployeeWithName:@"李四116"];
}
- (NSArray *)findEmployeeWithName:(NSString *)name
{
    //1.查找到张三
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;
    //2.删除张三
    NSArray *emps = [self.context executeFetchRequest:request error:nil];
    return emps;
}
- (void)deleteEmployeeWithName:(NSString *)name
{
    //删除张三
    //1.查找到张三
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;
    //2.删除张三
    NSArray *emps = [self.context executeFetchRequest:request error:nil];
    for (Employee *emp in emps) {
        NSLog(@"删除了 ： %@",emp.name);
        [self.context deleteObject:emp];
    }
    //3.用context同步数据库
    //所有的操作都是暂时在内存中的，所有操作都要同步到数据库
    [self.context save:nil];

}
#pragma mark - 读取员工信息
- (IBAction)readEmployee:(id)sender {
    //创建一个请求对象(填入要查询的表名-》实体类)
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    //过滤查询
//    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@ AND height < %@",@"李四" ,@190.1];
//    request.predicate = pre;
    //排序
//    NSSortDescriptor *sort  = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
//    request.sortDescriptors = @[sort];
    //分页查询
    request.fetchLimit = 50;
    request.fetchOffset = 15;
    
    //读取信息
    NSError *error = nil;
    NSArray *employees = [self.context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"%@",employees);
        for (Employee *emp in employees) {
            NSLog(@"%@--%@--%@",emp.name,emp.age,emp.height);
        }
    }else{
        NSLog(@"%@",error);
    }
    
    
}
#pragma mark - 添加员工信息
- (IBAction)addEmployee:(id)sender {
    //添加张三 属于ios部门
    Employee *emp1 = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    emp1.name = @"张三";
    emp1.age = @21;
    emp1.height = @1.7;
    //创建ios部门
    Department *dep1 = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    dep1.name = @"IOS";
    dep1.createData = [NSDate date];
    dep1.departNo = @"d0001";
    emp1.depart = dep1;
    
    //添加李四 属于android部门
    Employee *emp2 = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    emp2.name = @"李四";
    emp2.age = @25;
    emp2.height = @1.9;
    //创建ios部门
    Department *dep2 = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:self.context];
    dep2.name = @"Android";
    dep2.createData = [NSDate date];
    dep2.departNo = @"d0002";
    emp2.depart = dep2;
    
    //一次性保存
    NSError *error = nil;
    [self.context save:&error];
    if (!error) {
        NSLog(@"success");
    }else{
        NSLog(@"fail");
    }
    
    
    
//    for (int i = 110; i < 120; i ++) {
        //创建员工
//        Employee *emp1 = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
//        //设置员工的属性
//        emp1.name = [NSString stringWithFormat:@"---四%d",3];
//        emp1.age = @11;
//        emp1.height = @110;
//        //通过上下文操作
//        NSError *error = nil;
//        [self.context save:&error];
//        if (!error) {
//            NSLog(@"success");
//        }else{
//            NSLog(@"error");
//        }
//    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //需要有两个上下文
    //company上下文
    
    //微博上下文
    
    self.company = [self setupContextWithModelName:@"Company"];
    self.weibo = [self setupContextWithModelName:@"Weibo"];
    
    
}
/**
 *  根据模型文件名称返回上下文
 *
 *  @param modelName 模型名称
 *
 *  @return 返回上下文
 */
- (NSManagedObjectContext *)setupContextWithModelName:(NSString *)modelName
{
    //创建一个sqlite数据库
    //创建一张员工表 （name，age，height）
    //忘数据库中添加信息
    //1.上下文  关联 Company.xcdatamodeld 模型文件
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]init];
    //2。关联模型文件
    //创建一个模型对象.传入一个nil 会把bundle下的所有模型文件关联起来
    //查找model文件的url
    NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelUrl];
    //持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //存储数据库的名字
    NSError *error = nil;
    //获取document目录
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //数据库保存路径
    NSString *sqlitePath = [doc stringByAppendingFormat:@"/%@.sqlite",modelName];
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    context.persistentStoreCoordinator = store;

    return context;
}

- (void)setupContext
{
    //创建一个sqlite数据库
    //创建一张员工表 （name，age，height）
    //忘数据库中添加信息
    //1.上下文  关联 Company.xcdatamodeld 模型文件
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]init];
    //2。关联模型文件
    //创建一个模型对象.传入一个nil 会把bundle下的所有模型文件关联起来
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    //持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //存储数据库的名字
    NSError *error = nil;
    //获取document目录
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //数据库保存路径
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"comapny.Sqlite"];
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    context.persistentStoreCoordinator = store;
    self.context = context;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
@interface ViewController ()
@property (nonatomic,strong) NSManagedObjectContext *context;
@end

@implementation ViewController
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
    request.fetchLimit = 5;
    request.fetchOffset = 0;
    
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
    for (int i = 110; i < 120; i ++) {
        //创建员工
        Employee *emp1 = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
        //设置员工的属性
        emp1.name = [NSString stringWithFormat:@"李四%d",i];
        emp1.age = @11;
        emp1.height = @110;
        //通过上下文操作
        NSError *error = nil;
        [self.context save:&error];
        if (!error) {
            NSLog(@"success");
        }else{
            NSLog(@"error");
        }
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupContext];
    
    
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

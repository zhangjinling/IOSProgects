//
//  AppDelegate.m
//  KVC
//
//  Created by Seven on 15/5/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "Card.h"
#import "Book.h"

@interface AppDelegate ()
@property(strong,nonatomic)Person *myPserson;
/**
 KVC 使用键值编码
 1.使用KVC为对象赋值或取值时，需要知道准确的键值
 2.相比点语法，KVC是一种简介的传值方式，这种方式对于对象解耦，让对象之间的耦合度不会太高。
 3.赋值语句：
        //给对象的当前属性赋值
        [person setValue:@"jake" forKey:@"name"];
        //按照对象的层级关系属性赋值
        [person setValue:@"14234213412234" forKeyPath:@"card.no"];
        forKeyPath可以替代forKey，forKey不能替代forkeyPath
 [p setValuesForKeysWithDictionary:dict];

 4.KVO   -  key  value   observer（观察者）
    观察者对象雪要实现 以下方法 
 [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];

 - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
注意事项  ：  不能观察已经被释放的东西   如果要观察  需要时强引用  或被其他对象的引用

 
 observeValueForKeyPath  是nsobject的分类 意味着 任何的对象都能设置观察者
 **/
@end


@implementation AppDelegate
-(void)initPerson:(id) person
{
    [person setValue:@"jake" forKey:@"name"];
    [person setValue:@20 forKey:@"age"];
}

#pragma mark - KVC演练1
- (void)kvcDemo1
{
    Person *person = [[Person alloc]init];
    [self initPerson:person];
    person.card = [[Card alloc]init];
    person.card.no = @"1234";
    [person setValue:@"14234213412234" forKeyPath:@"card.no"];
    
    Book *book1 = [[Book alloc]init];
    book1.bookName = @"IOS开发1";
    book1.price = 123.2;
    
    Book *book2 = [[Book alloc]init];
    book2.bookName = @"IOS开发2";
    book2.price = 1230000.2;
    //数组的快速封装
    person.books = @[book1,book2];
    
    NSLog(@"%@",person);
    NSLog(@"%@",[person valueForKeyPath:@"books.price"]);

}

#pragma mark - KVC 绑定plist文件
- (void)KVCDemo2
{
    //读取plist文件
    //1.路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Preson" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        Person *p = [[Person alloc]init];
        //初始化Person
        [p setValuesForKeysWithDictionary:dict];
        [arrayM addObject:p];
    }
    NSLog(@"%@",arrayM);
    
    

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self kvcDemo1];
    
    Person *p = [[Person alloc]init];
    p.name = @"mary";
    self.myPserson = p;
    //如果用户的姓名发生改变 ， 需要得到通知
    //如果监听对象属性的变化，除了通知中心之外  可以自己注册观察值
    
    //addObserver的参数
    //1.观察者对象 可以自定义  也可以是self
    //2.观察对象的键值路径
    //3.观察数值变化情况的选项
        //NSKeyValueObservingOptionNew  只观察新值
        //NSKeyValueObservingOptionOld  变化之前的值
    //4.context 字符串参数表示
    [p addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.myPserson.name = @"zdf";
    p.age = 30;
    //删除观察者
    [p removeObserver:self forKeyPath:@"name"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    return YES;
}

/*  
 1、keyPath 键值路径
 2.观察者对象
 3.change  键值变化字典
 4.context 添加观察者模式时添加的字符串
 
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"--%@--%@--%@--%@--",keyPath,object,change,context);
}
@end

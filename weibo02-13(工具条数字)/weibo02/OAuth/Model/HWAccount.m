//
//  HWAccount.m
//  weibo02
//
//  Created by Seven on 15/7/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    HWAccount *account = [[HWAccount alloc]init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.uid = dict[@"uid"];
    //获得账号的产生时间
    NSDate *createDate = [NSDate date];
    account.created_time = createDate;

    return account;
}
//当一个文件 归档进出沙盒时就会调用这个方法
//目的：在这个方法中说明这个对象的那个方法哪些属性存进沙盒
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];

}
//当从沙盒中解档一个文件时，就会调用这个方法
//目的 ： 说明沙盒中的属性该怎么解析，需要取出那些属性
- (id)initWithCoder:(NSCoder *)decoder
{
    HWLog(@"解析文档");
    if(self == [super init] ){
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];

    }
    return self;
}

@end

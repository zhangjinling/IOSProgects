//
//  MenuModel.m
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+(id)menuModelWdithDict:(NSDictionary *)dict
{
    MenuModel *m = [[MenuModel alloc]init];
    m.title = dict[@"title"];
    m.className = dict[@"className"];
    m.image = [UIImage imageNamed:dict[@"imageName"]];
    return m;
}
@end

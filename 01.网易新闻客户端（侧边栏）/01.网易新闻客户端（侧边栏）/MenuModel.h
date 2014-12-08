//
//  MenuModel.h
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject
//工厂方法实例化menuModel
+ (id)menuModelWdithDict:(NSDictionary *)dict;
@property(strong,nonatomic)NSString *title;

@property(strong,nonatomic)UIImage *image;

@property(strong,nonatomic)NSString *className;
@end

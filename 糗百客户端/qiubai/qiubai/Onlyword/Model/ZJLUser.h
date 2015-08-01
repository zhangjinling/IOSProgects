//
//  ZJLUser.h
//  qiubai
//
//  Created by Seven on 15/7/31.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJLUser : NSObject
/** 发布者昵称 */
@property (nonatomic, copy) NSString *login;
/** 发布者头像 */
@property (nonatomic, copy) NSString *icon;
/** 糗百用户id */
@property (nonatomic, copy) NSString *idstr;
@end

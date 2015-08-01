//
//  ZJLQiubai.h
//  qiubai
//
//  Created by Seven on 15/7/31.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ZJLUser.h"

@interface ZJLQiubai : NSObject
/** 糗百内容 */
@property (nonatomic, copy) NSString *content;
/** 笑脸的次数 */
@property (nonatomic, assign) int up;
/** 哭脸的次数 */
@property (nonatomic, assign) int down;
/** 评论的次数 */
@property (nonatomic, assign) int comments_count;
/** 发表微博的用户 */
@property (nonatomic, strong) ZJLUser *user;
@end

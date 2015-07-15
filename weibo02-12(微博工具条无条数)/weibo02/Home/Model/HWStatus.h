//
//  HWStatus.h
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>

@class HWUser;

@interface HWStatus : NSObject
//微博ID
@property(nonatomic, copy) NSString *idstr;
//微博内容
@property(nonatomic, copy) NSString *text;
//微博用户信息模型
@property(nonatomic, strong)HWUser *user;
//微博发布时间
@property (nonatomic, copy) NSString *created_at;
//微博来源
@property (nonatomic, copy) NSString *source;
//微博的配图 多图时 返回多图链接，无配图时返回“[]”
@property (nonatomic, strong) NSArray *pic_urls;

//转发的微博
@property (nonatomic, strong) HWStatus *retweeted_status;

/** 转发数 */
@property (nonatomic, assign) int reposts_count;
/** 评论数 */
@property (nonatomic, assign) int comment_count;
/** 赞数 */
@property (nonatomic, assign) int attitudes_count;
@end

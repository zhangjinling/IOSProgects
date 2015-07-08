//
//  HWStatus.h
//  weibo02
//
//  Created by Seven on 15/7/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HWUser;

@interface HWStatus : NSObject
@property(nonatomic, copy) NSString *idstr;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong)HWUser *user;
@end

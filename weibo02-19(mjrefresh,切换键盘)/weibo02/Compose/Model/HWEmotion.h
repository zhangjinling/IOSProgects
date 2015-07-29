//
//  HWEmotion.h
//  weibo02
//
//  Created by Seven on 15/7/29.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的图片名称 */
@property (nonatomic, copy) NSString *png;
/** emoji16进制表情编码 */
@property (nonatomic, copy) NSString *code;
@end

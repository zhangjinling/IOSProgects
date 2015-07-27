//
//  NSString+Extension.m
//  weibo02
//
//  Created by Seven on 15/7/16.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize )sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize )sizeWithfont:(UIFont *)font
{
    return [self sizeWithfont:font maxW:MAXFLOAT];
    
}

@end

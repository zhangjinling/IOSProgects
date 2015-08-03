//
//  UIImage+UIImage_Extension.m
//  wangyiNews
//
//  Created by Seven on 15/8/3.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "UIImage+UIImage_Extension.h"

@implementation UIImage (UIImage_Extension)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    //2.画一个color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    //3.拿到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文
    UIGraphicsEndImageContext();
    return image;
    
}

@end

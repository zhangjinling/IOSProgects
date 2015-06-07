//
//  Video.h
//  json_xml
//
//  Created by Seven on 15/6/6.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 异步图像加载的内存缓存解决方法：
    1、在对象中定义一个UIImage。
    2、在控制器中，填充表格内容时，判断UIImage是否存在内容
        1>cacheImage不存在，显示占位图形，同时开启异步网络连接加载网络图像
                网络图像加载完成后，设置对象的cacheImage，
                设置完成后舒心表格对应的行。
        2>如果cacheImage存在直接显示cacheImage。
 */
@interface Video : NSObject

@property (assign, nonatomic) NSInteger videoId;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger length;
@property (strong, nonatomic) NSString *videoURL;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *teacher;

@property (strong ,nonatomic) UIImage *cacheImage;
//视频时长
@property (strong ,nonatomic ,readonly) NSString *lengthStr;
@end

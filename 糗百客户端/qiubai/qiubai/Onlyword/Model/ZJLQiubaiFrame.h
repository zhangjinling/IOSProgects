//
//  ZJLQiubaiFrame.h
//  qiubai
//
//  Created by Seven on 15/8/1.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJLQiubai.h"
#import "ZJLUser.h"

#define HWStatusCellMargin 15

//cell 的边框宽度
#define HWStatusCellBorderW 10
//昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:11.0f]
//时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:12.0f]
//来源字体
#define HWStatusCellSourceFont [UIFont systemFontOfSize:12.0f]
//正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:14.0f]
//转发微博正文字体
#define HWStatusCellRetweetContentFont [UIFont systemFontOfSize:13.0f]
//cell 的边框宽度
#define HWStatusCellBorderW 10


@interface ZJLQiubaiFrame : NSObject

@property (nonatomic ,strong) ZJLQiubai *qiubai;
//原创微博整体
@property (nonatomic ,assign) CGRect originalViewF;
//头像
@property (nonatomic ,assign) CGRect iconViewF;
//昵称
@property (nonatomic ,assign) CGRect loginViewF;
//内容
@property (nonatomic ,assign) CGRect contnetViewF;
@property (nonatomic ,assign) CGFloat cellHeight;

@end

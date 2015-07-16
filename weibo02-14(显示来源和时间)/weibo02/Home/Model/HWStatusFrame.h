//
//  HWStatusFrame.h
//  weibo02
//
//  Created by Seven on 15/7/12.
//  Copyright (c) 2015年 seven. All rights reserved.
//  一个statusframe的模型存放的一个cell的所有frame数据
//  存放一个cell的高度
//  存放着一个数据迷行HWStatus

#import <Foundation/Foundation.h>
//cell 之间的间距
#define HWStatusCellMargin 15

@class HWStatus;
//昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:15.0f]
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




@interface HWStatusFrame : NSObject
@property (nonatomic ,strong) HWStatus *status;
//原创微博整体
@property (nonatomic ,assign) CGRect originalViewF;
//头像
@property (nonatomic ,assign) CGRect iconViewF;
//VIP标志
@property (nonatomic ,assign) CGRect vipViewF;
//配图
@property (nonatomic ,assign) CGRect photoViewF;
//昵称
@property (nonatomic ,assign) CGRect nameLabelF;
//时间
@property (nonatomic ,assign) CGRect timeLabelF;
//来源
@property (nonatomic ,assign) CGRect sourceLabelF;
//正文
@property (nonatomic ,assign) CGRect contentLabelF;

/* 转发微博  */
//转发微博整体
@property (nonatomic ,assign) CGRect retweetViewF;
//正文 + 昵称
@property (nonatomic ,assign) CGRect retweetContentlabelF;
//转发配图
@property (nonatomic ,assign) CGRect retweetPhotoViewF;

/** 底部工具栏 */
@property (nonatomic ,assign) CGRect toolbarF;

//cell的高度
@property (nonatomic ,assign) CGFloat cellHeight;


@end

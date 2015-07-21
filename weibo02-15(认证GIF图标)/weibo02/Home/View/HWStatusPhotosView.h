//
//  HWStatusPhotosView.h
//  weibo02
//
//  Created by Seven on 15/7/20.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWStatusPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片个数计算相册尺寸
 *
 *  @param count <#count description#>
 *
 *  @return <#return value description#>
 */
+ (CGSize)sizeWithCount:(int)count;
@end

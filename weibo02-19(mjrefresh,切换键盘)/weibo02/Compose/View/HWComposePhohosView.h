//
//  HWComposePhohosView.h
//  weibo02
//
//  Created by Seven on 15/7/27.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWComposePhohosView : UIView

/** 添加图片 */
- (void)addPhoto:(UIImage *)photo;

//@property (nonatomic, strong,readonly) NSArray *photos;
- (NSArray *) photos;

@end

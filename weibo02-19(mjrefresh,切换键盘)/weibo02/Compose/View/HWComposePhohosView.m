//
//  HWComposePhohosView.m
//  weibo02
//
//  Created by Seven on 15/7/27.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWComposePhohosView.h"

@implementation HWComposePhohosView

- (void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
}
- (NSArray *)photos
{
    NSMutableArray *photos = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [photos addObject:imageView.image];
    }
    return photos;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置图片的位置和尺寸
    NSUInteger count = self.subviews.count;
    int maxCol = 3;
    CGFloat imageMargin = 10;
    CGFloat imageWH =(self.width - (maxCol + 1) * imageMargin) / maxCol;
    for (int i = 0; i < count; i++) {
        UIImageView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = (col + 1) * imageMargin + col * imageWH;
        //        photoView.x = col * (imageWH + imageMargin);
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
    
}
@end

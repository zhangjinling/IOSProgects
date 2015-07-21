//
//  HWStatusPhotosView.m
//  weibo02
//
//  Created by Seven on 15/7/20.
//  Copyright (c) 2015年 seven. All rights reserved.
//  cell上面的配图相册（里面会显示1~9张图片）

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"
#import "HWStatusPhotoView.h"


#define HWStatusPhotoWH 70
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) (count == 4 ? 2 : 3);


@implementation HWStatusPhotosView

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSUInteger photoCount = photos.count;
    //销毁全部对象
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //创建额外缺少的view
    while (self.subviews.count < photos.count) {
        HWStatusPhotoView *photoView = [[HWStatusPhotoView alloc]init];
        [self addSubview:photoView];
    }
    //遍历所有图片控件设置图片（要考虑重用性 上一次9张-->下一次5张）
    for (int i = 0; i < self.subviews.count; i ++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        if (i < photoCount) {//显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        }else{//隐藏
            photoView.hidden = YES;
        
        }
    }
}

/**
 *  设置图片的属性和位置
 */
- (void)layoutSubviews
{
    
    [super layoutSubviews];
    NSUInteger photoCount = self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photoCount);
    for (int i = 0; i < photoCount; i++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        int row = i / maxCol;
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }
}
+ (CGSize)sizeWithCount:(int)count
{
    int maxCol = HWStatusPhotoMaxCol(count);
    //列数
    int cols = (count >= maxCol) ? maxCol : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    //行数
//    int rows = 0;
//    if (count % 3 == 0) {
//        rows = count / 3;
//    }else{
//        rows = count / 3 + 1;
//    }
    //上面的if可以简化为：
    int rows = (count + maxCol -1) / maxCol;
    //pages = (count + pageSize - 1) / pageSize;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end

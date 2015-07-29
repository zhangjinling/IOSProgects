//
//  HWStatusPhotoView.m
//  weibo02
//
//  Created by Seven on 15/7/21.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWStatusPhotoView.h"
#import "HWPhoto.h"
#import "UIImageView+WebCache.h"

@interface HWStatusPhotoView()

@property(nonatomic, weak) UIImageView *gifView;

@end


@implementation HWStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //内容模式
        /**
         *      
         UIViewContentModeScaleToFill,--> 图片会拉伸至填充整个imageView，而且图片会变形（不保持宽高比显示全部内容）
         UIViewContentModeScaleAspectFit,-->图片按宽高比拉伸至完全显示在UIImageView为止（不会变                       形）保持宽高比显示全部内容
         UIViewContentModeScaleAspectFill,-->图片按照宽高比缩放，当宽或者高相等时，居中显示（保持宽高比 ，剧中显示 利用clipsToBounds切割超出部分）
         UIViewContentModeRedraw,-->调用 setNeedDisplay方法时，就会重新渲染
         UIViewContentModeCenter,-->不伸缩拉伸 居中显示（以下个方法以此类推）
         UIViewContentModeTop,   --->不拉伸伸缩 顶部显示
         UIViewContentModeBottom,
         UIViewContentModeLeft,
         UIViewContentModeRight,
         UIViewContentModeTopLeft,
         UIViewContentModeTopRight,
         UIViewContentModeBottomLeft,
         UIViewContentModeBottomRight,
         1.凡是带有scale单词的，图片都会被拉伸。
         2.凡是带有Aspect单词的 ， 图片都保持原来的宽高比（图片不会变形）
         3.
         */
//        self.backgroundColor = [UIColor redColor];
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框后裁掉
        self.clipsToBounds = YES;
    }
    return self;
}
- (void) setPhoto:(HWPhoto *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //显示隐藏gifView
//    if([photo.thumbnail_pic hasSuffix:@"gif"]){
//        self.gifView.hidden = NO;
//    }else{
//        self.gifView.hidden = YES;
//    }
    //判断是否以gif 、GIF结尾
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width ;
    self.gifView.y = self.height - self.gifView.height;
}
@end

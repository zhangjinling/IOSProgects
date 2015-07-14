//
//  HWStatusFrame.m
//  weibo02
//
//  Created by Seven on 15/7/12.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWStatusFrame.h"
#import "HWStatus.h"
#import "HWUser.h"

//cell 的边框宽度
#define HWStatusCellBorderW 10

@implementation HWStatusFrame

- (CGSize )sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize )sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
    
}
- (void)setStatus:(HWStatus *)status
{
    _status = status;
    //cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    HWUser *user = status.user;
    //头像
    CGFloat iconWH = 35;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HWStatusCellNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    //VIP标志
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }

    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.created_at font:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};

    //正文
    CGFloat contentX = self.iconViewF.origin.x;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:HWStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};

    //配图
    //原创微博整体高度（会因为有无配图高度而改变）
    CGFloat originalH = 0;

    if (status.pic_urls.count ) {//有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photoViewF) + HWStatusCellBorderW;
    }else{
        //没有配图
        originalH = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
    }


    //原创微博整体(originalView)
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /**被转发微博**/
    if(status.retweeted_status){
        //转发微博
        HWStatus *retweeted_status = status.retweeted_status;
        //用户
        HWUser *retweeted_status_user = retweeted_status.user;

        //被转发微博正文
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:HWStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentlabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        //被转发微博配图
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            CGFloat reweetPhotoWH = 100;
            CGFloat reweetPhotoX = retweetContentX;
            CGFloat reweetPhotoY = CGRectGetMaxY(self.retweetContentlabelF) + HWStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(reweetPhotoX, reweetPhotoY, reweetPhotoWH, reweetPhotoWH);
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + HWStatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentlabelF) + HWStatusCellBorderW;

        }
        
        //别转发微博的整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        //高度因为有无配图会发生变化，所以在配图里算。
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        //cell的高度
        self.cellHeight = CGRectGetMaxY(self.retweetViewF);

    }else{
        
        //cell的高度
        self.cellHeight = CGRectGetMaxY(self.originalViewF);

    }

}
@end

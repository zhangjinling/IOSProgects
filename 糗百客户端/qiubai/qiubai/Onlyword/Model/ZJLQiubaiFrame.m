//
//  ZJLQiubaiFrame.m
//  qiubai
//
//  Created by Seven on 15/8/1.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ZJLQiubaiFrame.h"

@implementation ZJLQiubaiFrame

- (void)setQiubai:(ZJLQiubai *)qiubai
{
    _qiubai = qiubai;
    ZJLUser *user = qiubai.user;
    //
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    //头像的位置
    CGFloat iconWH = 30;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);

    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HWStatusCellBorderW;
    CGFloat nameY = iconY+8;
    CGSize LoginSize = [user.login sizeWithfont:HWStatusCellNameFont];
    self.loginViewF = CGRectMake(nameX, nameY, LoginSize.width+100, LoginSize.height);
    
    //糗百内容
    CGFloat contentX = self.iconViewF.origin.x;
    CGFloat contentY = CGRectGetMaxY(self.iconViewF) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [qiubai.content sizeWithfont:HWStatusCellContentFont maxW:maxW];
    self.contnetViewF = (CGRect){{contentX,contentY},contentSize};

    //包含糗百的frame

    CGFloat originalH = CGRectGetMaxY(self.contnetViewF) + HWStatusCellBorderW;
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    self.cellHeight = CGRectGetMaxY(self.originalViewF);


    

}
@end

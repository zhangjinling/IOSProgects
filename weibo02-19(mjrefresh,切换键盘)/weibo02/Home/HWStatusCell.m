
//
//  HWStatusCell.m
//  weibo02
//
//  Created by Seven on 15/7/12.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStatus.h"
#import "HWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "HWUser.h"
#import "HWPhoto.h"
#import "HWStatusToolbar.h"
#import "HWStatusPhotosView.h"
#import "HWIconView.h"
@interface HWStatusCell()
//原创微博
//原创微博整体
@property (nonatomic ,weak) UIView *originalView;
//头像
@property (nonatomic ,weak) HWIconView *iconView;
//VIP标志
@property (nonatomic ,weak) UIImageView *vipView;
//配图
@property (nonatomic ,weak) HWStatusPhotosView *photosView;
//昵称
@property (nonatomic ,weak) UILabel *nameLabel;
//时间
@property (nonatomic ,weak) UILabel *timeLabel;
//来源
@property (nonatomic ,weak) UILabel *sourceLabel;
//正文
@property (nonatomic ,weak) UILabel *contentLabel;

/* 转发微博  */
//转发微博整体
@property (nonatomic ,weak) UIView  *retweetView;
//正文 + 昵称
@property (nonatomic ,weak) UILabel *retweetContentlabel;
//转发配图
@property (nonatomic ,weak) HWStatusPhotosView *retweetPhotosView;

/** 工具条 */
@property (nonatomic, weak) HWStatusToolbar *tooLbar;

@end

@implementation HWStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HWStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  cell方法初始化，一个cell只调用一次
 *  一般这里添加所有可能的子控件，以及子控件的一次性位置
 *
 *  @param style
 *  @param reuseIdentifier
 *
 *  @return
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //设置点击cell不变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //初始化原创微博
        [self setupOriginal];
        //初始化转发为微博
        [self setupRewtweet];
        //初始化工具条
        [self setupToolbar];
    }
    return self;
}
/**
 *  重写此方法给每个cell的Y + 15
 *
 *  @param frame
 */
//- (void)setFrame:(CGRect)frame
//{
//    frame.origin.y += HWStatusCellMargin;
//    [super setFrame:frame];
//    
//}
/**
 *  初始化工具条
 */
- (void)setupToolbar
{
    HWStatusToolbar *toolbar = [HWStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.tooLbar = toolbar;
}
//初始化转发微博
- (void)setupRewtweet
{
    //1.转发微博整体
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = HWColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    //转发微博配图
    HWStatusPhotosView *retweetPhotosView =[[HWStatusPhotosView alloc]init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    //转发微博正文+昵称
    UILabel *retweetContentlabel =[[UILabel alloc]init];
    retweetContentlabel.font = HWStatusCellRetweetContentFont;
    retweetContentlabel.numberOfLines = 0;
//    retweetContentlabel.font = HWStatusCellContentFont;
    [retweetView addSubview:retweetContentlabel];
    self.retweetContentlabel = retweetContentlabel;
}

//初始化原创微博
- (void) setupOriginal
{
    //1.原创微博整体
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    //头像
    HWIconView *iconView = [[HWIconView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    //VIP标志
    UIImageView *vipView =[[UIImageView alloc]init];
    //图片不拉伸
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    //配图
    HWStatusPhotosView *photosView =[[HWStatusPhotosView alloc]init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    //昵称
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = HWStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //时间
    UILabel *timeLabel =[[UILabel alloc]init];
    timeLabel.font = HWStatusCellTimeFont;
    [timeLabel setTextColor:[UIColor orangeColor]];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    //来源
    UILabel *sourceLabel =[[UILabel alloc]init];
    sourceLabel.font = HWStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    //正文
    UILabel *contentLabel =[[UILabel alloc]init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = HWStatusCellContentFont;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    

}

- (void)setStatusFrame:(HWStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //微博
    HWStatus *status = statusFrame.status;
    HWUser *user = status.user;
    //1.原创微博整体
    self.originalView.frame=statusFrame.originalViewF;
    //头像
    self.iconView.frame =statusFrame.iconViewF;
    self.iconView.user = user;
    //VIP标志
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame =statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.image = [UIImage imageNamed:vipName];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    //配图
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        //        HWPhoto *photo = [status.pic_urls firstObject];
        //不懂
//        NSArray *arr = status.pic_urls;
//        NSLog(@"thumbnail_pic:%d",arr.count);
//        [self.photosView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;
    }

    //昵称
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    
    //时间
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + HWStatusCellBorderW;
    CGSize timeSize = [time sizeWithfont:HWStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLabel.text = time;
    
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithfont:HWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = status.source;

//
//    //时间
//    self.timeLabel.frame =statusFrame.timeLabelF;
//    self.timeLabel.text = status.created_at;
    //来源
//    self.sourceLabel.frame = statusFrame.sourceLabelF;
//    self.sourceLabel.text = status.source;
    //正文
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;

    /**被转发转发微博**/
    
    if(status.retweeted_status){
        //转发微博
        HWStatus *retweeted_status = status.retweeted_status;
        //用户
        HWUser *retweeted_status_user = retweeted_status.user;
        self.retweetView.hidden = NO;
        //被转发微博整体
        self.retweetView.frame = statusFrame.retweetViewF;
        //被转发微博的正文
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentlabel.frame = statusFrame.retweetContentlabelF;
        self.retweetContentlabel.text = retweetContent;
        //被转发微博的配图
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;

            self.retweetPhotosView.photos = retweeted_status.pic_urls;
//            HWPhoto *retweetPhoto = [retweeted_status.pic_urls firstObject];
//            [self.retweetPhotosView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotosView.hidden = NO;
        }else{
            self.retweetPhotosView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    /** 工具条的frame */
    self.tooLbar.frame = statusFrame.toolbarF;
    self.tooLbar.status = status;
    
}
@end

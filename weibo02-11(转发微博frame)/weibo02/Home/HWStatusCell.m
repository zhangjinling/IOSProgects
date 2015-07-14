
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
@interface HWStatusCell()
//原创微博
//原创微博整体
@property (nonatomic ,weak) UIView *originalView;
//头像
@property (nonatomic ,weak) UIImageView *iconView;
//VIP标志
@property (nonatomic ,weak) UIImageView *vipView;
//配图
@property (nonatomic ,weak) UIImageView *photoView;
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
@property (nonatomic ,weak) UIImageView *retweetPhotoView;



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
        //初始化原创微博
        [self setupOriginal];
        //初始化转发为微博
        [self setupRewtweet];
    }
    return self;
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
    UIImageView *retweetPhotoView =[[UIImageView alloc]init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
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
    //        originalView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    //头像
    UIImageView *iconView = [[UIImageView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    //VIP标志
    UIImageView *vipView =[[UIImageView alloc]init];
    //图片不拉伸
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    //配图
    UIImageView *photoView =[[UIImageView alloc]init];
    [originalView addSubview:photoView];
    self.photoView = photoView;
    //昵称
    UILabel *nameLabel =[[UILabel alloc]init];
    nameLabel.font = HWStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    //时间
    UILabel *timeLabel =[[UILabel alloc]init];
    timeLabel.font = HWStatusCellTimeFont;
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
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
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
        self.photoView.frame = statusFrame.photoViewF;
        HWPhoto *photo = [status.pic_urls firstObject];
        //不懂
//        NSArray *arr = status.pic_urls;
//        NSLog(@"thumbnail_pic:%d",arr.count);
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }

    //昵称
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    //时间
    self.timeLabel.frame =statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    //来源
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
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
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            HWPhoto *retweetPhoto = [retweeted_status.pic_urls firstObject];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotoView.hidden = NO;
        }else{
            self.retweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
    
    
    
}
@end

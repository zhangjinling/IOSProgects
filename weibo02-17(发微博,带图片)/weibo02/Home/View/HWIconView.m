
//
//  HWIconView.m
//  weibo02
//
//  Created by Seven on 15/7/21.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"

@interface HWIconView()

@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation HWIconView
/** 懒加载 */
- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (void)setUser:(HWUser *)user
{
    _user = user;
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //判断加v图片
    /*
    HWUserVerifiedTypeNone = -1,//没有认证
    HWUserVerifiedTypePersonal = 0,//个人
    HWUserVerifiedTypeOrgEnterprise = 2,//企业
    HWUserVerifiedTypeOrgMedia = 3,//媒体
    HWUserVerifiedTypeOrgWebsite = 5,//网站
    HWUserVerifiedTypeDaren = 220 //微博达人
    */
    self.verifiedView.hidden = NO;
    switch (user.verified_type) {
//        case HWUserVerifiedTypeNone://没有认证
//            self.verifiedView.hidden = YES;
//            break;
        case HWUserVerifiedTypePersonal://个人认证
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUserVerifiedTypeOrgEnterprise://官方认证
        case HWUserVerifiedTypeOrgMedia:
        case HWUserVerifiedTypeOrgWebsite:
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];

            break;
            
        case HWUserVerifiedTypeDaren://微博达人
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];

            break;
        default:
            self.verifiedView.hidden = YES;//没有任何认证
            break;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}
@end

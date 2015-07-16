//
//  HWStatusToolbar.m
//  weibo02
//
//  Created by Seven on 15/7/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWStatusToolbar.h"
#import "HWStatus.h"

@interface HWStatusToolbar()
/** 里面存放按钮 */
@property (nonatomic, strong)NSMutableArray *btns;
/** 存放分割线 */
@property (nonatomic, strong)NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *reposetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation HWStatusToolbar
- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}
+ (instancetype)toolbar
{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        UIButton *reposetBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.reposetBtn = reposetBtn;
        UIButton *commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.commentBtn = commentBtn;
        UIButton *attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        self.attitudeBtn = attitudeBtn;
        
        //添加分割线
//        [self setupDivider];
//        [self setupDivider];


    }
    return self;
}
/**
 *  初始化一个按钮
 *
 *  @param title 按钮文字
 *  @param icon  按钮图标
 */
- (UIButton *) setupBtn:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger btnCount = self.btns.count;
    CGFloat btnH = self.height;
    CGFloat btnW = self.width / btnCount;
    for (int i = 0; i < btnCount; i ++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
//    //设置分割线的frame
    NSUInteger dividerCount = self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) *btnW;
        divider.y = 0;
    }
}
/**
 *  set 方法
 *
 *  @param status <#status description#>
 */
- (void)setStatus:(HWStatus *)status
{
    _status = status;
    //转发
    [self setupBtnCount:status.reposts_count title:@"转发" btn:self.reposetBtn];
    [self setupBtnCount:status.comments_count title:@"评论" btn:self.commentBtn];
    [self setupBtnCount:status.attitudes_count title:@"赞" btn:self.attitudeBtn];

}
- (void)setupBtnCount:(int)count title:(NSString *)title btn:(UIButton *)btn
{

    if (count) {//数字不为0。
        if(count < 10000){//直接显示数字
            title = [NSString stringWithFormat:@"%d",count];
        }else{//达到1万，不要1.0万的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f 万",wan];
        }
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    [btn setTitle:title forState:UIControlStateNormal];

}
@end

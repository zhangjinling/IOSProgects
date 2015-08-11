//
//  HMRightMenuController.m
//  wangyiNews
//
//  Created by Seven on 15/8/5.
//  Copyright (c) 2015年 seven. All rights reserved.
//  右侧控制器

#import "HMRightMenuController.h"
#import "HMRightCenterRow.h"

@interface HMRightMenuController ()
@property (weak, nonatomic) IBOutlet UIImageView *IconView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation HMRightMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.height = [UIScreen mainScreen].bounds.size.height;
    
    //1.填充之间的内容
    [self setupCenterView];
    //2.填充底部内容
    [self setupbottomView];

}
/**
 *  填充之间的view
 */
- (void)setupCenterView
{
    [self setupCenterViewRow:@"asdf asdf" icon:@"promoboard_icon_activities"];
    [self setupCenterViewRow:@"asdf asdfasdf" icon:@"promoboard_icon_apps"];
    [self setupCenterViewRow:@"asdf adsf" icon:@"promoboard_icon_mall"];

}
- (void)setupCenterViewRow: (NSString *)title icon:(NSString *)icon
{
    HMRightCenterRow *row = [HMRightCenterRow centerViewRow];
    row.title = title;
    row.icon = icon;
    row.y = row.height * self.centerView.subviews.count;
    [self.centerView addSubview:row];
//    UIView *centerRow = [[UIView alloc]init];
//    
//    UIButton *btn = [[UIButton alloc]init];
//    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:11.0];
//    [centerRow addSubview:btn];
}
/**
 *  填充底部view
 */
- (void)setupbottomView
{
    
}

- (void)didShow
{
    //让头像旋转
//    [UIView animateWithDuration:0.5 animations:^{
//        self.IconView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
//    }completion:^(BOOL finished) {
//        self.IconView.image = [UIImage imageNamed:@"top_navigation_infoicon"];
//        [UIView animateWithDuration:0.5 animations:^{
//            self.IconView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
//        }];
//    }];
    [UIView transitionWithView:self.IconView duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.IconView.image = [UIImage imageNamed:@"Default"];

    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self.IconView duration:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                self.IconView.image = [UIImage imageNamed:@"top_navigation_infoicon"];
                
            } completion:^(BOOL finished) {
            }];

            
        });
    }];
}

 
@end

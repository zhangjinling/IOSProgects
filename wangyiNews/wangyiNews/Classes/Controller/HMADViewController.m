//
//  HMADViewController.m
//  wangyiNews
//
//  Created by Seven on 15/8/4.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HMADViewController.h"

@interface HMADViewController ()

@end

@implementation HMADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景
    UIImageView *bg = [[UIImageView alloc]init];
    bg.image = [UIImage imageNamed:@"Default"];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    //广告图片
    UIImageView *ad = [[UIImageView alloc]init];
    UIImage *img = [UIImage imageNamed:@"AD"];
    ad.image  =img;

    ad.y = 10;
    ad.x = 20;
    ad.width = self.view.width - 2 * ad.x;
    ad.height = 350;
    [self.view addSubview:ad];
    //2秒后跳到下一个控制器
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
        
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  DetailViewController.h
//  block_01 传统代理方式
//
//  Created by Seven on 15/1/14.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailViewControllerDelegate <NSObject>

- (void)detailDone:(NSString *)text;

@end

@interface DetailViewController : UIViewController
@property(weak,nonatomic) id<DetailViewControllerDelegate>delegate;
@end


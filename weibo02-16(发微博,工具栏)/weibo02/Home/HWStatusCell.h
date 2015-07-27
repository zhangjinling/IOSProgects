//
//  HWStatusCell.h
//  weibo02
//
//  Created by Seven on 15/7/12.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatusFrame;

@interface HWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic ,strong)HWStatusFrame *statusFrame;
@end

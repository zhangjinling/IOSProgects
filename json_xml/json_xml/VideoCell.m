//
//  VideoCell.m
//  json_xml
//
//  Created by Seven on 15/6/7.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell
/*
 如果在自定义单元格中，修改了默认对象的位置，可以重写layoutSubviews方法，对视图中的所有控件的位置进行调整
 需要重写所有的控件
 */
#pragma mark - 重新调整UITableViewCell中的控件布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
    //将imageView的宽高设置为60
    [self.imageView setFrame:CGRectMake(10, 10, 60, 60)];
    [self.textLabel setFrame:CGRectMake(80, 10, 220, 30)];
    [self.detailTextLabel setFrame:CGRectMake(80, 50, 150, 20)];
    
    [self.teacherLabel setTextColor:[UIColor redColor]];
    [self.detailTextLabel setTextColor:[UIColor darkGrayColor]];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        //取消选中显示颜色
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(240, 50, 60, 20)];
        [self.contentView addSubview:label3];
        [label3 setBackgroundColor:[UIColor clearColor]];
        [label3 setTextColor:[UIColor darkGrayColor]];
        self.lengthlabel = label3;
        
    }
    return self;
}

#pragma mark - 选中或者撤销选中单元格的方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        //选中表格行
        [self setBackgroundColor:[UIColor yellowColor]];
        
    }else{
        //撤销选中表格行
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}
@end

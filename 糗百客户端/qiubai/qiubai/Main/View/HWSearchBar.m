//
//  HWSearchBar.m
//  weibo02
//
//  Created by Seven on 15/6/26.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:13.0];
        self.placeholder = @"搜索";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        

    }
    return self;
}
+ (instancetype)searchBar
{
    return [[self alloc]init];
}
@end

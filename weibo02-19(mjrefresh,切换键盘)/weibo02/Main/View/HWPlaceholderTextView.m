//
//  HWPlaceholderTextView.m
//  weibo02
//
//  Created by Seven on 15/7/25.
//  Copyright (c) 2015年 seven. All rights reserved.
//  

#import "HWPlaceholderTextView.h"

@implementation HWPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //可以使用uilabel设置占位文字，通过显示于隐藏控制。
//        UILabel *laberl = [[UILabel alloc]init];
        //监听textView的文字是否有，不要使用自己代理
//        self.delegate = self;
        //通过通知
        //当UITextView的文字发生改变时 ， UITextView自己会发出一个didChange的通知
        //意思就是object发出一个通知让 Observer执行selector方法
        [HWNotificationCenter addObserver:self selector:@selector(textDidChange
                                                                  ) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/**
 *  监听文字改变
 */
- (void)textDidChange
{
    //重新绘制
    //重新调用drawRect方法
    [self setNeedsDisplay];
}
/**
 *  控制器没有就不在监听
 */
- (void)dealloc
{
    [HWNotificationCenter removeObserver:self];
}
- (void)drawRect:(CGRect)rect
{
    //如果有输入文字就不绘制输入文字
    if (self.hasText)return;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor :[UIColor grayColor];
    //这个方法不会在占位文字多的时候不会换行
//    [self.placeholder drawAtPoint:CGPointMake(5,8) withAttributes:attrs];
    //文字多的时候会换行
    HWLog(@"%@",NSStringFromCGRect(rect));
    CGFloat x = 5 ;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w,h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}
/**
 *  set方法 颜色改变时刷新drawrect方法
 *
 *  @param placeholderColor <#placeholderColor description#>
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
@end

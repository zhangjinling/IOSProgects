//
//  ViewController.m
//  04.监听用户点击视图
//
//  Created by Seven on 15/1/19.
//  Copyright (c) 2015年 seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //让imageView接受用户触摸
    [self.imageView setUserInteractionEnabled:YES];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //1.获取用户点击
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    CGPoint preLocation = [touch previousLocationInView:self.view];
    CGPoint dertPoint = CGPointMake(location.x - preLocation.x, location.y - preLocation.y);
    //2.判断点击了那个视图
    if ([touch view] == self.imageView) {
        NSLog(@"点击了图像");
        
        [self.imageView setCenter:CGPointMake(self.imageView.center.x + dertPoint.x, self.imageView.center.y + dertPoint.y)];
    }else if ([touch view] == self.redView){
        NSLog(@"点击了 hongse");
        [self.redView setCenter:CGPointMake(self.redView.center.x + dertPoint.x, self.redView.center.y + dertPoint.y)];
        
    }else if ([touch view] == self.greenView){
        //提示最好不要直接用else处理，因为随时有可能添加新的控件
        NSLog(@"点击 green");
        [self.greenView setCenter:CGPointMake(self.greenView.center.x + dertPoint.x, self.greenView.center.y + dertPoint.y)];
    }
    
}
@end

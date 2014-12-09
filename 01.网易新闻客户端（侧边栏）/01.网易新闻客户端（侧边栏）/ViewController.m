//
//  ViewController.m
//  01.网易新闻客户端（侧边栏）
//
//  Created by Seven on 14/12/8.
//  Copyright (c) 2014年 seven. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (strong,nonatomic) RightViewController *rightController;
@property (strong,nonatomic) LeftViewController *leftController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //实例化右侧的用户视图
    self.rightController = [[RightViewController alloc]init];
    //指定代理
    [self.rightController setDelegate:self];

    [self.rightView addSubview:self.rightController.view];
    //实例化左侧菜单式图
    self.leftController = [[LeftViewController alloc]init];
    //设置代理
    [self.leftController setMenuDelegate:self];
    [self.leftView addSubview:self.leftController.view];
    
    //指定初始的内容视图
    [self LeftViewController:nil className:@"NewsViewController"];

}



- (IBAction)leftButton:(id)sender {
    CGRect newFrame = CGRectZero;
    //根据内容视图的x点判断内容视图是否被移动
    if (0 == self.contentView.frame.origin.x) {
        //没有移动，要移动,设置新的frame
        newFrame = CGRectMake(self.leftView.frame.size.width, 20, 320, 460);
    }else{
        //已经移动，要收回,设置新的frame
        newFrame = CGRectMake(0, 20, 320, 460);
    }
    [self.leftView setHidden:NO];
    [self.rightView setHidden:YES];
    [UIView animateWithDuration:0.4 animations:^{
        [self.contentView setFrame:newFrame];
    }];
    
}

- (IBAction)rightButton:(id)sender {
    CGRect newFrame = CGRectZero;
    //根据内容视图的x点判断内容视图是否被移动
    if (0 == self.contentView.frame.origin.x) {
        //没有移动，要向左移动,设置新的frame
        newFrame = CGRectMake(-self.rightView.frame.size.width, 20, 320, 460);
    }else{
        //已经移动，要收回,设置新的frame
        newFrame = CGRectMake(0, 20, 320, 460);
    }
    [self.leftView setHidden:YES];
    [self.rightView setHidden:NO];
    [UIView animateWithDuration:0.4 animations:^{
        [self.contentView setFrame:newFrame];
    }];
}
#pragma mark - uiimagePicker的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    [self.rightController.photoButton setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
#warning 在正常开发中不要忘记把照片保存在沙箱中
}
#pragma mark - 右侧视图的代理方法
- (void)rightViewControllerDidSelectPhoto
{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setAllowsEditing:YES];
        [picker setDelegate:self];
        [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - 左侧菜单式图的代理方法
- (void)LeftViewController:(LeftViewController *)controller className:(NSString *)className
{
    /*
     选中表格行的处理的事情：
     1>.关闭菜单栏视图
     2>.加载选中项对应的视图控制器
     */
    //关闭视图
    if (controller != nil) {
        [self leftButton:nil];
    }
    
    //加载相应的控制器
    //把原有的视图从站位试图中清理掉
    for (UIView *view in self.contentView.subviews) {
        if (![view isKindOfClass:[UINavigationBar class]]) {
            [view removeFromSuperview];
        }
    }
    //从字符串加载类
    Class c = NSClassFromString(className);
    //注意此处实例化不能使用uiviewcontroller
    UIViewController *vc = [[c alloc]init];
    [self.contentView insertSubview:vc.view atIndex:0];
}
@end

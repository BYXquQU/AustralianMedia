//
//  SFTabBarController.m
//  AustralianMedia
//
//  Created by saifing on 16/8/17.
//  Copyright © 2016年 saifing. All rights reserved.
//

#import "SFTabBarController.h"
#import "UIImage+RenderMode.h"

#import "SFOneTabbarController.h"
#import "SFTwoTabBarController.h"
#import "SFMeViewController.h"
#import "SFNavigationController.h"

@interface SFTabBarController ()

@end

@implementation SFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllViewController];
}

#pragma mark -添加所有的控制器
- (void)setUpAllViewController {
    
    
    
    //首页
    SFOneTabbarController *home = [[SFOneTabbarController alloc]init];
    [self setUpOneViewController:home image:[UIImage imageNamed:@"1.food"] selectedImage:[UIImage imageRenderingModeImageNamed:@"10.footladder"] title:@"one"];
    
    //第二页
    
    SFTwoTabBarController *second = [[SFTwoTabBarController alloc]init];
    [self setUpOneViewController:second image:[UIImage imageNamed:@"11.ATM"] selectedImage:[UIImage imageRenderingModeImageNamed:@"12.park"] title:@"two"];
    
    //我
    
    SFMeViewController *me = [[SFMeViewController alloc]init];
    [self setUpOneViewController:me image:[UIImage imageNamed:@"13.bashroom"] selectedImage:[UIImage imageRenderingModeImageNamed:@"14.phone"] title:@"我"];
    
    
    
}

#pragma mark -添加一个自控制器
- (void)setUpOneViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title {
    
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    viewController.title = title;
//    viewController.tabBarItem.badgeValue = @"10";
    SFNavigationController *navi = [[SFNavigationController alloc]initWithRootViewController:viewController];
    
    
    [self addChildViewController:navi];
}

#pragma mark -随笔笔记

/* tabBarItem属性的设置 **/
//Item就是苹果的模型命名规范
//tabBarItem决定tabbar上面的内容
//如果通过模型模型设置控件的文本颜色,只能通过文本属性(富文本:颜色, 字体,空心,阴影,图文混排)

/*底层方法的调用时间及作用 **/

/**
 *  什么时候调用:程序已启动的时候就会把所有的类加载进内存
 *  作用;加载类的时候调用
 */
//+ (void)load {
//    NSLog(@"%s", __func__);
//}

/**
 *  什么时候调用:当第一次使用这个类或其子类的时候调用
 *  作用;初始化类
 */
+ (void)initialize {
    
    //获取所有的item的外观标识(包括系统自带的)
//    UITabBarItem *item = [UITabBarItem appearance];
    //指定item的外观标识
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:[NSArray arrayWithObjects:[self class], nil]];
    
    //设置字体颜色(通过富文本)
    NSMutableDictionary *att = [[NSMutableDictionary alloc]init];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

@end

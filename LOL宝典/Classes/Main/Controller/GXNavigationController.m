//
//  GXNavigationController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXNavigationController.h"

@interface GXNavigationController ()

@end

@implementation GXNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 *  当第一次加载这个类的时候调用一次
 */
+ (void)initialize
{
    // 设置BarButtonItem主题
    [self setBarButtonItemTheme];
    
    // 设置NavigationBar主题
    [self setNavigationBarTheme];
}

+ (void)setNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    if (!iOS7) {
        [appearance setBackgroundImage:[UIImage imageNamed:@"bg_nav_bar"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [appearance setBackgroundImage:[UIImage imageNamed:@"bg_nav_bar_iOS7"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    // 设置标题字体颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor wheatColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
    
}

+ (void)setBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIbarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    // 1.设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor wheatColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:15];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 2.设置高亮状态下的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[UITextAttributeTextColor] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器（最先push进来的那个控制器）
        // 就隐藏下面的TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end

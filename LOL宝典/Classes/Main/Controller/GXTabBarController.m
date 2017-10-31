//
//  GXTabBarController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXTabBarController.h"
#import "GXLiveListController.h"
#import "GXHeroController.h"
#import "GXStoryController.h"
#import "GXVideoController.h"
#import "GXHeroToolController.h"
#import "GXNavigationController.h"

@interface GXTabBarController ()

@end

@implementation GXTabBarController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor wheatColor];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bg_tab_bar"];
    [self addAllChildVcs];
}

/**
 *  添加所有子控制器
 */
- (void)addAllChildVcs
{
    GXHeroController *hero = [[GXHeroController alloc] init];
    [self addOneChildVc:hero title:@"英雄信息" imageName:@"guide2_1" selectedImageName:@"guide2_2"];
    
    GXVideoController *video = [[GXVideoController alloc] init];
    [self addOneChildVc:video title:@"高清视频" imageName:@"guide1_1" selectedImageName:@"guide1_2"];
    
    GXLiveListController *live = [[GXLiveListController alloc] init];
    [self addOneChildVc:live title:@"视频直播" imageName:@"guide3_1" selectedImageName:@"guide3_2"];
    
    GXStoryController *story = [[GXStoryController alloc] init];
    [self addOneChildVc:story title:@"英雄故事" imageName:@"guide4_1" selectedImageName:@"guide4_2"];
    
    GXHeroToolController *tool = [[GXHeroToolController alloc] init];
    [self addOneChildVc:tool title:@"工具" imageName:@"guide5_1" selectedImageName:@"guide5_2"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置标题
    childVc.title = title;
    
    // 2.设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 3.设置TabBarItem的普通状态下文字颜色
    NSMutableDictionary *normalTextAttrs = [NSMutableDictionary dictionary];
    normalTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    normalTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:normalTextAttrs forState:UIControlStateNormal];
    
    // 4.设置TabBarItem的选中状态下文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:75/255.0 green:127/255.0 blue:246/255.0 alpha:1.0];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 5.设置选中状态图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        // 声明这张图片用原图，（别渲染）
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    // 6.添加为TabBar控制器的子控制器(导航控制器)
    GXNavigationController *nav = [[GXNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end

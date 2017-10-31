//
//  GXSettingController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSettingController.h"
#import "GXCommonArrowItem.h"
#import "GXCommonItem.h"
#import "GXCommonGroup.h"
#import "GXCommonSwitchItem.h"
#import "GXAboutController.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+File.h"

@interface GXSettingController ()

@end

@implementation GXSettingController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GXCommonArrowItem *download = [GXCommonArrowItem itemWithIcon:nil title:@"离线下载" subTitle:@"下载英雄攻略资源包，提高使用速度"];
    
    GXCommonArrowItem *check = [GXCommonArrowItem itemWithTitle:@"检查更新"];
    GXCommonSwitchItem *light = [GXCommonSwitchItem itemWithIcon:nil title:@"保持屏幕常亮" subTitle:@"打开应用后保持屏幕不锁屏"];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [caches stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    NSString *fileSize = [NSString stringWithFormat:@"   (%.1fM)", [filePath fileSize] / (1000.0 * 1000.0)];
    GXCommonArrowItem *removePic = [GXCommonArrowItem itemWithIcon:nil title:@"清除图片缓存" subTitle:fileSize];
    
    __weak typeof (self) weakVc = self;
    __weak typeof (removePic) weakRemove = removePic;
    removePic.operation = ^{
        [MBProgressHUD showMessage:@"正在清除图片缓存..."];
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // 清除缓存
        [mgr removeItemAtPath:filePath error:nil];
        
        // 设置子标题
        weakRemove.subTitle = nil;
        
        // 刷新表格
        [weakVc.tableView reloadData];
        
        // 隐藏弹出
        [MBProgressHUD hideHUD];
    };
    
    GXCommonGroup *group1 = [[GXCommonGroup alloc] init];
    group1.items = @[download, check, light, removePic];
    
    GXCommonArrowItem *react = [GXCommonArrowItem itemWithTitle:@"反馈"];
    GXCommonArrowItem *about = [GXCommonArrowItem itemWithTitle:@"关于"];
    about.destVcClass = [GXAboutController class];
    
    GXCommonGroup *group2 = [[GXCommonGroup alloc] init];
    group2.items = @[react, about];
    [self.groups addObject:group1];
    [self.groups addObject:group2];
    
}


@end

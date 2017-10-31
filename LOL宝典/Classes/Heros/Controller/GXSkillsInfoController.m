//
//  GXSkillsInfoController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXSkillsInfoController.h"
#import "MBProgressHUD+MJ.h"
#import "GXHeroTool.h"
#import "GXSkillsDetailView.h"

@interface GXSkillsInfoController ()
@property (nonatomic, strong) GXSkillsDetailView *detailView;
@end

@implementation GXSkillsInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor wheatColor];
    self.title = @"技能详情";
    GXSkillsDetailView *detailView = [[GXSkillsDetailView alloc] init];
    detailView.frame = self.view.bounds;
    [self.view addSubview:detailView];
    self.detailView = detailView;
    [self loadEquipmentDetailInfo];
}

- (void)loadEquipmentDetailInfo
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXHeroTool loadHeroSkillsInfoWithChampionName:self.skillsId success:^(GXSkills *result) {
        [MBProgressHUD hideHUD];
        self.detailView.skillsInfo = result;
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败，请检查网络"];
    }];
}

@end

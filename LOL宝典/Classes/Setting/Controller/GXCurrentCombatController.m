//
//  GXCurrentCombatController.m
//  LOL宝典
//
//  Created by sgx on 14-8-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCurrentCombatController.h"
#import "GXUser.h"
#import "MBProgressHUD+MJ.h"
#import "UIBarButtonItem+Extension.h"
#import "GXShakeResult.h"
#import "GXCurrentBattleCell.h"
#import "GXShakeHeroInfo.h"
#import "GXCombatController.h"
#import "GXHeroIntroductionController.h"
#import "GXUser.h"
#import "GXTabBarController.h"
#import "GXNavigationController.h"

@interface GXCurrentCombatController ()

@end

@implementation GXCurrentCombatController

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
    
    self.view.backgroundColor = [UIColor wheatColor];
//    self.tableView.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.shakeResult.own_sort.count;
    } else {
        return self.shakeResult.enemy_sort.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"我方军团（按战斗力排序）";
    } else {
        return @"敌方军团（按战斗力排序）";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXCurrentBattleCell *cell = [GXCurrentBattleCell cellWithTableView:tableView];
    
    if (indexPath.section == 0) {
        GXShakeHeroInfo *heroInfo = self.shakeResult.own_sort[indexPath.row];
        cell.heroInfo = heroInfo;
    } else {
        GXShakeHeroInfo *heroInfo = self.shakeResult.enemy_sort[indexPath.row];
        cell.heroInfo = heroInfo;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        GXShakeHeroInfo *heroInfo = self.shakeResult.own_sort[indexPath.row];
        [self switchViewControllerWith:heroInfo];
    } else {
        GXShakeHeroInfo *heroInfo = self.shakeResult.enemy_sort[indexPath.row];
        [self switchViewControllerWith:heroInfo];
    }
}

/**
 *  根据选中英雄跳转控制器
 */
- (void)switchViewControllerWith:(GXShakeHeroInfo *)heroInfo
{
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    NSString *playerName = [defaults objectForKey:GXPlayerName];
    if ([[heroInfo.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isEqualToString:playerName]) {
        GXHeroIntroductionController *introVc = [[GXHeroIntroductionController alloc] init];
        introVc.champtionName = heroInfo.heroName;
        [self.navigationController pushViewController:introVc animated:YES];
    } else {
        GXUser *user = [[GXUser alloc] init];
        user.serverName = heroInfo.sn;
        user.playerName = [heroInfo.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // 跳转到战斗力查询页面
        GXCombatController *combatVc = [[GXCombatController alloc] init];
        combatVc.user = user;
        [self.navigationController pushViewController:combatVc animated:YES];
    }
}
@end

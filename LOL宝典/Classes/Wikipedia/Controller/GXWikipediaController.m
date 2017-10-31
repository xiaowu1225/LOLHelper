//
//  GXWikipediaController.m
//  LOL宝典
//
//  Created by sgx on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXWikipediaController.h"
#import "GXCommonArrowItem.h"
#import "GXCommonGroup.h"
#import "GXEquipmentController.h"
#import "GXEquitmentTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXSkillsController.h"
#import "GXTalentController.h"
#import "GXCombatController.h"
#import "GXCharmController.h"
#import "GXAddWebViewController.h"

@interface GXWikipediaController ()

@end

@implementation GXWikipediaController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addUrlStr)];
    GXCommonArrowItem *equipment = [GXCommonArrowItem itemWithIcon:@"icon_item_s_h" title:@"装备"];
    equipment.destVcClass = [GXEquipmentController class];
    GXCommonArrowItem *rune = [GXCommonArrowItem itemWithIcon:@"icon_gift_s_h" title:@"天赋"];
    rune.destVcClass = [GXTalentController class];
    GXCommonArrowItem *talent = [GXCommonArrowItem itemWithIcon:@"icon_runnes_s_h" title:@"符文"];
    talent.destVcClass = [GXCharmController class];
    GXCommonArrowItem *lineup = [GXCommonArrowItem itemWithIcon:@"icon_combat_s_h" title:@"战绩查询"];
    lineup.destVcClass = [GXCombatController class];
    GXCommonArrowItem *skills = [GXCommonArrowItem itemWithIcon:@"icon_sum_ability_s_h" title:@"召唤师技能列表"];
    skills.destVcClass = [GXSkillsController class];
    
    GXCommonGroup *group = [[GXCommonGroup alloc] init];
    group.items = @[equipment, rune, talent, lineup, skills];
    [self.groups addObject:group];
}

- (void)addUrlStr
{
    GXAddWebViewController *addWebVc = [[GXAddWebViewController alloc] init];
    [self.navigationController pushViewController:addWebVc animated:YES];
}

@end

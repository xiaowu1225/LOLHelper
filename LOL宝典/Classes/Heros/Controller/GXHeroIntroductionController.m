//
//  GXHeroIntroductionController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroIntroductionController.h"
#import "GXHeroCellModel.h"
#import "GXHeroIntroductionCell.h"
#import "GXHeroIntroduction.h"
#import "GXHeroTool.h"
#import "MJExtension.h"
#import "GXHeroIntroductionView.h"
#import "GXTitleButton.h"
#import "GXTitleView.h"
#import "GXHeroSelectCell.h"
#import "MBProgressHUD+MJ.h"
#import "GXGiftViewController.h"
#import "GXEquitmentInfoController.h"
#import "GXEquipmentInfo.h"
#import "GXSkillsInfoController.h"
#import "GXHeroVideoController.h"

@interface GXHeroIntroductionController ()<UITableViewDataSource, UITableViewDelegate, GXTitleViewDelegate>
@property (nonatomic, weak) GXTitleButton *titleButton;
@property (nonatomic, strong) NSArray *introductions;
@property (nonatomic, weak) GXTitleView *titleView;
@property (nonatomic, weak) GXHeroIntroductionView *introView;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *cover;
@property (nonatomic, strong) GXHeroIntroduction *currentCell;
@end

@implementation GXHeroIntroductionController

- (NSArray *)introductions
{
    if (_introductions == nil) {
        _introductions = [NSArray array];
    }
    return _introductions;
}

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"英雄视频" style:UIBarButtonItemStylePlain target:self action:@selector(toHeroVideoList)];
    // 设置导航栏中间按钮
    [self setupCenterTitle];
    
    // 加载英雄信息
    [self loadHeroIntroduction];
    
    // 创建头部视图
    GXTitleView *titleView = [[GXTitleView alloc] init];
    titleView.backgroundColor = [UIColor wheatColor];
    titleView.frame = CGRectMake(0, 0, GXScreenWidth, 74);
    titleView.delegate = self;
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 创建instroView
    GXHeroIntroductionView *instroView = [[GXHeroIntroductionView alloc] init];
    instroView.skillBlock = ^(NSString *skillsId) {
        GXSkillsInfoController *skillsVc = [[GXSkillsInfoController alloc] init];
        skillsVc.skillsId = skillsId;
        [self.navigationController pushViewController:skillsVc animated:YES];
    };
    instroView.equipmentBlock = ^(NSString *equipmentId) {
        GXEquitmentInfoController *equipmentVc = [[GXEquitmentInfoController alloc] init];
        GXEquipmentInfo *equipmentInfo = [[GXEquipmentInfo alloc] init];
        equipmentInfo.id = equipmentId;
        equipmentVc.equipmentInfo = equipmentInfo;
        [self.navigationController pushViewController:equipmentVc animated:YES];
    };
    instroView.backgroundColor = [UIColor whiteColor];
    instroView.frame = CGRectMake(0, 74, GXScreenWidth, GXScreenHeight - 90 - 49);
    [self.view addSubview:instroView];
    self.introView = instroView;
    
    // 创建遮盖
    UIButton *cover = [[UIButton alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.2;
    cover.hidden = YES;
    cover.frame = self.view.bounds;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(20, 0, 280, 300);
    tableView.hidden = YES;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}


- (void)loadHeroIntroduction
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXHeroTool loadHerosIntroductionWithChampionName:self.champtionName success:^(NSArray *result) {
        [MBProgressHUD hideHUD];
        self.introductions = result;
        GXHeroIntroduction *intro = [self.introductions firstObject];
        intro.selected = YES;
        self.currentCell = intro;
        self.introView.introduction = intro;
        self.titleView.introduction = intro;
        [self.titleButton setTitle:intro.title forState:UIControlStateNormal];
        [self.titleButton setTitleColor:[UIColor wheatColor] forState:UIControlStateNormal];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
}

- (void)setupCenterTitle
{
    // 设置导航栏中间的标题按钮
    GXTitleButton *titleButton = [[GXTitleButton alloc] init];
    self.titleButton = titleButton;
    
    // 设置尺寸
    titleButton.height = 35;
    // 设置文字
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    // 设置图标
    [titleButton setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    // 设置背景图片
    [titleButton setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

/**
 *  点击标题按钮
 */
- (void)titleClick:(GXTitleButton *)titlebutton
{
    self.tableView.hidden = !self.tableView.hidden;
    self.cover.hidden = !self.cover.hidden;
    [self.tableView reloadData];
    titlebutton.imageView.transform = CGAffineTransformRotate(titlebutton.imageView.transform, M_PI);
}
/**
 *  点击遮盖
 */
- (void)coverClick
{
    [self titleClick:self.titleButton];
}

#pragma mark - UItableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.introductions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXHeroSelectCell *cell = [GXHeroSelectCell cellWithTableView:tableView];
    
    GXHeroIntroduction *selectedModel = self.introductions[indexPath.row];

    cell.selectedModel = selectedModel;
    
    return cell;
}

#pragma mark - UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentCell.selected = NO;
    GXHeroIntroduction *intro = self.introductions[indexPath.row];
    intro.selected = YES;
    self.currentCell = intro;
    self.introView.introduction = intro;
    [self.tableView reloadData];
    self.tableView.hidden = YES;
    self.cover.hidden = YES;
    [self.titleButton setTitle:intro.title forState:UIControlStateNormal];
}

#pragma mark - GXTitleViewDelegate
- (void)giftBtnDidClickWithHeroName:(NSString *)heroName
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXHeroTool loadHeroGiftInfoWithChampionName:heroName success:^(GXGift *result) {
        [MBProgressHUD hideHUD];
        if (result) {
            GXGiftViewController *giftVc = [[GXGiftViewController alloc] init];
            giftVc.gift = result;
            [self.navigationController pushViewController:giftVc animated:YES];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
}

- (void)toHeroVideoList
{
    GXHeroVideoController *heroVideoVc = [[GXHeroVideoController alloc] init];
    heroVideoVc.heroName = self.champtionName;
    GXHeroIntroduction *introduction = self.titleView.introduction;
    heroVideoVc.title = introduction.ch_name;
    [self.navigationController pushViewController:heroVideoVc animated:YES];
}

@end

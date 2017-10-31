//
//  GXCharmController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXCharmController.h"
#import "GXCharmTool.h"
#import "GXCharmInfo.h"
#import "GXCharmShowInfo.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "GXCharmCell.h"

@interface GXCharmController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *currentChramList;
@property (nonatomic, strong) NSDictionary *allChramInfo;
@property (nonatomic, strong) NSArray *levelArr;
@property (nonatomic, strong) NSArray *typeArr;
@property (nonatomic, strong) NSDictionary *currentLevel;
@property (nonatomic, strong) NSDictionary *currentType;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *levelBtn;
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, weak) UIButton *cover;
@end

@implementation GXCharmController

- (NSArray *)levelArr
{
    if (_levelArr == nil) {
        _levelArr = @[@{@"value": @"1", @"name": @"1级"}, @{@"value": @"2", @"name": @"2级"}, @{@"value": @"3", @"name": @"3级"}];
    }
    return _levelArr;
}

- (NSArray *)typeArr
{
    if (_typeArr == nil) {
        _typeArr = @[@{@"value": @"Red", @"name": @"印记"}, @{@"value": @"Blue", @"name": @"雕纹"}, @{@"value": @"Yellow", @"name": @"符印"}, @{@"value": @"Purple", @"name": @"精华"}];
    }
    return _typeArr;
}

- (NSMutableArray *)currentChramList
{
    if (_currentChramList == nil) {
        _currentChramList = [NSMutableArray array];
    }
    return _currentChramList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentLevel = [self.levelArr firstObject];
    self.currentType = [self.typeArr firstObject];
    [self setupTableView];
    [self setupHeaderView];
    [self loadCharmList];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(44, 0, 64, 0);
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.layer.masksToBounds = YES;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor wheatColor];
    headerView.frame = CGRectMake(0, 0, GXScreenWidth, 44);
    UIButton *levelBtn = [[UIButton alloc] init];
    levelBtn.frame = CGRectMake(0, 0, GXScreenWidth * 0.5, 44);
    [levelBtn setTitle:self.currentLevel[@"name"] forState:UIControlStateNormal];
    [levelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [levelBtn addTarget:self action:@selector(levelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:levelBtn];
    self.levelBtn = levelBtn;
    UIButton *typeBtn = [[UIButton alloc] init];
    typeBtn.frame = CGRectMake(GXScreenWidth * 0.5, 0, GXScreenWidth * 0.5, 44);
    [typeBtn setTitle:self.currentType[@"name"] forState:UIControlStateNormal];
    [typeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [typeBtn addTarget:self action:@selector(typeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:typeBtn];
    self.typeBtn = typeBtn;
    [self.view addSubview:headerView];
}

- (void)levelBtnClick
{
    UIView *containerView = [[UIView alloc] init];
    containerView.frame = CGRectMake(20, 44, 120, 44 * self.levelArr.count);
    [self.levelArr enumerateObjectsUsingBlock:^(NSDictionary *level, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 44 * idx, 120, 44);
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor goldenrodColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor goldColor]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor bananaColor]] forState:UIControlStateSelected];
        [button setTitle:level[@"name"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(levelItemSelect:) forControlEvents:UIControlEventTouchUpInside];
        if ([level[@"value"] isEqualToString:self.currentLevel[@"value"]]) {
            button.selected = YES;
        }
        [containerView addSubview:button];
        UIView *deviderLine = [[UIView alloc] init];
        deviderLine.backgroundColor = [UIColor darkGrayColor];
        deviderLine.frame = CGRectMake(0, 44 * (idx + 1) - 0.5, 120, 0.5);
        if (idx != self.levelArr.count - 1) {
            [containerView addSubview:deviderLine];
        }
    }];
    // 添加一个朦板
    if (!self.cover) {
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = CGRectMake(0, 0, GXScreenWidth, GXScreenHeight);
        cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cover];
        self.cover = cover;
    }
    [self.cover addSubview:containerView];
}

/**
 *  点击朦板
 */
- (void)coverClick
{
    // 删除朦板
    [self.cover removeFromSuperview];
}

- (void)levelItemSelect:(UIButton *)levelItem
{
    [self coverClick];
    [self.levelArr enumerateObjectsUsingBlock:^(NSDictionary *level, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([levelItem.titleLabel.text isEqualToString:level[@"name"]]) {
            self.currentLevel = level;
            [self formartData];
            *stop = YES;
        }
    }];
}

- (void)typeBtnClick
{
    UIView *containerView = [[UIView alloc] init];
    containerView.frame = CGRectMake(180, 44, 120, 44 * self.typeArr.count);
    [self.typeArr enumerateObjectsUsingBlock:^(NSDictionary *type, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 44 * idx, 120, 44);
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor goldenrodColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor goldColor]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor bananaColor]] forState:UIControlStateSelected];
        [button setTitle:type[@"name"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(typeItemSelect:) forControlEvents:UIControlEventTouchUpInside];
        if ([type[@"value"] isEqualToString:self.currentType[@"value"]]) {
            button.selected = YES;
        }
        [containerView addSubview:button];
        UIView *deviderLine = [[UIView alloc] init];
        deviderLine.backgroundColor = [UIColor darkGrayColor];
        deviderLine.frame = CGRectMake(0, 44 * (idx + 1) - 0.5, 120, 0.5);
        if (idx != self.typeArr.count - 1) {
            [containerView addSubview:deviderLine];
        }
    }];
    // 添加一个朦板
    if (!self.cover) {
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = CGRectMake(0, 0, GXScreenWidth, GXScreenHeight);
        cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cover];
        self.cover = cover;
    }
    [self.cover addSubview:containerView];
}

- (void)typeItemSelect:(UIButton *)typeItem
{
    [self coverClick];
    [self.typeArr enumerateObjectsUsingBlock:^(NSDictionary *type, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([typeItem.titleLabel.text isEqualToString:type[@"name"]]) {
            self.currentType = type;
            [self formartData];
            *stop = YES;
        }
    }];
}

- (void)loadCharmList
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXCharmTool loadCharmInfoSuccess:^(NSDictionary *result) {
        [MBProgressHUD hideHUD];
        self.allChramInfo = result;
        [self formartData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
}

- (void)formartData
{
    NSArray *chramLevelList = [GXCharmInfo objectArrayWithKeyValuesArray:self.allChramInfo[self.currentType[@"value"]]];
    [self.currentChramList removeAllObjects];
    [chramLevelList enumerateObjectsUsingBlock:^(GXCharmInfo *charmInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        GXCharmShowInfo *charmShowInfo = [[GXCharmShowInfo alloc] init];
        charmShowInfo.imagePath = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/runes/%@_%@.png", charmInfo.Img, self.currentLevel[@"value"]];
        NSString *level = @"";
        NSString *iplev = @"";
        if ([self.currentLevel[@"value"] isEqualToString:@"1"]) {
            level = charmInfo.lev1;
            iplev = charmInfo.iplev1;
        } else if ([self.currentLevel[@"value"] isEqualToString:@"2"]) {
            level = charmInfo.lev2;
            iplev = charmInfo.iplev2;
        } else if ([self.currentLevel[@"value"] isEqualToString:@"3"]) {
            level = charmInfo.lev3;
            iplev = charmInfo.iplev3;
        }
        charmShowInfo.topDesc = charmInfo.Name;
        charmShowInfo.midDesc = [NSString stringWithFormat:@"%@ 游戏币 %@", self.currentLevel[@"name"], iplev];
        charmShowInfo.bottomDesc = [NSString stringWithFormat:@"%@%@%@", level, charmInfo.Units, charmInfo.Prop];
        [self.currentChramList addObject:charmShowInfo];
    }];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentChramList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXCharmCell *cell = [GXCharmCell cellWithTableView:tableView];
    GXCharmShowInfo *charmShowInfo = self.currentChramList[indexPath.row];
    cell.charmshowInfo = charmShowInfo;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXCharmShowInfo *charmShowInfo = self.currentChramList[indexPath.row];
    return charmShowInfo.cellHeight;
}

@end

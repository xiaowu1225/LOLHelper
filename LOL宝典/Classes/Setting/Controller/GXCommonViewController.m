//
//  GXCommonViewController.m
//  新浪微博
//
//  Created by sgx on 14-7-22.
//  Copyright (c) 2014年 itcast. All rights reserved.
//


#import "GXCommonViewController.h"
#import "GXCommonCell.h"
#import "GXCommonGroup.h"
#import "GXCommonItem.h"
#import "GXCommonMarkItem.h"

@interface GXCommonViewController ()

@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation GXCommonViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (id)init
{
    // 设置分组样式
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // 隐藏分割线
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.contentInset = UIEdgeInsetsMake(10 - 35, 0, 0, 0);
        self.tableView.sectionHeaderHeight = 0;
        self.tableView.sectionFooterHeight = 20;
        self.tableView.backgroundColor = [UIColor wheatColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GXCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXCommonCell *cell = [GXCommonCell cellWithTableView:tableView];
    
    GXCommonGroup *group = self.groups[indexPath.section];
    
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    
    cell.item = group.items[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    GXCommonGroup *group = self.groups[indexPath.section];
    GXCommonItem *item = group.items[indexPath.row];
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无需要执行的操作
    if (item.operation) {
        item.operation();
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    GXCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    GXCommonGroup *group = self.groups[section];
    return group.header;
}

@end

//
//  GXLocalVideoController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXLocalVideoController.h"
#import "GXVideoDownloadCell.h"
#import "GXDownLoadTool.h"
#import "GXVideoInfo.h"
#import "MJExtension.h"
#import "GXMoviePlayerViewController.h"

@interface GXLocalVideoController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, GXVideoDownloadCellDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *downLoadingTableView;

@property (nonatomic, strong) UITableView *cachingTableView;

@property (nonatomic, strong) NSMutableArray *downloadingArr;

@property (nonatomic, strong) NSMutableArray *cachingArr;

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, assign) BOOL isEdit;

@property (nonatomic, strong) NSMutableArray *currentSelectArr;

@property (nonatomic, strong) UIView *deleteView;

@property (nonatomic, strong) UIButton *selectBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) BOOL stopCell;

@end

@implementation GXLocalVideoController

- (NSMutableArray *)downloadingArr
{
    if (_downloadingArr == nil) {
        _downloadingArr = [NSMutableArray array];
    }
    return _downloadingArr;
}

- (NSMutableArray *)cachingArr
{
    if (_cachingArr == nil) {
        _cachingArr = [NSMutableArray array];
    }
    return _cachingArr;
}

- (NSMutableArray *)currentSelectArr
{
    if (_currentSelectArr == nil) {
        _currentSelectArr = [NSMutableArray array];
    }
    return _currentSelectArr;
}

- (UIView *)deleteView
{
    if (_deleteView == nil) {
        _deleteView = [[UIView alloc] init];
        _deleteView.backgroundColor = [UIColor whiteColor];
        _deleteView.frame = CGRectMake(0, GXScreenHeight - 44 - 64, GXScreenWidth, 44);
        _deleteView.hidden = YES;
        [self.view addSubview:_deleteView];
        UIButton *selectBtn = [[UIButton alloc] init];
        selectBtn.frame = CGRectMake(0, 0, GXScreenWidth * 0.5, 44);
        [selectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [selectBtn setTitle:@"取消全选" forState:UIControlStateSelected];
        [selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.selectBtn = selectBtn;
        [_deleteView addSubview:selectBtn];
        
        UIButton *deleteBtn = [[UIButton alloc] init];
        deleteBtn.frame = CGRectMake(GXScreenWidth * 0.5, 0, GXScreenWidth * 0.5, 44);
        deleteBtn.enabled = NO;
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        [_deleteView addSubview:deleteBtn];
        UIView *deviderView = [[UIView alloc] init];
        deviderView.backgroundColor = [UIColor lightGrayColor];
        deviderView.frame = CGRectMake(GXScreenWidth * 0.5, 0, 0.5, 44);
        [_deleteView addSubview:deviderView];
    }
    return _deleteView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wheatColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editDownloadVideos)];
    [self initData];
    [self setupSegmentedControl];
    [self setupScrollView];
    [self setupTableView];
    GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
    downloadTool.filePathBlock = ^(NSString *ID, NSString *path, NSString *fileName){
        [self initData];
        [self.downLoadingTableView reloadData];
        [self.cachingTableView reloadData];
    };
}

- (void)editDownloadVideos
{
    self.stopCell = NO;
    self.isEdit = !self.isEdit;
    if (self.isEdit) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
    } else {
        [self.currentSelectArr removeAllObjects];
        self.selectBtn.selected = NO;
        self.deleteBtn.enabled = NO;
        self.deleteBtn.backgroundColor = [UIColor whiteColor];
        self.deleteBtn.enabled = NO;
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.cachingArr enumerateObjectsUsingBlock:^(GXVideoInfo *videoInfo, NSUInteger idx, BOOL * _Nonnull stop) {
            videoInfo.hasSelect = NO;
        }];
        self.navigationItem.rightBarButtonItem.title = @"编辑";
    }
    self.deleteView.hidden = !self.isEdit;
    [self.cachingTableView reloadData];
}

- (void)initData
{
    [self.downloadingArr removeAllObjects];
    GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
    [self.downloadingArr addObjectsFromArray:downloadTool.downLoadingList];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"downLoadVideoArr"];
    if (dictArr && [dictArr isKindOfClass:[NSArray class]]) {
        [self.cachingArr removeAllObjects];
        NSArray *downLoadVideoArr = [GXVideoInfo objectArrayWithKeyValuesArray:dictArr];
        [self.cachingArr addObjectsFromArray:downLoadVideoArr];
    }
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(GXScreenWidth * 2, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupTableView
{
    UITableView *downLoadingTableView = [[UITableView alloc] init];
    downLoadingTableView.frame = self.scrollView.bounds;
    downLoadingTableView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 44, 0);
    downLoadingTableView.backgroundColor = [UIColor wheatColor];
    downLoadingTableView.dataSource = self;
    downLoadingTableView.delegate = self;
    downLoadingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:downLoadingTableView];
    self.downLoadingTableView = downLoadingTableView;
    UITableView *cachingTableView = [[UITableView alloc] init];
    cachingTableView.frame = self.scrollView.bounds;
    cachingTableView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 44, 0);
    cachingTableView.x = GXScreenWidth;
    cachingTableView.backgroundColor = [UIColor wheatColor];
    cachingTableView.dataSource = self;
    cachingTableView.delegate = self;
    cachingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:cachingTableView];
    self.cachingTableView = cachingTableView;
}

- (void)setupSegmentedControl
{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"正在下载", @"已经下载"]];
    segmentControl.tintColor = [UIColor wheatColor];
    segmentControl.frame = CGRectMake(0, 0, 150, 25);
    [segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentControl;
    self.segmentControl = segmentControl;
}

- (void)segmentAction:(UISegmentedControl *)segmentControl
{
    NSInteger index = segmentControl.selectedSegmentIndex;
    switch (index) {
        case 0:{
            [self toDownloadingView];
        }
            break;
        case 1:{
            [self toCachingView];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return;
    }
    if (self.scrollView.contentOffset.x == 0) {
        self.segmentControl.selectedSegmentIndex = 0;
        [self toDownloadingView];
    } else if (self.scrollView.contentOffset.x == GXScreenWidth){
        self.segmentControl.selectedSegmentIndex = 1;
        [self toCachingView];
    }
}

- (void)toDownloadingView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    }];
}

- (void)toCachingView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.scrollView setContentOffset:CGPointMake(GXScreenWidth, 0)];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.downLoadingTableView) {
        return self.downloadingArr.count;
    } else {
        return self.cachingArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXVideoDownloadCell *cell = [GXVideoDownloadCell cellWithTabelView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView == self.downLoadingTableView) {
        GXVideoInfo *videoInfo = self.downloadingArr[indexPath.row];
        cell.videoInfo = videoInfo;
    } else {
        GXVideoInfo *videoInfo = self.cachingArr[indexPath.row];
        cell.delegate = self;
        cell.videoInfo = videoInfo;
        cell.stopCell = self.stopCell;
        cell.isEdit = self.isEdit;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (tableView == self.cachingTableView) {
        if (!self.isEdit) {
            GXVideoInfo *videoInfo = self.cachingArr[indexPath.row];
            GXMoviePlayerViewController *videoPlayVc = [[GXMoviePlayerViewController alloc] init];
            NSURL *url = [NSURL fileURLWithPath:[GXService getLocalVideoPathWithName:videoInfo.videoName]];
            videoPlayVc.videoURL = url;
            videoPlayVc.title = videoInfo.title;
            videoPlayVc.videoInfo = videoInfo;
            [self.navigationController pushViewController:videoPlayVc animated:YES];
        }
    }
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return !self.isEdit;
}

//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//结束编辑
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cachingTableView) {
        GXVideoInfo *videoInfo = self.cachingArr[indexPath.row];
        [self removeLocalVideoWith:videoInfo indexPath:indexPath];
    } else {
        GXDownLoadTool *downloadTool = [GXDownLoadTool shareDownLoadTool];
        [downloadTool cancelDownLoadFile];
        [downloadTool.downLoadingList removeObjectAtIndex:indexPath.row];
        [self.downloadingArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [tableView setEditing:NO animated:YES];
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - GXVideoDownloadCellDelegate
- (void)markBtnDidClick:(UIButton *)markBtn
{
    [self.currentSelectArr removeAllObjects];
    [self.cachingArr enumerateObjectsUsingBlock:^(GXVideoInfo *videoInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        if (videoInfo.hasSelect) {
            [self.currentSelectArr addObject:videoInfo];
        } else {
            [self.currentSelectArr removeObject:videoInfo];
        }
    }];
    [self resetDeleteBtn];
}

- (void)selectBtnClick:(UIButton *)selectBtn
{
    [self.currentSelectArr removeAllObjects];
    selectBtn.selected = !selectBtn.selected;
    [self.cachingArr enumerateObjectsUsingBlock:^(GXVideoInfo *videoInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        videoInfo.hasSelect = selectBtn.selected;
        if (selectBtn.selected) {
            [self.currentSelectArr addObject:videoInfo];
        }
    }];
    self.stopCell = YES;
    [self.cachingTableView reloadData];
    [self resetDeleteBtn];
}

- (void)deleteBtnClick:(UIButton *)deleteBtn
{
    [self.currentSelectArr enumerateObjectsUsingBlock:^(GXVideoInfo *videoInfo, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = [self.cachingArr indexOfObject:videoInfo];
        [self removeLocalVideoWith:videoInfo indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    }];
    [self editDownloadVideos];
}

- (void)resetDeleteBtn
{
    if (self.currentSelectArr.count > 0) {
        self.deleteBtn.backgroundColor = [UIColor orangeColor];
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)", self.currentSelectArr.count] forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deleteBtn.enabled = YES;
        if (self.currentSelectArr.count == self.cachingArr.count) {
            self.selectBtn.selected = YES;
        } else {
            self.selectBtn.selected = NO;
        }
    } else {
        self.deleteBtn.backgroundColor = [UIColor whiteColor];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.deleteBtn.enabled = NO;
    }
}

- (void)removeLocalVideoWith:(GXVideoInfo *)videoInfo indexPath:(NSIndexPath *)indexPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:[GXService getLocalVideoPathWithName:videoInfo.videoName] error:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *downLoadArr = [NSMutableArray arrayWithArray:[defaults objectForKey:@"downLoadVideoArr"]];
    [downLoadArr removeObjectAtIndex:indexPath.row];
    [defaults setObject:downLoadArr forKey:@"downLoadVideoArr"];
    // 手动添加
    NSArray *dictArr = [defaults objectForKey:@"addVideoUrlArr"];
    NSMutableArray *dictMArr = [NSMutableArray array];
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary *addVideo, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[GXService getLocalVideoPathWithName:addVideo[@"videoName"]] isEqualToString:videoInfo.videoName]) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:addVideo];
            dictM[@"hasCaching"] = @(NO);
            [dictMArr addObject:dictM];
        } else {
            [dictMArr addObject:addVideo];
        }
    }];
    [defaults synchronize];
    [self.cachingArr removeObjectAtIndex:indexPath.row];
    [self.cachingTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end

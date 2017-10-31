//
//  GXNewsViedoListController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXNewsViedoListController.h"
#import "GXVideoTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXVideoListCell.h"
#import "GXVideoInfo.h"
#import "GXNewsVideoInfo.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "GXVideoHeaderInfo.h"
#import "GXVideoListHeaderView.h"
#import "GXDownLoadTool.h"
#import "GXLocalVideoController.h"
#import "GXMoviePlayerViewController.h"

@interface GXNewsViedoListController ()
@property (nonatomic, strong) NSMutableArray *videolist;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation GXNewsViedoListController

- (NSMutableArray *)videolist
{
    if (_videolist == nil) {
        _videolist = [NSMutableArray array];
    }
    return _videolist;
}

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
    self.view.backgroundColor = [UIColor wheatColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(localVideo)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self refreshData];
}

- (void)localVideo
{
    GXLocalVideoController *localVc = [[GXLocalVideoController alloc] init];
    localVc.title = @"视频缓存";
    [self.navigationController pushViewController:localVc animated:YES];
}

- (void)refreshData
{
    [MBProgressHUD showMessage:@"正在拼命加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"p"] = @"1";
    self.currentPage = 1;
    [GXVideoTool loadNewsVideoListWithParam:param success:^(NSDictionary *result) {
        NSArray *videoList = [GXNewsVideoInfo objectArrayWithKeyValuesArray:result[@"data"]];
        if (videoList && videoList.count > 0) {
            self.currentPage ++;
            [self.videolist removeAllObjects];
            [videoList enumerateObjectsUsingBlock:^(GXNewsVideoInfo *heroVideo, NSUInteger idx, BOOL * _Nonnull stop) {
                GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
                videoInfo.id = [heroVideo.videoList firstObject][@"vid"];
                videoInfo.title = heroVideo.title;
                videoInfo.ico = heroVideo.srcPhoto;
                videoInfo.datetime = [GXService formatDateStamp:heroVideo.time];
                videoInfo.des = heroVideo.content;
                videoInfo.viewnum = heroVideo.readCount;
                [self.videolist addObject:videoInfo];
            }];
            [self.tableView reloadData];
        }
        [self.tableView headerEndRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"加载视频数据失败，请检查网络"];
    }];
}

- (void)loadMoreData
{
    [MBProgressHUD showMessage:@"正在拼命加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"p"] = [NSString stringWithFormat:@"%ld", self.currentPage];
    [GXVideoTool loadNewsVideoListWithParam:param success:^(NSDictionary *result) {
        NSArray *videoList = [GXNewsVideoInfo objectArrayWithKeyValuesArray:result[@"data"]];
        if (videoList && videoList.count > 0) {
            self.currentPage ++;
            [videoList enumerateObjectsUsingBlock:^(GXNewsVideoInfo *heroVideo, NSUInteger idx, BOOL * _Nonnull stop) {
                GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
                videoInfo.id = [heroVideo.videoList firstObject][@"vid"];
                videoInfo.title = heroVideo.title;
                videoInfo.ico = heroVideo.srcPhoto;
                videoInfo.datetime = [GXService formatDateStamp:heroVideo.time];
                videoInfo.des = heroVideo.content;
                videoInfo.viewnum = heroVideo.readCount;
                [self.videolist addObject:videoInfo];
            }];
            [self.tableView reloadData];
        }
        [self.tableView footerEndRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"加载视频数据失败，请检查网络"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videolist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXVideoListCell *cell = [GXVideoListCell cellWithTabelView:tableView];
    
    cell.videoInfo = self.videolist[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXVideoInfo *videoInfo = self.videolist[indexPath.row];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"vid"] = videoInfo.id;
    [MBProgressHUD showMessage:@"正在拼命加载视频数据..."];
    [GXVideoTool loadHeroVideoInfoWithParam:param success:^(NSString *result) {
        [MBProgressHUD hideHUD];
        GXMoviePlayerViewController *videoPlayVc = [[GXMoviePlayerViewController alloc] init];
        videoPlayVc.videoURL = [NSURL URLWithString:result];
        videoPlayVc.title = videoInfo.title;
        videoPlayVc.videoInfo = videoInfo;
        [self.navigationController pushViewController:videoPlayVc animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载视频数据失败，请检查网络"];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

@end

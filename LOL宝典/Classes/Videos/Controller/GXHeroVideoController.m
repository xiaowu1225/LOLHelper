//
//  GXHeroVideoController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXHeroVideoController.h"
#import "GXVideoTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXVideoListCell.h"
#import "GXVideoInfo.h"
#import "GXHeroVideoList.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "GXVideoHeaderInfo.h"
#import "GXVideoListHeaderView.h"
#import "GXDownLoadTool.h"
#import "GXLocalVideoController.h"
#import "GXMoviePlayerViewController.h"

@interface GXHeroVideoController ()
@property (nonatomic, strong) NSMutableArray *videolist;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) GXVideoListHeaderView *headerView;
@end

@implementation GXHeroVideoController

- (NSMutableArray *)videolist
{
    if (_videolist == nil) {
        _videolist = [NSMutableArray array];
    }
    return _videolist;
}

- (GXVideoListHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[GXVideoListHeaderView alloc] init];
    }
    return _headerView;
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
    param[@"tag"] = _heroName;
    param[@"p"] = @"1";
    self.currentPage = 1;
    [GXVideoTool loadHeroVideoListWithParam:param success:^(NSDictionary *result) {
        NSArray *videoList = [GXHeroVideoList objectArrayWithKeyValuesArray:result[@"data"]];
        if ([result[@"category"] isKindOfClass:[NSDictionary class]] && result[@"category"]) {
            GXVideoHeaderInfo *headerInfo = [GXVideoHeaderInfo objectWithKeyValues:result[@"category"]];
            self.headerView.headerInfo = headerInfo;
            self.headerView.frame = CGRectMake(0, 0, GXScreenWidth, headerInfo.cellHeight);
            self.tableView.tableHeaderView = self.headerView;
        }
        if (videoList && videoList.count > 0) {
            self.currentPage ++;
            [self.videolist removeAllObjects];
            [videoList enumerateObjectsUsingBlock:^(GXHeroVideoList *heroVideo, NSUInteger idx, BOOL * _Nonnull stop) {
                GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
                videoInfo.id = heroVideo.vid;
                videoInfo.title = heroVideo.title;
                videoInfo.ico = heroVideo.cover_url;
                NSString *time = [NSString stringWithFormat:@"%f", [GXService deFormatDateStamp:heroVideo.upload_time]];
                videoInfo.datetime = [GXService formatDateStamp:time];
                NSString *hour = [NSString stringWithFormat:@"%02ld", heroVideo.video_length.integerValue / 3600];
                NSString *minute = [NSString stringWithFormat:@"%02ld", (heroVideo.video_length.integerValue % 3600) / 60];
                NSString *second = [NSString stringWithFormat:@"%02ld", heroVideo.video_length.integerValue % 60];
                if (heroVideo.video_length.integerValue / 3600 > 0) {
                    videoInfo.des = [NSString stringWithFormat:@"时长: %@:%@:%@", hour, minute, second];
                } else {
                    videoInfo.des = [NSString stringWithFormat:@"时长: %@:%@", minute, second];
                }
                videoInfo.viewnum = heroVideo.play_count;
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
    if ([self.heroName isEqualToString:@"topN"]) {
        [self.tableView footerEndRefreshing];
        return;
    }
    [MBProgressHUD showMessage:@"正在拼命加载中..." toView:self.view];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"tag"] = _heroName;
    param[@"p"] = [NSString stringWithFormat:@"%ld", self.currentPage];
    [GXVideoTool loadHeroVideoListWithParam:param success:^(NSDictionary *result) {
        NSArray *videoList = [GXHeroVideoList objectArrayWithKeyValuesArray:result[@"data"]];
        if (videoList && videoList.count > 0) {
            self.currentPage ++;
            [videoList enumerateObjectsUsingBlock:^(GXHeroVideoList *heroVideo, NSUInteger idx, BOOL * _Nonnull stop) {
                GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
                videoInfo.id = heroVideo.vid;
                videoInfo.title = heroVideo.title;
                videoInfo.ico = heroVideo.cover_url;
                videoInfo.datetime = heroVideo.upload_time;
                NSString *hour = [NSString stringWithFormat:@"%02ld", heroVideo.video_length.integerValue / 3600];
                NSString *minute = [NSString stringWithFormat:@"%02ld", (heroVideo.video_length.integerValue % 3600) / 60];
                NSString *second = [NSString stringWithFormat:@"%02ld", heroVideo.video_length.integerValue % 60];
                if (heroVideo.video_length.integerValue / 3600 > 0) {
                    videoInfo.des = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
                } else {
                    videoInfo.des = [NSString stringWithFormat:@"%@:%@", minute, second];
                }
                videoInfo.viewnum = heroVideo.play_count;
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

- (void)setHeroName:(NSString *)heroName
{
    _heroName = heroName;
    [self refreshData];
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
        NSURL *url = [NSURL URLWithString:result];
        GXMoviePlayerViewController *playerVc = [[GXMoviePlayerViewController alloc] init];
        playerVc.videoURL = url;
        playerVc.title = videoInfo.title;
        playerVc.videoInfo = videoInfo;
        [self.navigationController pushViewController:playerVc animated:YES];
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

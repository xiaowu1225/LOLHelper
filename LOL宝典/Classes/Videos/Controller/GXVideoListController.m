//
//  GXVideoListController.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoListController.h"
#import "GXVideoListCell.h"
#import "GXVideoTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXVideoInfo.h"
#import "GXVideoDetailInfo.h"
#import <MediaPlayer/MediaPlayer.h>
#import "GXVideoPlayController.h"
#import "MJRefresh.h"
#import "GXMoviePlayerViewController.h"

@interface GXVideoListController ()
@property (nonatomic, strong) NSArray *videolist;
@end

@implementation GXVideoListController

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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.view.backgroundColor = [UIColor wheatColor];
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
}

- (void)setID:(NSString *)ID
{
    _ID = ID;
    [self refreshData];
}

- (void)refreshData
{
    [MBProgressHUD showMessage:@"正在拼命加载视频数据..."];
    [GXVideoTool loadVideoDetailListWithId:_ID success:^(NSArray *result) {
        [MBProgressHUD hideHUD];
        [self.tableView headerEndRefreshing];
        self.videolist = result;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [self.tableView headerEndRefreshing];
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
    
    [MBProgressHUD showMessage:@"正在拼命加载视频数据..."];
    [GXVideoTool loadVideoDetailUrlWithId:videoInfo.id success:^(GXVideoDetailInfo *result) {
        [MBProgressHUD hideHUD];
//        GXVideoPlayController *videoPlayVc = [[GXVideoPlayController alloc] init];
//        videoPlayVc.URLString = result.url;
//        videoPlayVc.title = videoInfo.title;
//        videoInfo.hasCaching = YES;
//        videoPlayVc.videoInfo = videoInfo;
//        [self presentViewController:videoPlayVc animated:YES completion:nil];
        NSURL *url = [NSURL URLWithString:result.url];
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

//
//  GXVideoSearchController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXVideoSearchController.h"
#import "GXSearchBar.h"
#import "GXVideoTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXVideoListCell.h"
#import "GXVideoInfo.h"
#import "GXHeroVideoList.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "GXVideoHeaderInfo.h"
#import "GXDownLoadTool.h"
#import "GXMoviePlayerViewController.h"

@interface GXVideoSearchController ()
@property (nonatomic, strong) NSMutableArray *videolist;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) GXSearchBar *searchBar;
@property (nonatomic, weak) UIButton *cover;
@end

@implementation GXVideoSearchController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self setupSearchBar];
}

- (void)setupSearchBar
{
    UIView *herderView = [[UIView alloc] init];
    herderView.backgroundColor = [UIColor wheatColor];
    herderView.frame = CGRectMake(0, 0, GXScreenWidth, 45);
    self.tableView.tableHeaderView = herderView;
    // 添加搜索框
    GXSearchBar *searchBar = [GXSearchBar searchBar];
    searchBar.width = 220;
    searchBar.height = 35;
    searchBar.x = 10;
    searchBar.y = 5;
    [herderView addSubview:searchBar];
    searchBar.font = [UIFont systemFontOfSize:13];
    searchBar.placeholder = @"请输入视频关键字";
    self.searchBar = searchBar;
    // 添加搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.x = CGRectGetMaxX(searchBar.frame) + 10;
    searchBtn.y = searchBar.y;
    searchBtn.width = 70;
    searchBtn.height = 35;
    searchBtn.layer.cornerRadius = 5;
    searchBtn.backgroundColor = [UIColor orangeColor];
    [searchBtn addTarget:self action:@selector(searchVideo) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [herderView addSubview:searchBtn];
    // 监听通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 文字改变
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    // 显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)searchVideo
{
    if (self.searchBar.text && self.searchBar.text.length > 0) {
        [self refreshData];
    } else {
        [MBProgressHUD showError:@"搜索内容不能为空！"];
    }
}

/**
 *  文字改变
 */
- (void)textChange
{
    
}

/**
 *  键盘即将显示
 */
- (void)keyboardWillShow:(NSNotification *)notification
{
    // 添加一个朦板
    if (!self.cover) {
        UIButton *cover = [[UIButton alloc] init];
        cover.frame = CGRectMake(0, 0, GXScreenWidth, GXScreenHeight);
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cover];
        self.cover = cover;
    }
}
/**
 *  点击朦板
 */
- (void)coverClick
{
    // 删除朦板
    [self.cover removeFromSuperview];
    // 退出键盘
    [self.searchBar resignFirstResponder];
}

- (void)refreshData
{
    [MBProgressHUD showMessage:@"正在拼命加载视频数据..."];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"searchKey"] = self.searchBar.text;
    param[@"p"] = @"1";
    self.currentPage = 1;
    [GXVideoTool loadSearchVideoListWithParam:param success:^(NSArray *result) {
        NSArray *videoList = [GXHeroVideoList objectArrayWithKeyValuesArray:result];
        if (videoList && videoList.count > 0) {
            self.currentPage ++;
            [self.videolist removeAllObjects];
            [videoList enumerateObjectsUsingBlock:^(GXHeroVideoList *heroVideo, NSUInteger idx, BOOL * _Nonnull stop) {
                GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
                videoInfo.id = heroVideo.vid;
                videoInfo.title = heroVideo.title;
                videoInfo.ico = heroVideo.cover_url;
                videoInfo.datetime = heroVideo.upload_time;
                NSString *hour = [NSString stringWithFormat:@"%02ld", heroVideo.video_length.integerValue / 3600];
                NSString *minute = [NSString stringWithFormat:@"%02ld", (heroVideo.video_length.integerValue % 3600) / 60];
                NSString *second = [NSString stringWithFormat:@"%02ld", heroVideo.video_length.integerValue % 60];
                videoInfo.des = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
                videoInfo.viewnum = heroVideo.play_count;
                [self.videolist addObject:videoInfo];
            }];
            [self.tableView reloadData];
        }
        [self.tableView headerEndRefreshing];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载视频数据失败，请检查网络"];
    }];
}

- (void)loadMoreData
{
    [MBProgressHUD showMessage:@"正在拼命加载视频数据..."];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"searchKey"] = self.searchBar.text;
    param[@"p"] = [NSString stringWithFormat:@"%ld", self.currentPage];
    [GXVideoTool loadSearchVideoListWithParam:param success:^(NSArray *result) {
        NSArray *videoList = [GXHeroVideoList objectArrayWithKeyValuesArray:result];
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
                videoInfo.des = [NSString stringWithFormat:@"%@:%@:%@", hour, minute, second];
                videoInfo.viewnum = heroVideo.play_count;
                [self.videolist addObject:videoInfo];
            }];
            [self.tableView reloadData];
        }
        [self.tableView footerEndRefreshing];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
        [MBProgressHUD hideHUD];
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

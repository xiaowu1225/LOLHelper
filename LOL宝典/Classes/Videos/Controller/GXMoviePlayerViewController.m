//
//  GXMoviePlayerViewController.m
//  LOL宝典
//
//  Created by siguoxi on 2017/3/31.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "GXMoviePlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "GXDownLoadTool.h"
#import "GXVideoInfoView.h"
#import "ZFPlayer.h"
#import "Masonry.h"
#import "UINavigationController+ZFFullscreenPopGesture.h"

@interface GXMoviePlayerViewController ()<ZFPlayerDelegate, GXVideoInfoViewDelegate>
/** 播放器View的父视图*/
@property (strong, nonatomic) UIView *playerFatherView;
@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, assign) BOOL hasStart;
@end

@implementation GXMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.videoInfo.url = [self.videoURL absoluteString];
    self.zf_prefersNavigationBarHidden = YES;
    [self setupPlayerFatherView];
    [self setupDownloadView];
    // 自动播放，默认不自动播放
    [self.playerView autoPlayTheVideo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        [self.playerView pause];
    }
}

- (void)setupPlayerFatherView
{
    self.playerFatherView = [[UIView alloc] init];
    [self.view addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.leading.trailing.mas_equalTo(0);
        // 这里宽高比16：9,可自定义宽高比
        make.height.mas_equalTo(self.playerFatherView.mas_width).multipliedBy(9.0f/16.0f);
    }];
}

- (void)setupDownloadView
{
    GXVideoInfoView *downloadView = [[GXVideoInfoView alloc] init];
    downloadView.frame = CGRectMake(0, (kScreenWidth)*(9.0f/16.0f) + 20, kScreenWidth, 60);
    downloadView.videoInfo = self.videoInfo;
    downloadView.delegate = self;
    [self.view addSubview:downloadView];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
//
//- (BOOL)prefersStatusBarHidden {
//    return ZFPlayerShared.isStatusBarHidden;
//}

#pragma mark - GXVideoInfoViewDelegate
- (void)downloadBtnDidClick
{
    
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zf_playerDownload:(NSString *)url {
    if (self.hasStart) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"该文件成功添加到下载队列" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        GXDownLoadTool *downLoadTool = [GXDownLoadTool shareDownLoadTool];
        NSString * fileName = [NSString stringWithFormat:@"%@.mp4", [GXService getMd5_32Bit_String:self.videoInfo.url]];
        self.videoInfo.hasCaching = NO;
        downLoadTool.videoInfo = self.videoInfo;
        [downLoadTool downLoadFileWith:self.videoInfo.url saveForFileName:fileName];
        self.hasStart = YES;
        [downLoadTool.downLoadingList addObject:self.videoInfo];
    }
}

#pragma mark - Getter

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = self.title;
        _playerModel.videoURL         = self.videoURL;
        _playerModel.placeholderImage = [UIImage imageNamed:@"WMPlayerBackground"];
        _playerModel.fatherView       = self.playerFatherView;
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        _playerView.allowAutoRotate = NO;
        _playerView.rootViewController = self;
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}

@end

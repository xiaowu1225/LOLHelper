//
//  GXLiveListController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXLiveListController.h"
#import "GXLiveSid.h"
#import "VideoCell.h"
#import "GXLiveInfo.h"
#import "WMPlayer.h"
#import "MJRefresh.h"
#import "GXLiveTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXLiveHeaderView.h"
#import "GXHeroVideoController.h"
#import "GXLocalVideoController.h"
#import "GXNewsViedoListController.h"
#import "GXMoviePlayerViewController.h"

@interface GXLiveListController ()<UIScrollViewDelegate,WMPlayerDelegate>
{
    WMPlayer *wmPlayer;
    NSIndexPath *currentIndexPath;
    BOOL isSmallScreen;
}
@property(nonatomic,retain)VideoCell *currentCell;
@property (nonatomic, strong) NSMutableArray *videoSidList;
@property (nonatomic, strong) NSMutableArray *videoList;
@end

@implementation GXLiveListController
- (NSMutableArray *)videoSidList
{
    if (_videoSidList == nil) {
        _videoSidList = [NSMutableArray array];
    }
    return _videoSidList;
}
- (NSMutableArray *)videoList
{
    if (_videoList == nil) {
        _videoList = [NSMutableArray array];
    }
    return _videoList;
}
- (BOOL)prefersStatusBarHidden{
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                if (isSmallScreen) {
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }else{
                    [self toCell];
                }
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}
- (void)toCell{
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [wmPlayer removeFromSuperview];
    NSLog(@"row = %ld",currentIndexPath.row);
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = currentCell.backgroundIV.bounds;
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [currentCell.backgroundIV addSubview:wmPlayer];
        [currentCell.backgroundIV bringSubviewToFront:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        isSmallScreen = NO;
        wmPlayer.fullScreenBtn.selected = NO;
        
    }];
    
}

- (void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [wmPlayer removeFromSuperview];
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, kScreenHeight,kScreenWidth);
    
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(kScreenWidth-40);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo(kScreenHeight);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wmPlayer).with.offset((-kScreenHeight/2));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(5);
        
    }];
    
    [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(45);
        make.right.equalTo(wmPlayer.topView).with.offset(-45);
        make.center.equalTo(wmPlayer.topView);
        make.top.equalTo(wmPlayer.topView).with.offset(0);
    }];
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)));
        make.height.equalTo(@30);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-37, -(kScreenWidth/2-37)));
    }];
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenHeight);
        make.center.mas_equalTo(CGPointMake(kScreenWidth/2-36, -(kScreenWidth/2)+36));
        make.height.equalTo(@30);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    
    wmPlayer.fullScreenBtn.selected = YES;
    [wmPlayer bringSubviewToFront:wmPlayer.bottomView];
    
}
- (void)toSmallScreen{
    //放widow上
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake(kScreenWidth/2,kScreenHeight-kTabBarHeight-(kScreenWidth/2)*0.75, kScreenWidth/2, (kScreenWidth/2)*0.75);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        isSmallScreen = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
    
}



///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
    
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        if (isSmallScreen) {
            //放widow上,小屏显示
            [self toSmallScreen];
        }else{
            [self toCell];
        }
    }
}
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
    VideoCell *currentCell = (VideoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    if (!self.isSubView) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"热门视频" style:UIBarButtonItemStylePlain target:self action:@selector(hotVideoList)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"最新视频" style:UIBarButtonItemStylePlain target:self action:@selector(newsVideoList)];
    }
    [self setupTableView];
    UIButton *localBtn = [[UIButton alloc] init];
    localBtn.backgroundColor = [UIColor darkGrayColor];
    localBtn.alpha = 0.5;
    localBtn.layer.cornerRadius = 3;
    [localBtn setImage:[UIImage imageNamed:@"video_downloading"] forState:UIControlStateNormal];
    if (self.isSubView) {
        localBtn.frame = CGRectMake(273, GXScreenHeight - 47 - 64, 42, 42);
    } else {
        localBtn.frame = CGRectMake(273, GXScreenHeight - 47 - 49 - 64, 42, 42);
    }
    [localBtn addTarget:self action:@selector(localVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:localBtn];
    [self refreshData];
}

- (void)localVideo
{
    GXLocalVideoController *localVc = [[GXLocalVideoController alloc] init];
    localVc.title = @"视频缓存";
    [self.navigationController pushViewController:localVc animated:YES];
}

- (void)newsVideoList
{
    GXNewsViedoListController *newsVideoVc = [[GXNewsViedoListController alloc] init];
    newsVideoVc.title = @"最新视频";
    [self.navigationController pushViewController:newsVideoVc animated:YES];
}

- (void)hotVideoList
{
    GXHeroVideoController *hotVideoVc = [[GXHeroVideoController alloc] init];
    hotVideoVc.title = @"热门视频";
    hotVideoVc.heroName = @"topN";
    [self.navigationController pushViewController:hotVideoVc animated:YES];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = [UIColor wheatColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView addHeaderWithTarget:self action:@selector(refreshData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoCell" bundle:nil] forCellReuseIdentifier:@"VideoCell"];
}

- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, GXScreenWidth, 84 + 5);
    [self.videoSidList enumerateObjectsUsingBlock:^(GXLiveSid *liveSid, NSUInteger idx, BOOL * _Nonnull stop) {
        GXLiveHeaderView *liveHeader = [[GXLiveHeaderView alloc] init];
        liveHeader.frame = CGRectMake(5 + (74 + 5) * idx, 5, 74, 84);
        liveHeader.liveSid = liveSid;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerItemClick:)];
        [liveHeader addGestureRecognizer:tapRecognizer];
        [headerView addSubview:liveHeader];
    }];
    self.tableView.tableHeaderView = headerView;
}

- (void)headerItemClick:(UITapGestureRecognizer *)recognizer
{
    GXLiveHeaderView *liveHeader = (GXLiveHeaderView *)recognizer.view;
    GXLiveListController *liveListVc = [[GXLiveListController alloc] init];
    liveListVc.isSubView = YES;
    liveListVc.sid = liveHeader.liveSid.sid;
    liveListVc.title = liveHeader.liveSid.title;
    [self.navigationController pushViewController:liveListVc animated:YES];
}

// 刷新数据
- (void)refreshData
{
    if (self.sid) {
        [MBProgressHUD showMessage:@"正在拼命加载中..."];
        [GXLiveTool loadLiveDetailInfoWithSid:self.sid page:@"0-10" success:^(NSArray *result) {
            [MBProgressHUD hideHUD];
            [self.tableView headerEndRefreshing];
            [self.videoList removeAllObjects];
            [self.videoList addObjectsFromArray:result];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [self.tableView headerEndRefreshing];
            [MBProgressHUD showError:@"加载数据失败，请检查网络连接"];
        }];
    } else {
        [MBProgressHUD showMessage:@"正在拼命加载中..."];
        [GXLiveTool loadLiveHomeInfoWithPage:@"0-10" success:^(NSDictionary *result) {
            [MBProgressHUD hideHUD];
            [self.tableView headerEndRefreshing];
            [self.videoList removeAllObjects];
            [self.videoList addObjectsFromArray:result[@"videoList"]];
            [self.videoSidList removeAllObjects];
            [self.videoSidList addObjectsFromArray:result[@"videoSidList"]];
            [self.tableView reloadData];
            [self setupHeaderView];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [self.tableView headerEndRefreshing];
            [MBProgressHUD showError:@"加载数据失败，请检查网络连接"];
        }];
    }
}

// 加载更多
- (void)loadMoreData
{
    NSString *page = [NSString stringWithFormat:@"%ld-10", self.videoList.count - self.videoList.count % 10];
    if (self.sid) {
        [MBProgressHUD showMessage:@"正在拼命加载中..."];
        [GXLiveTool loadLiveDetailInfoWithSid:self.sid page:page success:^(NSArray *result) {
            [MBProgressHUD hideHUD];
            [self.tableView footerEndRefreshing];
            [self.videoList addObjectsFromArray:result];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [self.tableView footerEndRefreshing];
            [MBProgressHUD showError:@"加载数据失败，请检查网络连接"];
        }];
    } else {
        [MBProgressHUD showMessage:@"正在拼命加载中..."];
        [GXLiveTool loadLiveHomeInfoWithPage:page success:^(NSDictionary *result) {
            [MBProgressHUD hideHUD];
            [self.tableView footerEndRefreshing];
            [self.videoList addObjectsFromArray:result[@"videoList"]];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [self.tableView footerEndRefreshing];
            [MBProgressHUD showError:@"加载数据失败，请检查网络连接"];
        }];
    }
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 274;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"VideoCell";
    VideoCell *cell = (VideoCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    cell.liveInfo = self.videoList[indexPath.row];
    [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
    cell.playBtn.tag = indexPath.row;
    
    if (wmPlayer&&wmPlayer.superview) {
        if (indexPath.row==currentIndexPath.row) {
            [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
        }else{
            [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
        }
        NSArray *indexpaths = [tableView indexPathsForVisibleRows];
        if (![indexpaths containsObject:currentIndexPath]&&currentIndexPath!=nil) {//复用
            
            if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]) {
                wmPlayer.hidden = NO;
            }else{
                wmPlayer.hidden = YES;
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
        }else{
            if ([cell.backgroundIV.subviews containsObject:wmPlayer]) {
                [cell.backgroundIV addSubview:wmPlayer];
                
                [wmPlayer play];
                wmPlayer.hidden = NO;
            }
            
        }
    }
    
    
    return cell;
}
- (void)startPlayVideo:(UIButton *)sender{
    currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
        self.currentCell = (VideoCell *)sender.superview.superview;
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (VideoCell *)sender.superview.superview.subviews;
    }
    GXLiveInfo *liveInfo = self.videoList[sender.tag];
    
    //    isSmallScreen = NO;
    if (isSmallScreen) {
        [self releaseWMPlayer];
        isSmallScreen = NO;
        
    }
    if (wmPlayer) {
        [self releaseWMPlayer];
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        wmPlayer.delegate = self;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        wmPlayer.URLString = liveInfo.mp4_url;
        wmPlayer.titleLabel.text = liveInfo.title;
        //        [wmPlayer play];
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:self.currentCell.backgroundIV.bounds];
        wmPlayer.delegate = self;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        wmPlayer.titleLabel.text = liveInfo.title;
        wmPlayer.URLString = liveInfo.mp4_url;
    }
    [self.currentCell.backgroundIV addSubview:wmPlayer];
    [self.currentCell.backgroundIV bringSubviewToFront:wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.tableView reloadData];
    
}
#pragma mark scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView ==self.tableView){
        if (wmPlayer==nil) {
            return;
        }
        
        if (wmPlayer.superview) {
            CGRect rectInTableView = [self.tableView rectForRowAtIndexPath:currentIndexPath];
            CGRect rectInSuperview = [self.tableView convertRect:rectInTableView toView:[self.tableView superview]];
            if (rectInSuperview.origin.y<-self.currentCell.backgroundIV.frame.size.height||rectInSuperview.origin.y>kScreenHeight-kNavbarHeight-kTabBarHeight) {//往上拖动
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:wmPlayer]&&isSmallScreen) {
                    isSmallScreen = YES;
                }else{
                    //放widow上,小屏显示
                    [self toSmallScreen];
                }
                
            }else{
                if ([self.currentCell.backgroundIV.subviews containsObject:wmPlayer]) {
                    
                }else{
                    [self toCell];
                }
            }
        }
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GXLiveInfo *liveInfo = self.videoList[indexPath.row];
    GXMoviePlayerViewController *detailVC = [[GXMoviePlayerViewController alloc]init];
    detailVC.title = liveInfo.title;
    detailVC.videoURL = [NSURL URLWithString:liveInfo.mp4_url];
    GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
    videoInfo.title = liveInfo.title;
    videoInfo.datetime = liveInfo.ptime;
    videoInfo.des = [NSString stringWithFormat:@"%02ld:%02ld", (liveInfo.length.integerValue % 3600) / 60, liveInfo.length.integerValue % 60];
    videoInfo.ico = liveInfo.cover;
    detailVC.videoInfo = videoInfo;
    [self.navigationController pushViewController:detailVC animated:YES];
}
/**
 *  释放WMPlayer
 */
- (void)releaseWMPlayer{
    [wmPlayer.player.currentItem cancelPendingSeeks];
    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer pause];
    
    
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}
@end

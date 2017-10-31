//
//  GXAddUrlController.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/25.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXAddUrlController.h"
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
#import "GXLocalVideoController.h"
#import "GXMoviePlayerViewController.h"

@interface GXAddUrlController ()
@property (nonatomic, strong) NSMutableArray *videolist;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, weak) GXSearchBar *searchBar;
@property (nonatomic, weak) UIButton *cover;
@end

@implementation GXAddUrlController

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
    self.title = @"添加视频";
    self.view.backgroundColor = [UIColor wheatColor];
    [self setupSearchBar];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(localVideo)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"addVideoUrlArr"];
    if (dictArr && [dictArr isKindOfClass:[NSArray class]]) {
        [self.videolist removeAllObjects];
        [self.videolist addObjectsFromArray:[GXVideoInfo objectArrayWithKeyValuesArray:dictArr]];
    }
    [self.tableView reloadData];
}

- (void)localVideo
{
    GXLocalVideoController *localVc = [[GXLocalVideoController alloc] init];
    localVc.title = @"视频缓存";
    [self.navigationController pushViewController:localVc animated:YES];
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
    searchBar.placeholder = @"请输入视频地址";
    self.searchBar = searchBar;
    // 添加搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.x = CGRectGetMaxX(searchBar.frame) + 10;
    searchBtn.y = searchBar.y;
    searchBtn.width = 70;
    searchBtn.height = 35;
    searchBtn.layer.cornerRadius = 5;
    searchBtn.backgroundColor = [UIColor orangeColor];
    [searchBtn addTarget:self action:@selector(addVideo) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"添加" forState:UIControlStateNormal];
    [herderView addSubview:searchBtn];
    // 监听通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 文字改变
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    // 显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)addVideo
{
    if (self.searchBar.text && self.searchBar.text.length > 0) {
        [self addVideoUrl];
    } else {
        [MBProgressHUD showError:@"添加内容不能为空！"];
    }
}

/**
 *  添加视频地址
 */
- (void)addVideoUrl
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"addVideoUrlArr"];
    NSMutableArray *dictMArr = [NSMutableArray arrayWithArray:dictArr];
    __block BOOL hasContent = NO;
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary *addVideo, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([addVideo[@"url"] isEqualToString:self.searchBar.text]) {
            [MBProgressHUD showError:@"该视频已添加！"];
            hasContent = YES;
            *stop = YES;
        }
    }];
    if (hasContent) {
        return;
    }
    GXVideoInfo *videoInfo = [[GXVideoInfo alloc] init];
    videoInfo.url = self.searchBar.text;
    videoInfo.des = @"手动添加";
    videoInfo.hasCaching = NO;
    videoInfo.videoName = [[self.searchBar.text componentsSeparatedByString:@"/"] lastObject];
    videoInfo.title = videoInfo.videoName;
    [dictMArr addObject:[videoInfo keyValues]];
    [defaults setObject:dictMArr forKey:@"addVideoUrlArr"];
    [defaults synchronize];
    [self.videolist addObject:videoInfo];
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videolist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifer = @"addVideoUrl";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    GXVideoInfo *videoInfo = self.videolist[indexPath.row];
    cell.textLabel.text = videoInfo.videoName;
    cell.textLabel.userInteractionEnabled = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GXVideoInfo *videoInfo = self.videolist[indexPath.row];
    GXMoviePlayerViewController *videoPlayVc = [[GXMoviePlayerViewController alloc] init];
    if (videoInfo.hasCaching) {
        NSString *videoName = [GXService getMd5_32Bit_String:videoInfo.url];
        NSURL *url = [NSURL fileURLWithPath:[GXService getLocalVideoPathWithName:[videoName stringByAppendingString:@".mp4"]]];
        videoPlayVc.videoURL = url;
    } else {
        videoPlayVc.videoURL = [NSURL URLWithString:videoInfo.url];
    }
    videoPlayVc.title = videoInfo.videoName;
    videoPlayVc.videoInfo = videoInfo;
    [self.navigationController pushViewController:videoPlayVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *dictArr = [defaults objectForKey:@"addVideoUrlArr"];
    NSMutableArray *dictMArr = [NSMutableArray arrayWithArray:dictArr];
    [dictMArr removeObjectAtIndex:indexPath.row];
    [defaults setObject:dictMArr forKey:@"addVideoUrlArr"];
    [defaults synchronize];
    [self.videolist removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView setEditing:NO animated:YES];
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end

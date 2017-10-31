//
//  GXHDVideoController.m
//  LOL宝典
//
//  Created by siguoxi on 16/6/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXHDVideoController.h"
#import "GXHDVideoCell.h"
#import "MBProgressHUD+MJ.h"
#import "GXVideoTool.h"
#import "GXVideoList.h"
#import "GXVideoListController.h"
#import "GXVideoHeaderView.h"
#import "GXPlainFlowLayout.h"
#import "GXHeroVideoController.h"
#import "MJRefresh.h"

@interface GXHDVideoController ()
@property (nonatomic, strong) NSArray *videoLists;
@end

@implementation GXHDVideoController

#define GXVideoIdentifer @"HDVideo"
#define GXVideoHeaderIdentifer @"HDVideoHeader"

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor wheatColor];
    [self refreshVideoData];
    [self.collectionView addHeaderWithTarget:self action:@selector(refreshVideoData)];
    [self.collectionView registerClass:[GXHDVideoCell class] forCellWithReuseIdentifier:GXVideoIdentifer];
    [self.collectionView registerClass:[GXVideoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GXVideoHeaderIdentifer];
}

- (void)refreshVideoData
{
    [MBProgressHUD showMessage:@"正在拼命加载中..." toView:self.view];
    [GXVideoTool loadHomeVideoListSuccess:^(NSArray *result) {
        self.videoLists = result;
        [self.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.collectionView headerEndRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.collectionView headerEndRefreshing];
        [MBProgressHUD showError:@"加载视频数据失败，请检查网络"];
    }];
    
}

- (id)init
{
    // 1.创建一个布局对象
    GXPlainFlowLayout *flow = [[GXPlainFlowLayout alloc] init];
    
    // 2.设置布局对象的属性
    flow.itemSize = CGSizeMake(74, 84);
    
    // 水平方向间距为0
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    // 垂直方向上间距为10
    flow.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    
    // 3.在初始化的时候传入自己创建的布局对象
    return [super initWithCollectionViewLayout:flow];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.videoLists.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    GXVideoList *videoItem = self.videoLists[section];
    return videoItem.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GXHDVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXVideoIdentifer forIndexPath:indexPath];
    
    GXVideoList *videoItem = self.videoLists[indexPath.section];
    GXVideoTitle *videoTitle = videoItem.children[indexPath.item];
    cell.videoTitle = videoTitle;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    GXVideoList *videoItem = self.videoLists[indexPath.section];
    GXVideoHeaderView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GXVideoHeaderIdentifer forIndexPath:indexPath];
    sectionView.labelText = videoItem.name;
    sectionView.backgroundColor = [UIColor whiteColor];
    return sectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(320, 25);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXVideoListController *videoListVc = [[GXVideoListController alloc] init];
    GXVideoList *videoItem = self.videoLists[indexPath.section];
    GXVideoTitle *videoTitle = videoItem.children[indexPath.item];
    videoListVc.ID = videoTitle.id;
    videoListVc.title = videoTitle.name;
    [self.navigationController pushViewController:videoListVc animated:YES];
}

@end

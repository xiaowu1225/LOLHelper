//
//  GXWuqiListController.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXWuqiListController.h"
#import "GXHeroStoryTool.h"
#import "GXHeroStoryCell.h"
#import "GXWuqiStoryController.h"
#import "GXWuqi.h"

#define GXHeroWuqiIdentifer @"wuqi"

@interface GXWuqiListController ()

@property (nonatomic, strong) NSMutableArray *wuqiList;
@end

@implementation GXWuqiListController

- (NSMutableArray *)wuqiList
{
    if (_wuqiList == nil) {
        _wuqiList = [GXHeroStoryTool wuqiList];
    }
    return _wuqiList;
}

- (id)init
{
    // 1.创建一个布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    // 2.设置布局对象的属性
    flow.itemSize = CGSizeMake(74, 84);
    
    // 水平方向间距为0
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    
    // 垂直方向上间距为10
    flow.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    // 3.在初始化的时候传入自己创建的布局对象
    return [super initWithCollectionViewLayout:flow];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor wheatColor];
    
    [self.collectionView registerClass:[GXHeroStoryCell class] forCellWithReuseIdentifier:GXHeroWuqiIdentifer];
    self.collectionView.backgroundColor = [UIColor wheatColor];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.wuqiList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓存池中获取cell
    GXHeroStoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXHeroWuqiIdentifer forIndexPath:indexPath];
    
    // 2. 设置cell的数据
    cell.wuqi = self.wuqiList[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXWuqi *wuqi = self.wuqiList[indexPath.item];
    GXWuqiStoryController *wuqiVc = [[GXWuqiStoryController alloc] init];
    wuqiVc.wuqi = wuqi;
    wuqiVc.title = wuqi.name;
    [self.navigationController pushViewController:wuqiVc animated:YES];
}

@end

//
//  GXCityListController.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCityListController.h"
#import "GXHeroStoryTool.h"
#import "GXCitiy.h"
#import "GXCityStoryController.h"
#import "GXCityCell.h"

#define GXCityIndetifer @"CityIdentifer"

@interface GXCityListController ()
@property (nonatomic, strong) NSMutableArray *cities;
@end

@implementation GXCityListController

- (NSMutableArray *)cities
{
    if (_cities == nil) {
        _cities = [GXHeroStoryTool cityList];
    }
    return _cities;
}

- (id)init
{
    // 1.创建一个布局对象
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    
    // 2.设置布局对象的属性
    flow.itemSize = CGSizeMake(90, 100);
    
    // 水平方向间距为0
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    
    // 垂直方向上间距为10
    flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    // 3.在初始化的时候传入自己创建的布局对象
    return [super initWithCollectionViewLayout:flow];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor wheatColor];
    
    self.collectionView.backgroundColor = [UIColor wheatColor];
    self.collectionView.frame = self.view.bounds;
    self.collectionView.y = 20;
    
    [self.collectionView registerClass:[GXCityCell class] forCellWithReuseIdentifier:GXCityIndetifer];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓存池中获取cell
    GXCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXCityIndetifer forIndexPath:indexPath];
    
    // 2. 设置cell的数据
    cell.city = self.cities[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXCitiy *city = self.cities[indexPath.row];
    GXCityStoryController *cityVc = [[GXCityStoryController alloc] init];
    cityVc.city = city;
    cityVc.title = city.cityname;
    [self.navigationController pushViewController:cityVc animated:YES];
}

@end

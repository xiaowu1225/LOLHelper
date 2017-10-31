//
//  GXSkillsController.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillsController.h"
#import "GXSkillsTool.h"
#import "MBProgressHUD+MJ.h"
#import "GXSkillsCell.h"
#import "GXSkillsInfo.h"
#import "GXSkillDetailController.h"

#define GXSkillsIdentifer @"skills"

@interface GXSkillsController ()
@property (nonatomic, strong) NSArray *skillsList;
@end

@implementation GXSkillsController

- (NSArray *)skillsList
{
    if (_skillsList == nil) {
        _skillsList = [NSMutableArray array];
    }
    return _skillsList;
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
    self.collectionView.backgroundColor = [UIColor wheatColor];
    
    [self loadSkillsList];
    
    [self.collectionView registerClass:[GXSkillsCell class] forCellWithReuseIdentifier:GXSkillsIdentifer];
}

- (void)loadSkillsList
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXSkillsTool loadSkillsInfoSuccess:^(NSArray *result) {
        [MBProgressHUD hideHUD];
        self.skillsList = result;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
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
    flow.sectionInset = UIEdgeInsetsMake(10, 5, 5, 5);
    
    // 3.在初始化的时候传入自己创建的布局对象
    return [super initWithCollectionViewLayout:flow];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.skillsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓存池中获取cell
    GXSkillsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXSkillsIdentifer forIndexPath:indexPath];
    
    // 2. 设置cell的数据
    cell.skills = self.skillsList[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXSkillsInfo *skill = self.skillsList[indexPath.item];
    GXSkillDetailController *skillVc = [[GXSkillDetailController alloc] init];
    skillVc.title = @"召唤师技能";
    skillVc.skillsInfo = skill;
    [self.navigationController pushViewController:skillVc animated:YES];
}


@end

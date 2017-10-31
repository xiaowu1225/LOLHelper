//
//  GXEquipmentController.m
//  LOL宝典
//
//  Created by sgx on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXEquipmentController.h"
#import "GXEquitmentTool.h"
#import "GXEquipmentTitle.h"
#import "MBProgressHUD+MJ.h"
#import "GXTitleButton.h"
#import "GXEquipmentInfo.h"
#import "GXEquipmentCell.h"
#import "GXEquitmentInfoController.h"

#define GXEquipmentIdentifer @"equipment"

@interface GXEquipmentController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) GXTitleButton *titleButton;
@property (nonatomic, weak) UIButton *cover;
@property (nonatomic, strong) NSArray *equipmentList;
@property (nonatomic, strong) NSMutableArray *equipmentDeatilList;
@end

@implementation GXEquipmentController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSMutableArray *)equipmentDeatilList
{
    if (_equipmentDeatilList == nil) {
        _equipmentDeatilList = [NSMutableArray array];
    }
    return _equipmentDeatilList;
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
    flow.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    
    // 3.在初始化的时候传入自己创建的布局对象
    return [super initWithCollectionViewLayout:flow];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    [self loadEquipmentList];
    
    // 创建遮盖
    UIButton *cover = [[UIButton alloc] init];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.2;
    cover.hidden = YES;
    cover.frame = self.view.bounds;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cover];
    self.cover = cover;
    
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(20, 0, 280, 300);
    tableView.hidden = YES;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self setupCenterTitle];
    
    [self.collectionView registerClass:[GXEquipmentCell class] forCellWithReuseIdentifier:GXEquipmentIdentifer];
}

- (void)setupCenterTitle
{
    // 设置导航栏中间的标题按钮
    GXTitleButton *titleButton = [[GXTitleButton alloc] init];
    [titleButton setTitleColor:[UIColor wheatColor] forState:UIControlStateNormal];
    self.titleButton = titleButton;
    
    // 设置尺寸
    titleButton.height = 35;
    // 设置文字
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    // 设置图标
    [titleButton setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    // 设置背景图片
    [titleButton setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    // 监听按钮点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

/**
 *  点击标题按钮
 */
- (void)titleClick:(GXTitleButton *)titlebutton
{
    self.tableView.hidden = !self.tableView.hidden;
    self.cover.hidden = !self.cover.hidden;
    [self.tableView reloadData];
    titlebutton.imageView.transform = CGAffineTransformRotate(titlebutton.imageView.transform, M_PI);
}

- (void)coverClick
{
    [self titleClick:self.titleButton];
}

- (void)loadEquipmentList
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXEquitmentTool loadEquipmentListSuccess:^(NSArray *result) {
        [MBProgressHUD hideHUD];
        self.equipmentList = result;
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.equipmentList.count - 1 inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:index];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
}

/**
 *  加载装备详细列表
 */
- (void)loadEquitmentDetailListWithTag:(NSString *)tag
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXEquitmentTool loadEquipmentDetailListWithTag:tag success:^(NSArray *result) {
        [MBProgressHUD hideHUD];
        [self.equipmentDeatilList removeAllObjects];
        for (GXEquipmentInfo *equipment in result) {
            [self.equipmentDeatilList addObject:equipment];
        };
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败，请检查网络"];
    }];
}

#pragma mark - UItableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.equipmentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.backgroundColor = [UIColor skyBlueColor];
    GXEquipmentTitle *title = self.equipmentList[indexPath.row];
    cell.textLabel.text = title.text;
    
    return cell;
}


#pragma mark - UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXEquipmentTitle *title = self.equipmentList[indexPath.row];
    [self.titleButton setTitle:title.text forState:UIControlStateNormal];
    self.tableView.hidden = YES;
    self.cover.hidden = YES;
    [self loadEquitmentDetailListWithTag:title.tag];
    [self.collectionView reloadData];
    self.titleButton.imageView.transform = CGAffineTransformIdentity;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.equipmentDeatilList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓存池中获取cell
    GXEquipmentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXEquipmentIdentifer forIndexPath:indexPath];
    
    // 2. 设置cell的数据
    cell.equipmentInfo = self.equipmentDeatilList[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXEquipmentInfo *equitment = self.equipmentDeatilList[indexPath.item];
    GXEquitmentInfoController *equipmentVc = [[GXEquitmentInfoController alloc] init];
    equipmentVc.equipmentInfo = equitment;
    [self.navigationController pushViewController:equipmentVc animated:YES];
}

@end

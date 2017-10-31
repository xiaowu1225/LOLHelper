//
//  GXHeroController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroController.h"
#import "GXHeroTool.h"
#import "GXUser.h"
#import "GXHeroCell.h"
#import "MBProgressHUD+MJ.h"
#import "GXHeroIntroductionController.h"
#import "GXHero.h"
#import "GXSearchBar.h"
#import "UIBarButtonItem+Extension.h"
#import "GXAppDelegate.h"
#import "GXLocalVideoController.h"

#define GXHeroIdentifer @"hero"

@interface GXHeroController ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *heroListInfos;
@property (nonatomic, weak) GXSearchBar *searchBar;
@property (nonatomic, weak) UIButton *cover;
@end

@implementation GXHeroController

- (NSArray *)heroListInfos
{
    if (_heroListInfos == nil) {
        _heroListInfos = [NSArray array];
    }
    return _heroListInfos;
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
    [self setupNavBar];
    [self setupCollectionView];
    [self loadHerosListInfo];
}

// 设置collectionView
- (void)setupCollectionView
{
    self.view.backgroundColor = [UIColor wheatColor];
    self.collectionView.backgroundColor = [UIColor wheatColor];
    self.collectionView.delegate = self;
    self.collectionView.frame = CGRectMake(0, 44, GXScreenWidth, GXScreenHeight - 60);
    [self.collectionView registerClass:[GXHeroCell class] forCellWithReuseIdentifier:GXHeroIdentifer];
}

// 设置导航栏
- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"免费英雄" style:UIBarButtonItemStylePlain target:self action:@selector(getFreeHeroList)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全部英雄" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
    
    // 添加搜索框
    GXSearchBar *searchBar = [GXSearchBar searchBar];
    searchBar.width = 220;
    searchBar.height = 35;
    searchBar.x = 10;
    searchBar.y = 5;
    [self.view addSubview:searchBar];
    searchBar.font = [UIFont systemFontOfSize:13];
    searchBar.placeholder = @"搜索：Ashe，艾希 或者 寒冰射手";
    self.searchBar = searchBar;
    
    // 添加搜索按钮
    UIButton *searchBtn = [[UIButton alloc] init];
    searchBtn.x = CGRectGetMaxX(searchBar.frame) + 10;
    searchBtn.y = searchBar.y;
    searchBtn.width = 70;
    searchBtn.height = 35;
    searchBtn.layer.cornerRadius = 5;
    searchBtn.backgroundColor = [UIColor orangeColor];
    [searchBtn addTarget:self action:@selector(searchHero) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    
    // 监听通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 文字改变
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    // 显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

/**
 *  加载免费英雄列表
 */
- (void)getFreeHeroList
{
    [MBProgressHUD showMessage:@"正在拼命加载中..." toView:self.view];
    [GXHeroTool loadFreeHerosListSuccess:^(NSArray *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.heroListInfos = result;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"加载数据失败，请检查网络连接"];
    }];
}

/**
 *  文字改变
 */
- (void)textChange
{
    self.heroListInfos = [GXHeroTool queryWithCondition:self.searchBar.text];
    [self.collectionView reloadData];
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


- (void)refresh
{
    [self loadHerosListInfo];
}

/**
 *  搜索英雄
 */
- (void)searchHero
{
    [self.searchBar resignFirstResponder];
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


- (void)loadHerosListInfo
{
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    GXUser *user = [[GXUser alloc] init];
    user.serverName = [defaults objectForKey:GXServerName];
    user.playerName = [defaults objectForKey:GXPlayerName];

    [MBProgressHUD showMessage:@"正在拼命加载中..." toView:self.view];
    [GXHeroTool loadHerosListWithUser:user success:^(NSArray *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.heroListInfos = result;
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"加载数据失败，请检查网络连接"];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.heroListInfos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓存池中获取cell
    GXHeroCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXHeroIdentifer forIndexPath:indexPath];
    
    // 2. 设置cell的数据
    cell.hero = self.heroListInfos[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXHero *hero = self.heroListInfos[indexPath.item];
    GXHeroIntroductionController *instroVc = [[GXHeroIntroductionController alloc] init];
    instroVc.champtionName = hero.name;
    instroVc.title = hero.title;
    [self.navigationController pushViewController:instroVc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

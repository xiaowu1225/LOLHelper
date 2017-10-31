//
//  GXStoryController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXStoryController.h"
#import "GXHeroStoryTool.h"
#import "GXHeroStoryCell.h"
#import "GXHeroInfoController.h"
#import "GXVideoController.h"
#import "UIBarButtonItem+Extension.h"
#import "GXCityListController.h"
#import "GXWuqiListController.h"
#import "GXPopMenu.h"
#import "GXPeople.h"
#import "GXSearchBar.h"

#define GXHeroStroyIdentifer @"story"

@interface GXStoryController ()<GXPopMenuDelegate>

@property (nonatomic, strong) NSMutableArray *lolpeople;

@property (nonatomic, strong) NSMutableArray *currentPeople;

@property (nonatomic, weak) GXPopMenu *popmenu;

@property (nonatomic, weak) GXSearchBar *searchBar;

@property (nonatomic, weak) UIButton *cover;

@property (nonatomic, weak) UIButton *selectType;

@end

@implementation GXStoryController

- (NSMutableArray *)currentPeople
{
    if (_currentPeople == nil) {
        _currentPeople = [NSMutableArray array];
    }
    return _currentPeople;
}

- (NSMutableArray *)lolpeople
{
    if (_lolpeople == nil) {
        _lolpeople = [GXHeroStoryTool lolPeople];
    }
    return _lolpeople;
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
    
    [self.collectionView registerClass:[GXHeroStoryCell class] forCellWithReuseIdentifier:GXHeroStroyIdentifer];
    self.collectionView.backgroundColor = [UIColor wheatColor];
    self.collectionView.delegate = self;
    self.collectionView.frame = CGRectMake(0, 90, GXScreenWidth, GXScreenHeight - 50 - 49);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_nav_more" highlightedImaheName:@"icon_nav_more_highlighted" target:self action:@selector(more)];
    
    // 添加上面选择按钮
    [self setupSelectBtn];
    
    // 设置搜索框
    GXSearchBar *searchBar = [GXSearchBar searchBar];
    searchBar.width = 250;
    searchBar.height = 30;
    searchBar.placeholder = @"搜索：黑暗之女，安妮，火女 或 小萝莉";
    searchBar.font = [UIFont systemFontOfSize:13];
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 文字改变
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    // 显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
/**
 *  文字改变
 */
- (void)textChange
{
    self.currentPeople = [GXHeroStoryTool queryWithCondition:self.searchBar.text];
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


- (void)more
{
    UIView *containerView = [[UIView alloc] init];
    containerView.frame = CGRectMake(0, 0, 250, 150);
    
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.backgroundColor = [UIColor orangeColor];
    titleBtn.frame = CGRectMake(0, 0, 250, 50);
    [titleBtn setImage:[UIImage imageNamed:@"city"] forState:UIControlStateNormal];
    titleBtn.contentMode = UIViewContentModeScaleAspectFit;
    [titleBtn setTitle:@"More" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -70, -10, 0);
    [containerView addSubview:titleBtn];
    
    UIButton *cityBtn = [[UIButton alloc] init];
    [cityBtn setTitle:@"城邦故事" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    cityBtn.backgroundColor = [UIColor redColor];
    cityBtn.frame = CGRectMake(0, 50, 250, 50);
    [cityBtn addTarget:self action:@selector(cityInfo) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:cityBtn];
    
    UIButton *wuqiBtn = [[UIButton alloc] init];
    [wuqiBtn setTitle:@"武器故事" forState:UIControlStateNormal];
    [wuqiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wuqiBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    wuqiBtn.backgroundColor = [UIColor purpleColor];
    wuqiBtn.frame = CGRectMake(0, 100, 250, 50);
    [wuqiBtn addTarget:self action:@selector(wuqiInfo) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:wuqiBtn];
    
    GXPopMenu *menu = [[GXPopMenu alloc] initWithContentView:containerView];
    CGFloat menuW = 260;
    CGFloat menuH = 170;
    CGFloat menuY = 55;
    CGFloat menuX = (self.view.width - menuW) * 0.5;
    [menu showInRect:CGRectMake(menuX, menuY, menuW, menuH)];
    self.popmenu = menu;
    menu.arrowPosition = GXPopMenuArrowPositionRight;
    menu.dimBackground = YES;
}
- (void)cityInfo
{
    [self.popmenu dismiss];
    GXCityListController *cityListVc = [[GXCityListController alloc] init];
    cityListVc.title = @"城邦故事";
    [self.navigationController pushViewController:cityListVc animated:YES];
}

- (void)wuqiInfo
{
    [self.popmenu dismiss];
    GXWuqiListController *wuqiList = [[GXWuqiListController alloc] init];
    wuqiList.title = @"武器故事";
    [self.navigationController pushViewController:wuqiList animated:YES];
}
/**
 *  添加上面选择按钮
 */
- (void)setupSelectBtn
{
    UIView *container = [[UIView alloc] init];
    container.frame = CGRectMake(2, 2, GXScreenWidth - 4, 80);
    container.backgroundColor = [UIColor grassColor];
    container.layer.cornerRadius = 5;
    [self.view addSubview:container];
    CGFloat margin = 10;
    int count = 10;
    int columns = 5;
    for (int i = 0; i < count; i ++) {
        
        UIButton *button = [[UIButton alloc] init];
        [container addSubview:button];
        int row = i / columns;
        int col = i % columns;
        CGFloat w = (GXScreenWidth - margin * (columns + 1)) / columns;
        CGFloat h = w * 44 / 94.0;
        CGFloat x = margin + (margin + w) * col;
        CGFloat Y = margin + (margin + h) * row;
        button.frame = CGRectMake(x, Y, w, h);
        button.tag = i;
        [button addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        [self selectType:button];
    }
}

- (void)selectType:(UIButton *)button
{
    self.selectType.selected = NO;
    button.selected = YES;
    self.selectType = button;
    switch (button.tag) {
        case GXHeroTypeAll:
            [button setImage:[UIImage imageNamed:@"type_all"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_all1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                [self.currentPeople addObject:people];
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeJinZhan:
            [button setImage:[UIImage imageNamed:@"type_jinzhan"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_jinzhan1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isJinZhan == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeYuanCheng:
            [button setImage:[UIImage imageNamed:@"type_yuancheng"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_yuancheng1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isYuanCheng == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeWuLi:
            [button setImage:[UIImage imageNamed:@"type_wuli"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_wuli1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isWuLi == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeFaShu:
            [button setImage:[UIImage imageNamed:@"type_fashu"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_fashu1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isFaShu == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeTank:
            [button setImage:[UIImage imageNamed:@"type_tank"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_tank1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isTank == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeFuZhu:
                              [button setImage:[UIImage imageNamed:@"type_fuzhu"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_fuzhu1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isFuZhu == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeDaYe:
                              [button setImage:[UIImage imageNamed:@"type_daye"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_daye1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isDaYe == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeQianXing:
                              [button setImage:[UIImage imageNamed:@"type_qianxing"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_qianxing1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isQianXing == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        case GXHeroTypeHot:
                              [button setImage:[UIImage imageNamed:@"type_hot"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"type_hot1"] forState:UIControlStateSelected];
            [self.currentPeople removeAllObjects];
            for (GXPeople *people in self.lolpeople) {
                if (people.isHot == 1) {
                    [self.currentPeople addObject:people];
                }
            }
            [self.collectionView reloadData];
            break;
            
        default:
            break;
    }
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
    flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);

    // 3.在初始化的时候传入自己创建的布局对象
    return [super initWithCollectionViewLayout:flow];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentPeople.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓存池中获取cell
    GXHeroStoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GXHeroStroyIdentifer forIndexPath:indexPath];
    
    // 2. 设置cell的数据
    cell.people = self.currentPeople[indexPath.item];
    
    // 3.返回cell
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXPeople *people = self.currentPeople[indexPath.item];
    GXHeroInfoController *heroInfoVc = [[GXHeroInfoController alloc] init];
    heroInfoVc.people = people;
    heroInfoVc.title = @"英雄属性";
    [self.navigationController pushViewController:heroInfoVc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

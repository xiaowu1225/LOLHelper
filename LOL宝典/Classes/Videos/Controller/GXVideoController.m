//
//  GXVideoController.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoController.h"
#import "GXCategoryVideoController.h"
#import "GXHDVideoController.h"
#import "GXLocalVideoController.h"
#import "GXVideoSearchController.h"
#import "GXLocalVideoController.h"

@interface GXVideoController ()
@property (nonatomic, strong) GXHDVideoController *categoryVc;
@property (nonatomic, strong) GXCategoryVideoController *HDVc;
@end

@implementation GXVideoController

- (GXHDVideoController *)categoryVc
{
    if (_categoryVc == nil) {
        _categoryVc = [[GXHDVideoController alloc] init];
    }
    return _categoryVc;
}

- (GXCategoryVideoController *)HDVc
{
    if (_HDVc == nil) {
        _HDVc = [[GXCategoryVideoController alloc] init];
    }
    return _HDVc;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor wheatColor];
    [self addChildViewController:self.HDVc];
    [self addChildViewController:self.categoryVc];
    [self.view addSubview:self.categoryVc.view];
    [self.view addSubview:self.HDVc.view];
    [self setupSegmentedControl];
    // 设置导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchVideo)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(localVideo)];
}

- (void)searchVideo
{
    GXVideoSearchController *searchVc = [[GXVideoSearchController alloc] init];
    searchVc.title = @"视频搜索";
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)localVideo
{
    GXLocalVideoController *localVc = [[GXLocalVideoController alloc] init];
    localVc.title = @"视频缓存";
    [self.navigationController pushViewController:localVc animated:YES];
}

- (void)setupSegmentedControl
{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"高清视频", @"分类导航"]];
    segmentControl.tintColor = [UIColor wheatColor];
    segmentControl.frame = CGRectMake(0, 0, 150, 25);
    [segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentControl;
}

- (void)segmentAction:(UISegmentedControl *)segmentControl
{
    NSInteger index = segmentControl.selectedSegmentIndex;
    switch (index) {
        case 0:{
            //切换child view controller
            [self transitionFromViewController:self.categoryVc toViewController:self.HDVc duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            }  completion:^(BOOL finished) {
                //......
            }];
        }
            break;
        case 1:{
            //切换child view controller
            [self transitionFromViewController:self.HDVc toViewController:self.categoryVc duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            }  completion:^(BOOL finished) {
                //......
            }];
        }
            break;
        default:
            break;
    }
}

@end

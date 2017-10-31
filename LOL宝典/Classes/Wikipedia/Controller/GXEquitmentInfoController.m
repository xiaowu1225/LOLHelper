//
//  GXEquitmentInfoController.m
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXEquitmentInfoController.h"
#import "GXEquipmentDetailView.h"
#import "GXEquitmentTool.h"
#import "GXEquipmentInfo.h"
#import "MBProgressHUD+MJ.h"
#import "GXEquipmentDetailView.h"
#import "GXEquipmentDetailInfo.h"

@interface GXEquitmentInfoController ()<GXEquipmentDetailViewDelegate>
@property (nonatomic, strong) GXEquipmentDetailView *detailView;
@end

@implementation GXEquitmentInfoController

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
    self.title = @"装备详情";
    GXEquipmentDetailView *detailView = [[GXEquipmentDetailView alloc] init];
    detailView.frame = self.view.bounds;
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    [self loadEquipmentDetailInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadEquipmentDetailInfo
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXEquitmentTool loadEquipmentDetailInfoWithID:self.equipmentInfo.id success:^(GXEquipmentDetailInfo *result) {
        [MBProgressHUD hideHUD];
        self.detailView.detailInfo = result;
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败，请检查网络"];
    }];
}

- (void)equipmentDidClick:(NSString *)ID
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
    [GXEquitmentTool loadEquipmentDetailInfoWithID:ID success:^(GXEquipmentDetailInfo *result) {
        [MBProgressHUD hideHUD];
        [self.detailView removeFromSuperview];
        GXEquipmentDetailView *detailView = [[GXEquipmentDetailView alloc] init];
        detailView.frame = self.view.bounds;
        detailView.delegate = self;
        [self.view addSubview:detailView];
        detailView.detailInfo = result;
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showMessage:@"加载失败，请检查网络"];
    }];
}

@end

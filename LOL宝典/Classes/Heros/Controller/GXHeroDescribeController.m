//
//  GXHeroDescribeController.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroDescribeController.h"
#import "GXGift.h"
#import "GXGiftViewController.h"

@interface GXHeroDescribeController ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *describeView;
@end

@implementation GXHeroDescribeController

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
    self.title = @"天赋与符文";
    
    // 设置标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.text = self.gift.title;
    titleLabel.numberOfLines = 0;
    CGSize titleSize = [titleLabel.text sizeWithFont:titleLabel.font maxSize:CGSizeMake(GXScreenWidth, MAXFLOAT)];
    titleLabel.frame = CGRectMake(0, 20, titleSize.width, titleSize.height);
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 设置具体描述
    [self setupDescribe];
}

- (void)setupDescribe
{
    UIButton *describeView = [[UIButton alloc] init];
    [describeView setImage:[UIImage resizedImage:@"hero_info_bg"] forState:UIControlStateNormal] ;
    [describeView addTarget:self action:@selector(describeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:describeView];
    self.describeView = describeView;
    
    UILabel *describeLabel = [[UILabel alloc] init];
    describeLabel.text = self.gift.des;
    describeLabel.numberOfLines = 0;
    describeLabel.font = [UIFont systemFontOfSize:15];
    CGSize describeSize = [describeLabel.text sizeWithFont:describeLabel.font maxSize:CGSizeMake(GXScreenWidth, MAXFLOAT)];
    describeLabel.frame = CGRectMake(0, 0, describeSize.width, describeSize.height);
    [self.describeView addSubview:describeLabel];
    self.describeView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 20, GXScreenWidth, describeSize.height);
}

- (void)describeClick
{
    GXGiftViewController *giftVc = [[GXGiftViewController alloc] init];
    giftVc.gift = self.gift;
    [self.navigationController pushViewController:giftVc animated:YES];
}

@end

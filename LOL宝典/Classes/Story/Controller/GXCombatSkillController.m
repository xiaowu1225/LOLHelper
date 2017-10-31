//
//  GXCombatSkillController.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCombatSkillController.h"
#import "NSString+Extension.h"
#import "GXPeople.h"

#define GXMargin 10

@interface GXCombatSkillController ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UILabel *selfuseLabel;
@property (nonatomic, weak) UILabel *otheruseLabel;
@end

@implementation GXCombatSkillController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor wheatColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加使用技巧
    [self setupSelfuse];
    
    // 添加对付技巧
    [self setupOtheruse];
}

- (void)setupSelfuse
{
    UILabel *selfTitle = [[UILabel alloc] init];
    selfTitle.backgroundColor = [UIColor orangeColor];
    selfTitle.text = [NSString stringWithFormat:@"当使用%@时", self.people.nickname];
    selfTitle.frame = CGRectMake(0, 0, GXScreenWidth, 35);
    selfTitle.font = [UIFont boldSystemFontOfSize:15];
    [self.scrollView addSubview:selfTitle];
    
    UILabel *selfuseLabel = [[UILabel alloc] init];
    selfuseLabel.numberOfLines = 0;
    selfuseLabel.font = [UIFont systemFontOfSize:15];
    selfuseLabel.text = self.people.selfuse;
    [self.scrollView addSubview:selfuseLabel];
    self.selfuseLabel = selfuseLabel;
    
    CGFloat selfX = GXMargin;
    CGFloat selfY = CGRectGetMaxY(selfTitle.frame) + GXMargin;
    CGSize selfSize = [self.selfuseLabel.text sizeWithFont:self.selfuseLabel.font maxSize:CGSizeMake(GXScreenWidth - 2 * GXMargin, MAXFLOAT)];
    self.selfuseLabel.frame = CGRectMake(selfX, selfY, selfSize.width, selfSize.height);
}

- (void)setupOtheruse
{
    UILabel *otherTitle = [[UILabel alloc] init];
    otherTitle.backgroundColor = [UIColor orangeColor];
    otherTitle.text = [NSString stringWithFormat:@"敌人使用%@时", self.people.nickname];
    otherTitle.frame = CGRectMake(0, CGRectGetMaxY(self.selfuseLabel.frame), GXScreenWidth, 35);
    otherTitle.font = [UIFont boldSystemFontOfSize:15];
    [self.scrollView addSubview:otherTitle];
    
    UILabel *otheruseLabel = [[UILabel alloc] init];
    otheruseLabel.numberOfLines = 0;
    otheruseLabel.font = [UIFont systemFontOfSize:15];
    otheruseLabel.text = self.people.otheruse;
    [self.scrollView addSubview:otheruseLabel];
    self.otheruseLabel = otheruseLabel;
    
    CGFloat otherX = GXMargin;
    CGFloat otherY = CGRectGetMaxY(otherTitle.frame) + GXMargin;
    CGSize otherSize = [self.otheruseLabel.text sizeWithFont:self.otheruseLabel.font maxSize:CGSizeMake(GXScreenWidth - 2 * GXMargin, MAXFLOAT)];
    self.otheruseLabel.frame = CGRectMake(otherX, otherY, otherSize.width, otherSize.height);
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.otheruseLabel.frame) + 10);
}

@end

//
//  GXHeroInfoController.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroInfoController.h"
#import "GXPeople.h"
#import "UIImageView+WebCache.h"
#import "GXHeroStoryController.h"
#import "GXCombatSkillController.h"

@interface GXHeroInfoController ()
@property (nonatomic, weak) UIImageView *headView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UILabel *extenLabel;
@property (weak, nonatomic) UILabel *campLabel;

@end

@implementation GXHeroInfoController

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
    
    // 1.添加头部图片
    [self setupHeadView];
    
    // 添加英雄属性标签
    [self setupNature];
    
    // 添加按钮
    [self setupButton];
}

- (void)setupHeadView
{
    UIImageView *headView = [[UIImageView alloc] init];
    headView.frame = CGRectMake(0, 0, 320, 150);
    headView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:headView];
    self.headView = headView;
    [self.headView sd_setImageWithURL:[NSURL URLWithString:self.people.imagepath] placeholderImage:[UIImage imageNamed:@"welcome.jpg"]];
}
/**
 *  设置英雄属性
 */
- (void)setupNature
{
    CGFloat margin = 10;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.headView.frame) + margin, 150, 44);
    titleLabel.text = self.people.nickname;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.frame = CGRectMake(margin + 150, CGRectGetMaxY(self.headView.frame) + margin, 150, 44);
    nameLabel.text = self.people.name;
    [self.view addSubview:nameLabel];
    self.nameLabel = nameLabel;

    UILabel *extenLabel = [[UILabel alloc] init];
    extenLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame) + margin * 2, 300, 44);
    extenLabel.textAlignment = NSTextAlignmentCenter;
    extenLabel.text = [NSString stringWithFormat:@"外号: %@", self.people.waihao];
    [self.view addSubview:extenLabel];
    self.extenLabel = extenLabel;

    UILabel *campLabel = [[UILabel alloc] init];
    campLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.extenLabel.frame) + margin * 2, 300, 44);
    campLabel.textAlignment = NSTextAlignmentCenter;
    campLabel.text = [NSString stringWithFormat:@"阵营: %@", self.people.zhenying];
    [self.view addSubview:campLabel];
    self.campLabel = campLabel;
}

- (void)setupButton
{
    UIButton *storyBtn = [[UIButton alloc] init];
    storyBtn.layer.cornerRadius = 5;
    storyBtn.backgroundColor = [UIColor orangeColor];
    storyBtn.frame = CGRectMake(30, GXScreenHeight - 120, 100, 35);
    [storyBtn addTarget:self action:@selector(story) forControlEvents:UIControlEventTouchUpInside];
    [storyBtn setTitle:@"背景故事" forState:UIControlStateNormal];
    [storyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:storyBtn];

    UIButton *skillsBtn = [[UIButton alloc] init];
    skillsBtn.layer.cornerRadius = 5;
    skillsBtn.backgroundColor = [UIColor orangeColor];
    skillsBtn.frame = CGRectMake(190, GXScreenHeight - 120, 100, 35);
    [skillsBtn addTarget:self action:@selector(skills) forControlEvents:UIControlEventTouchUpInside];
    [skillsBtn setTitle:@"战斗技巧" forState:UIControlStateNormal];
    [skillsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:skillsBtn];
}

- (void)story
{
    GXHeroStoryController *storyVc = [[GXHeroStoryController alloc] init];
    storyVc.story = self.people.story;
    storyVc.title = self.people.name;
    [self.navigationController pushViewController:storyVc animated:YES];
}

- (void)skills
{
    GXCombatSkillController *skillVc = [[GXCombatSkillController alloc] init];
    skillVc.people = self.people;
    [self.navigationController pushViewController:skillVc animated:YES];
}


@end

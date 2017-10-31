//
//  GXSkillsCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillsCell.h"
#import "GXSkillsInfo.h"
#import "UIImageView+WebCache.h"

@interface GXSkillsCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLable;

@end

@implementation GXSkillsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 添加英雄图标
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 8;
        iconView.clipsToBounds = YES;
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 添加英雄称号
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.font = [UIFont systemFontOfSize:10];
        titleLable.textColor = [UIColor blueColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        self.titleLable = titleLable;
    }
    return self;
}

- (void)setSkills:(GXSkillsInfo *)skills
{
    _skills = skills;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_skills.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLable.text = _skills.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = 5;
    CGFloat iconY = 0;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.iconView.frame);
    CGFloat titleW = iconW + 10;
    CGFloat titleH = 20;
    self.titleLable.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end

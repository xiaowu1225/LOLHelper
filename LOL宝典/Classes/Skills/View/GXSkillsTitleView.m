//
//  GXSkillsTitleView.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillsTitleView.h"
#import "UIImageView+WebCache.h"
#import "GXEquipmentDetailInfo.h"
#import "GXSkillsInfo.h"

@interface GXSkillsTitleView ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *levelLabel;

@property (nonatomic, weak) UILabel *coldLabel;

@end

@implementation GXSkillsTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 8;
        iconView.clipsToBounds = YES;
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 需要等级
        UILabel *levelLabel = [[UILabel alloc] init];
        levelLabel.font = [UIFont systemFontOfSize:13];
        levelLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:levelLabel];
        self.levelLabel = levelLabel;
        
        // 冷却时间
        UILabel *coldLabel = [[UILabel alloc] init];
        coldLabel.font = [UIFont systemFontOfSize:13];
        coldLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:coldLabel];
        self.coldLabel = coldLabel;
        
        
        self.backgroundColor = [UIColor wheatColor];
    }
    return self;
}

- (void)setSkills:(GXSkillsInfo *)skills
{
    _skills = skills;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_skills.icon] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    CGFloat margin = 5;
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.nameLabel.text = _skills.name;
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat nameY = iconY + margin;
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    self.levelLabel.text = [NSString stringWithFormat:@"需要等级:%@",_skills.level];
    CGFloat levelX = nameX;
    CGFloat levelY = CGRectGetMaxY(self.nameLabel.frame);
    CGSize levelSize = [self.levelLabel.text sizeWithFont:self.levelLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.levelLabel.frame = CGRectMake(levelX, levelY, levelSize.width, levelSize.height);
    
    self.coldLabel.text = [NSString stringWithFormat:@"冷却时间:%@",_skills.cooldown];
    CGFloat coldX = nameX;
    CGFloat coldY = CGRectGetMaxY(self.levelLabel.frame);
    CGSize coldSize = [self.coldLabel.text sizeWithFont:self.coldLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.coldLabel.frame = CGRectMake(coldX, coldY, coldSize.width, coldSize.height);
    
    self.width = GXScreenWidth;
    self.height = CGRectGetMaxY(self.iconView.frame) + margin;
}


@end

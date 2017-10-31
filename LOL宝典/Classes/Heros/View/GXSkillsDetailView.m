//
//  GXSkillsDetailView.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXSkillsDetailView.h"
#import "UIImageView+WebCache.h"
#import "GXSkills.h"

@interface GXSkillsDetailView ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *describeLabel;

@property (nonatomic, weak) UIImageView *describeView;

@end

@implementation GXSkillsDetailView

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
        
        UILabel *describeLabel = [[UILabel alloc] init];
        describeLabel.textColor = [UIColor darkGrayColor];
        describeLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:describeLabel];
        self.describeLabel = describeLabel;
        
        UIImageView *describeView = [[UIImageView alloc] init];
        describeView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:describeView];
        self.describeView = describeView;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSkillsInfo:(GXSkills *)skillsInfo
{
    _skillsInfo = skillsInfo;
   
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_skillsInfo.icon] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    CGFloat margin = 5;
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.nameLabel.text = _skillsInfo.name;
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat nameY = iconY + margin;
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    self.describeLabel.text = @"技能介绍";
    self.describeLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.iconView.frame) + margin, GXScreenWidth, 30);
    
    UILabel *describe = [[UILabel alloc] init];
    describe.text = [NSString stringWithFormat:@"%@(%@)\n消耗: %@\n冷却: %@\n范围: %@\n效果: %@\n描述: %@", _skillsInfo.name, _skillsInfo.enName, _skillsInfo.cost, _skillsInfo.cooldown, _skillsInfo.range, _skillsInfo.effect, _skillsInfo.descStr];
    describe.numberOfLines = 0;
    describe.font = [UIFont systemFontOfSize:13];
    CGSize describeSize = [describe.text sizeWithFont:describe.font maxSize:CGSizeMake(GXScreenWidth - 2 * margin, MAXFLOAT)];
    describe.frame = CGRectMake(margin, margin, describeSize.width, describeSize.height);
    [self.describeView addSubview:describe];
    self.describeView.frame = CGRectMake(0, CGRectGetMaxY(self.describeLabel.frame), GXScreenWidth, describeSize.height + 2 * margin);
}

@end

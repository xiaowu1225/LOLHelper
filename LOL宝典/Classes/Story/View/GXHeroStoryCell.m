//
//  GXHeroStoryCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroStoryCell.h"
#import "GXPeople.h"
#import "GXWuqi.h"

@interface GXHeroStoryCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLable;

@property (nonatomic, weak) UIView *cover;

@end

@implementation GXHeroStoryCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 添加选中背景
        UIView *cover = [[UIView alloc] initWithFrame:self.frame];
        cover.backgroundColor = [UIColor orangeColor];
        cover.layer.cornerRadius = 5;
        self.selectedBackgroundView = cover;
        self.cover = cover;
        
        // 添加英雄图标
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 添加英雄称号
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.font = [UIFont systemFontOfSize:10];
        titleLable.textColor = [UIColor blueColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self.cover addSubview:titleLable];
        self.titleLable = titleLable;
    }
    return self;
}

- (void)setPeople:(GXPeople *)people
{
    _people = people;
    
    self.iconView.image = [UIImage imageNamed:_people.icon];
    self.titleLable.text = _people.name;
}

- (void)setWuqi:(GXWuqi *)wuqi
{
    _wuqi = wuqi;
    
    self.iconView.image = [UIImage imageNamed:_wuqi.icon];
    self.titleLable.text = _wuqi.name;
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
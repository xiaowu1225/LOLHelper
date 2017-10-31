//
//  GXHeroCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroCell.h"
#import "UIImageView+WebCache.h"
#import "GXHero.h"

@interface GXHeroCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLable;

@end

@implementation GXHeroCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 添加英雄图标
        UIImageView *iconView = [[UIImageView alloc] init];
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

- (void)setHero:(GXHero *)hero
{
    _hero = hero;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_hero.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLable.text = _hero.title;
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

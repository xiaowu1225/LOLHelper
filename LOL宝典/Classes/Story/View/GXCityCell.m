//
//  GXCityCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCityCell.h"
#import "GXCitiy.h"

@interface GXCityCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLable;

@property (nonatomic, weak) UIView *cover;

@end

@implementation GXCityCell

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
        iconView.layer.cornerRadius = 8;
        iconView.clipsToBounds = YES;
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 添加英雄称号
        UILabel *titleLable = [[UILabel alloc] init];
        titleLable.font = [UIFont systemFontOfSize:13];
        titleLable.textColor = [UIColor blueColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLable];
        self.titleLable = titleLable;
    }
    return self;
}

- (void)setCity:(GXCitiy *)city
{
    _city = city;
    
    NSString *img = [NSString stringWithFormat:@"%@.jpg", _city.cityname];
    self.iconView.image = [UIImage imageNamed:img];
    self.titleLable.text = _city.cityname;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat iconW = 80;
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

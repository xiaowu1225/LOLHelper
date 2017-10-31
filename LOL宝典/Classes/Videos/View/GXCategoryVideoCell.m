//
//  GXCategoryVideoCell.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXCategoryVideoCell.h"
#import "UIImageView+WebCache.h"

@interface GXCategoryVideoCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLable;

@property (nonatomic, weak) UILabel *countLable;

@end

@implementation GXCategoryVideoCell

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
        
        // 更新数量
        UILabel *countLable = [[UILabel alloc] init];
        countLable.font = [UIFont systemFontOfSize:10];
        countLable.textColor = [UIColor whiteColor];
        countLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        countLable.textAlignment = NSTextAlignmentCenter;
        [iconView addSubview:countLable];
        self.countLable = countLable;
    }
    return self;
}

- (void)setVideoGroup:(GXCategoryVideoInfo *)videoGroup
{
    _videoGroup = videoGroup;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_videoGroup.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLable.text = _videoGroup.name;
    NSString *dailyUpdate = [NSString stringWithFormat:@"%ld", _videoGroup.dailyUpdate.integerValue];
    self.countLable.text = [NSString stringWithFormat:@"最新%@个", dailyUpdate];
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:self.countLable.text];
    [countString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[self.countLable.text rangeOfString:(dailyUpdate)]];
    self.countLable.attributedText = countString;
    self.countLable.hidden = !(_videoGroup.dailyUpdate.integerValue > 0);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = 5;
    CGFloat iconY = 5;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconView.layer.cornerRadius = 6;
    self.iconView.clipsToBounds = YES;
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.iconView.frame);
    CGFloat titleW = iconW + 10;
    CGFloat titleH = 20;
    self.titleLable.frame = CGRectMake(titleX, titleY, titleW, titleH);
    CGFloat countX = 0;
    CGFloat countH = 16;
    CGFloat countY = iconH - countH;
    CGFloat countW = iconW;
    self.countLable.frame = CGRectMake(countX, countY, countW, countH);
}

@end

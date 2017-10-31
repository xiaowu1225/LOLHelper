//
//  GXHDVideoCell.m
//  LOL宝典
//
//  Created by siguoxi on 16/6/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXHDVideoCell.h"
#import "UIImageView+WebCache.h"

@interface GXHDVideoCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLable;

@end

@implementation GXHDVideoCell

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

- (void)setVideoTitle:(GXVideoTitle *)videoTitle
{
    _videoTitle = videoTitle;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_videoTitle.ico] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.titleLable.text = _videoTitle.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = 5;
    CGFloat iconY = 5;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    self.iconView.layer.cornerRadius = iconW * 0.5;
    self.iconView.clipsToBounds = YES;
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.iconView.frame);
    CGFloat titleW = iconW + 10;
    CGFloat titleH = 20;
    self.titleLable.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end

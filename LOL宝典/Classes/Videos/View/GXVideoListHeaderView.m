//
//  GXVideoListHeaderView.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXVideoListHeaderView.h"
#import "GXVideoHeaderInfo.h"
#import "UIImageView+WebCache.h"

@interface GXVideoListHeaderView ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *midLabel;
@property (nonatomic, weak) UILabel *BottomLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UIView *deviderView;
@end

@implementation GXVideoListHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.font = [UIFont systemFontOfSize:13];
        topLabel.textColor = [UIColor blackColor];
        [self addSubview:topLabel];
        self.topLabel = topLabel;
        
        UILabel *midLabel = [[UILabel alloc] init];
        midLabel.font = [UIFont systemFontOfSize:9];
        midLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:midLabel];
        self.midLabel = midLabel;
        
        UILabel *BottomLabel = [[UILabel alloc] init];
        BottomLabel.font = [UIFont systemFontOfSize:9];
        BottomLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:BottomLabel];
        self.BottomLabel = BottomLabel;
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:11];
        descLabel.textColor = [UIColor darkGrayColor];
        descLabel.numberOfLines = 0;
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
        UIView *deviderView = [[UIView alloc] init];
        deviderView.backgroundColor = [UIColor wheatColor];
        [self addSubview:deviderView];
        self.deviderView = deviderView;
    }
    return self;
}

- (void)setHeaderInfo:(GXVideoHeaderInfo *)headerInfo
{
    _headerInfo = headerInfo;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_headerInfo.icon] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    CGFloat margin = 5;
    CGFloat iconX = margin * 2;
    CGFloat iconY = margin;
    CGFloat iconW = 60;
    CGFloat iconH = iconW;
    self.iconView.layer.cornerRadius = 5;
    self.iconView.clipsToBounds = YES;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.topLabel.text = _headerInfo.name;
    CGFloat labelX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat labelWidth = 236;
    CGFloat labelHeight = 20;
    self.topLabel.frame = CGRectMake(labelX, margin * 2, labelWidth, labelHeight);
    self.midLabel.text = [NSString stringWithFormat:@"播放: %@", _headerInfo.playCount];
    self.midLabel.frame = CGRectMake(labelX, CGRectGetMaxY(self.topLabel.frame), labelWidth, 16);
    self.BottomLabel.text = [NSString stringWithFormat:@"视频: %ld", _headerInfo.videoCount.integerValue];
    self.BottomLabel.frame = CGRectMake(labelX, CGRectGetMaxY(self.midLabel.frame), labelWidth, 16);
    self.descLabel.text = _headerInfo.des;
    CGSize labelSize = [self.descLabel.text sizeWithFont:self.descLabel.font maxSize:CGSizeMake(300, MAXFLOAT)];
    self.descLabel.frame = CGRectMake(margin * 2, CGRectGetMaxY(self.iconView.frame) + margin, 300, labelSize.height);
    self.deviderView.frame = CGRectMake(0, CGRectGetMaxY(self.descLabel.frame) + margin, GXScreenWidth, 10);
    _headerInfo.cellHeight = CGRectGetMaxY(self.deviderView.frame);
}

@end

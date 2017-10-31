//
//  GXCharmCell.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXCharmCell.h"
#import "GXCharmShowInfo.h"
#import "UIImageView+WebCache.h"

@interface GXCharmCell ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *midLabel;
@property (nonatomic, weak) UILabel *BottomLabel;
@property (nonatomic, weak) UIView *deviderLine;
@end

@implementation GXCharmCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *topLabel = [[UILabel alloc] init];
        topLabel.font = [UIFont systemFontOfSize:13];
        topLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:topLabel];
        self.topLabel = topLabel;
        
        UILabel *midLabel = [[UILabel alloc] init];
        midLabel.font = [UIFont systemFontOfSize:13];
        midLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:midLabel];
        self.midLabel = midLabel;
        
        UILabel *BottomLabel = [[UILabel alloc] init];
        BottomLabel.font = [UIFont systemFontOfSize:13];
        BottomLabel.textColor = [UIColor darkGrayColor];
        BottomLabel.numberOfLines = 0;
        [self addSubview:BottomLabel];
        self.BottomLabel = BottomLabel;
        
        UIView *deviderLine = [[UIView alloc] init];
        deviderLine.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:deviderLine];
        self.deviderLine = deviderLine;
    }
    return self;
}

- (void)setCharmshowInfo:(GXCharmShowInfo *)charmshowInfo
{
    _charmshowInfo = charmshowInfo;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_charmshowInfo.imagePath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    CGFloat margin = 5;
    CGFloat iconX = margin;
    CGFloat iconY = margin * 2;
    CGFloat iconW = 60;
    CGFloat iconH = iconW;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.topLabel.text = _charmshowInfo.topDesc;
    CGFloat labelX = CGRectGetMaxX(self.iconView.frame) + margin * 2;
    CGFloat labelWidth = 240;
    CGFloat labelHeight = 20;
    self.topLabel.frame = CGRectMake(labelX, margin * 2, labelWidth, labelHeight);
    self.midLabel.text = _charmshowInfo.midDesc;
    self.midLabel.frame = CGRectMake(labelX, CGRectGetMaxY(self.topLabel.frame), labelWidth, labelHeight);
    self.BottomLabel.text = _charmshowInfo.bottomDesc;
    CGSize labelSize = [self.BottomLabel.text sizeWithFont:self.BottomLabel.font maxSize:CGSizeMake(labelWidth, MAXFLOAT)];
    self.BottomLabel.frame = CGRectMake(labelX, CGRectGetMaxY(self.midLabel.frame), labelWidth, labelSize.height);
    _charmshowInfo.cellHeight = CGRectGetMaxY(self.BottomLabel.frame) + margin * 2;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"GXCharmCell";
    GXCharmCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[GXCharmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.deviderLine.frame = CGRectMake(0, self.height - 0.5, self.width, 0.5);
}

@end

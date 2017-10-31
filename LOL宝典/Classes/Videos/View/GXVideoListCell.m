//
//  GXVideoListCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoListCell.h"
#import "GXVideoInfo.h"
#import "UIImageView+WebCache.h"

@interface GXVideoListCell ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *detailLabel;

@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UILabel *viewLabel;

@end

@implementation GXVideoListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加图片
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.textColor = [UIColor darkGrayColor];
        detailLabel.numberOfLines = 0;
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *viewLabel = [[UILabel alloc] init];
        viewLabel.font = [UIFont systemFontOfSize:13];
        viewLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:viewLabel];
        self.viewLabel = viewLabel;
        
    }
    return self;
}

- (void)setVideoInfo:(GXVideoInfo *)videoInfo
{
    _videoInfo = videoInfo;
    
    CGFloat margin = 10;
    CGFloat labelWidth = GXScreenWidth - 115;
    CGFloat iconW = 100;
    CGFloat iconH = 80;
    CGFloat iconX = 5;
    CGFloat iconY = margin;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_videoInfo.ico] placeholderImage:[UIImage imageNamed:@"WMPlayerBackground"]];
    
    self.titleLabel.text = _videoInfo.title;
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + 5;
    CGFloat titleY = iconY;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(labelWidth, MAXFLOAT)];
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    self.detailLabel.text = _videoInfo.des;
    CGFloat detailX = titleX;
    CGFloat detailY = CGRectGetMaxY(self.titleLabel.frame);
    CGFloat detailW = labelWidth;
    CGFloat detailH = CGRectGetMaxY(self.iconView.frame) - CGRectGetMaxY(self.titleLabel.frame);
    self.detailLabel.frame = CGRectMake(detailX, detailY, detailW, detailH);
    
    self.timeLabel.text = [NSString stringWithFormat:@"更新时间:%@", _videoInfo.datetime];
    CGFloat timeX = iconX;
    CGFloat timeY = CGRectGetMaxY(self.iconView.frame) + margin;
    CGSize timeSize = [self.timeLabel.text sizeWithFont:self.timeLabel.font maxSize:CGSizeMake(GXScreenWidth - 115, MAXFLOAT)];
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    self.viewLabel.text = [NSString stringWithFormat:@"观看 : %@", _videoInfo.viewnum];
    CGFloat viewY = timeY;
    CGSize viewSize = [self.viewLabel.text sizeWithFont:self.viewLabel.font maxSize:CGSizeMake(GXScreenWidth - 115, MAXFLOAT)];
    CGFloat viewX = GXScreenWidth - 5 - viewSize.width;
    self.viewLabel.frame = CGRectMake(viewX, viewY, viewSize.width, viewSize.height);
    
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    static NSString *identifer = @"cell";
    GXVideoListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[GXVideoListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

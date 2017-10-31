//
//  GXCurrentBattleCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCurrentBattleCell.h"
#import "GXShakeHeroInfo.h"
#import "UIImageView+WebCache.h"
#import "GXUser.h"

@interface GXCurrentBattleCell ()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *totalLabel;
@property (nonatomic, weak) UILabel *winLabel;
@property (nonatomic, weak) UILabel *tierLabel;
@end

@implementation GXCurrentBattleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *totalLabel = [[UILabel alloc] init];
        totalLabel.font = [UIFont systemFontOfSize:13];
        totalLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:totalLabel];
        self.totalLabel = totalLabel;
        
        UILabel *winLabel = [[UILabel alloc] init];
        winLabel.font = [UIFont systemFontOfSize:13];
        winLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:winLabel];
        self.winLabel = winLabel;
        
        UILabel *tierLabel = [[UILabel alloc] init];
        tierLabel.font = [UIFont systemFontOfSize:15];
        tierLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:tierLabel];
        self.tierLabel = tierLabel;
    }
    return self;
}

- (void)setHeroInfo:(GXShakeHeroInfo *)heroInfo
{
    _heroInfo = heroInfo;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_heroInfo.img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    CGFloat margin = 10;
    CGFloat padding = 5;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 50;
    CGFloat iconH = iconW;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.nameLabel.text = _heroInfo.name;
    // 读取用户缓存信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // 读取用户上次输入的账号信息
    NSString *playerName = [defaults objectForKey:GXPlayerName];
    if ([[_heroInfo.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] isEqualToString:playerName]) {
        self.nameLabel.textColor = [UIColor redColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
    }
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + padding;
    CGFloat nameY = iconY;
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    if (_heroInfo.total) {
        self.totalLabel.text = [NSString stringWithFormat:@"总场次 %@", _heroInfo.total];
    } else {
        self.totalLabel.text = @"总场次 0";
    }
    CGFloat totalX = nameX;
    CGFloat totalY = CGRectGetMaxY(self.nameLabel.frame) + margin + padding;
    CGSize totalSize = [self.totalLabel.text sizeWithFont:self.totalLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.totalLabel.frame = CGRectMake(totalX, totalY, totalSize.width, totalSize.height);
    
    if (_heroInfo.winRate) {
        self.winLabel.text = [NSString stringWithFormat:@"胜率 %@%%", _heroInfo.winRate];
    } else {
        self.winLabel.text = @"胜率 0%";
    }
    
    CGFloat winX = CGRectGetMaxX(self.totalLabel.frame) + margin;
    CGFloat winY = totalY;
    CGSize winSize = [self.winLabel.text sizeWithFont:self.winLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.winLabel.frame = CGRectMake(winX, winY, winSize.width, winSize.height);
    
    self.tierLabel.text = _heroInfo.tierDesc;
    CGFloat tierY = nameY;
    CGSize tierSize = [self.tierLabel.text sizeWithFont:self.tierLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat tierX = self.width - margin - tierSize.width;
    self.tierLabel.frame = CGRectMake(tierX, tierY, tierSize.width, tierSize.height);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"current";
    GXCurrentBattleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[GXCurrentBattleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

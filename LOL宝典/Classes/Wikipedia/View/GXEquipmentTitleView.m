//
//  GXEquipmentTitleView.m
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXEquipmentTitleView.h"
#import "UIImageView+WebCache.h"
#import "GXEquipmentDetailInfo.h"

@interface GXEquipmentTitleView ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UILabel *composeLabel;

@property (nonatomic, weak) UILabel *totalLabel;

@property (nonatomic, weak) UILabel *sellLabel;
@end

@implementation GXEquipmentTitleView

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
        
        // 合成价格
        UILabel *composeLabel = [[UILabel alloc] init];
        composeLabel.font = [UIFont systemFontOfSize:13];
        composeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:composeLabel];
        self.composeLabel = composeLabel;
        
        // 总价格
        UILabel *totalLabel = [[UILabel alloc] init];
        totalLabel.font = [UIFont systemFontOfSize:13];
        totalLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:totalLabel];
        self.totalLabel = totalLabel;
        
        // 出售价格
        UILabel *sellLabel = [[UILabel alloc] init];
        sellLabel.font = [UIFont systemFontOfSize:13];
        sellLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:sellLabel];
        self.sellLabel = sellLabel;
        
        self.backgroundColor = [UIColor wheatColor];
    }
    return self;
}

- (void)setDetailInfo:(GXEquipmentDetailInfo *)detailInfo
{
    _detailInfo = detailInfo;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_detailInfo.icon] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    CGFloat margin = 5;
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.nameLabel.text = _detailInfo.name;
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat nameY = iconY + margin;
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    self.composeLabel.text = [NSString stringWithFormat:@"价格:%@",_detailInfo.price];
    CGFloat composeX = nameX;
    CGFloat composeY = CGRectGetMaxY(self.nameLabel.frame) + 2 * margin;
    CGSize composeSize = [self.composeLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.composeLabel.frame = CGRectMake(composeX, composeY, composeSize.width, composeSize.height);
    
    self.totalLabel.text = [NSString stringWithFormat:@"总价:%@",_detailInfo.allPrice];
    CGFloat totalX = CGRectGetMaxX(self.composeLabel.frame);
    CGFloat totalY = composeY;
    CGSize totalSize = [self.totalLabel.text sizeWithFont:self.totalLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.totalLabel.frame = CGRectMake(totalX, totalY, totalSize.width, totalSize.height);
    
    self.sellLabel.text = [NSString stringWithFormat:@"售价:%@",_detailInfo.sellPrice];
    CGFloat sellX = CGRectGetMaxX(self.totalLabel.frame) + margin;
    CGFloat sellY = composeY;
    CGSize sellSize = [self.sellLabel.text sizeWithFont:self.sellLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sellLabel.frame = CGRectMake(sellX, sellY, sellSize.width, sellSize.height);
    
    self.width = GXScreenWidth;
    self.height = CGRectGetMaxY(self.iconView.frame) + margin;
}


@end

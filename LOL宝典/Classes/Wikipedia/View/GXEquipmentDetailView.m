//
//  GXEquipmentDetailView.m
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXEquipmentDetailView.h"
#import "GXEquipmentTitleView.h"
#import "GXEquipmentDetailInfo.h"
#import "UIImageView+WebCache.h"
#import "GXImageView.h"

#define GXCount 6

@interface GXEquipmentDetailView ()

@property (nonatomic, weak) GXEquipmentTitleView *titleView;

@property (nonatomic, weak) UILabel *attributeLabel;

@property (nonatomic, weak) UIImageView *describeView;

@property (nonatomic, weak) UILabel *needLabel;

@property (nonatomic, weak) UIImageView *needView;

@property (nonatomic, weak) UILabel *composeLabel;

@property (nonatomic, weak) UIImageView *composeView;

@end

@implementation GXEquipmentDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        GXEquipmentTitleView *titleView = [[GXEquipmentTitleView alloc] init];
        [self addSubview:titleView];
        self.titleView = titleView;
        
        UILabel *attributeLabel = [[UILabel alloc] init];
        attributeLabel.textColor = [UIColor darkGrayColor];
        attributeLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:attributeLabel];
        self.attributeLabel = attributeLabel;
        
        UILabel *needLabel = [[UILabel alloc] init];
        needLabel.textColor = [UIColor darkGrayColor];
        needLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:needLabel];
        self.needLabel = needLabel;
        
        UILabel *composeLabel = [[UILabel alloc] init];
        composeLabel.textColor = [UIColor darkGrayColor];
        composeLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:composeLabel];
        self.composeLabel = composeLabel;
        
        UIImageView *describeView = [[UIImageView alloc] init];
        describeView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:describeView];
        self.describeView = describeView;
        
        UIImageView *needView = [[UIImageView alloc] init];
        needView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:needView];
        self.needView = needView;
        
        UIImageView *composeView = [[UIImageView alloc] init];
        composeView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:composeView];
        self.composeView = composeView;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setDetailInfo:(GXEquipmentDetailInfo *)detailInfo
{
    _detailInfo = detailInfo;
    CGFloat margin = 5;
    CGFloat padding = 2;
    
    self.titleView.detailInfo = _detailInfo;
    
    self.attributeLabel.text = @"物品属性";
    self.attributeLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.titleView.frame), GXScreenWidth, 30);
    
    UILabel *describeLabel = [[UILabel alloc] init];
    describeLabel.text = _detailInfo.descStr;
    describeLabel.numberOfLines = 0;
    describeLabel.font = [UIFont systemFontOfSize:13];
    CGSize describeSize = [describeLabel.text sizeWithFont:describeLabel.font maxSize:CGSizeMake(GXScreenWidth - 2 * margin, MAXFLOAT)];
    describeLabel.frame = CGRectMake(margin, margin, describeSize.width, describeSize.height);
    [self.describeView addSubview:describeLabel];
    self.describeView.frame = CGRectMake(0, CGRectGetMaxY(self.attributeLabel.frame), GXScreenWidth, describeSize.height + 2 * margin);
    
    self.needLabel.text = @"合成需求";
    self.needLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.describeView.frame), GXScreenWidth, 30);
    
    CGFloat needW = 50;
    CGFloat needH = needW;
    self.needView.image = [UIImage resizedImage:@"hero_info_bg"];
    self.needView.userInteractionEnabled = YES;
    int needCount = _detailInfo.needEquitment.count;
    for (int i = 0; i < needCount; i ++) {
        GXImageView *need = [[GXImageView alloc] init];
        int row = i / GXCount;
        int col = i % GXCount;
        CGFloat needX = 3 + (needW + padding) * col;
        CGFloat needY = margin + (needH + padding) * row;
        need.frame = CGRectMake(needX, needY, needW, needH);
        need.title = _detailInfo.needEquitment[i];
        need.userInteractionEnabled = YES;
        NSString *img = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", need.title];
        [need sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.needView addSubview:need];
        // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(tapEquipment:)];
        [need addGestureRecognizer:recognizer];
    }
    self.needView.frame = CGRectMake(0, CGRectGetMaxY(self.needLabel.frame) + margin, GXScreenWidth, 60 * ((needCount + GXCount - 1) / GXCount));
    
    self.composeLabel.text = @"可合成";
    self.composeLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.needView.frame), GXScreenWidth, 30);
    
    CGFloat composeW = 50;
    CGFloat composeH = composeW;
    self.composeView.image = [UIImage resizedImage:@"hero_info_bg"];
    self.composeView.userInteractionEnabled = YES;
    int composeCount = _detailInfo.composeEquitment.count;
    for (int i = 0; i < composeCount; i ++) {
        GXImageView *compose = [[GXImageView alloc] init];
        int row = i / GXCount;
        int col = i % GXCount;
        CGFloat composeX = 3 + (composeW + padding) * col;
        CGFloat composeY = margin + (composeH + padding) * row;
        compose.frame = CGRectMake(composeX, composeY, composeW, composeH);
        compose.title = _detailInfo.composeEquitment[i];
        compose.userInteractionEnabled = YES;
        NSString *img = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", compose.title];
        [compose sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        [self.composeView addSubview:compose];
        // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(tapEquipment:)];
        [compose addGestureRecognizer:recognizer];
    }
    self.composeView.frame = CGRectMake(0, CGRectGetMaxY(self.composeLabel.frame) + margin, GXScreenWidth, 60 * ((composeCount + GXCount - 1) / GXCount));
    
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.composeView.frame) + 84);
}

/**
 *  监听图片的点击
 */
- (void)tapEquipment:(UITapGestureRecognizer *)recognizer
{
    GXImageView *view = (GXImageView *)recognizer.view;
    if ([self.delegate respondsToSelector:@selector(equipmentDidClick:)]) {
        [self.delegate equipmentDidClick:view.title];
    }
}

@end

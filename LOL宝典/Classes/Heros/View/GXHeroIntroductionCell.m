//
//  GXHeroIntroductionCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroIntroductionCell.h"
#import "GXHeroCellModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "UIImage+Extension.h"
#import "GXImageView.h"

#define GXCellCount 6

@interface GXHeroIntroductionCell ()

@property (nonatomic, strong) NSMutableArray *skillAarray;

@property (nonatomic, strong) NSMutableArray *equipmentArray;

@property (nonatomic, weak) UILabel *descripe;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *cover;
@end

@implementation GXHeroIntroductionCell

- (NSMutableArray *)skillAarray
{
    if (_skillAarray == nil) {
        _skillAarray = [NSMutableArray array];
    }
    return _skillAarray;
}

- (NSMutableArray *)equipmentArray
{
    if (_equipmentArray == nil) {
        _equipmentArray = [NSMutableArray array];
    }
    return _equipmentArray;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        // 创建头部标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 创建背景
        UIImageView *cover = [[UIImageView alloc] init];
        cover.userInteractionEnabled = YES;
        [self addSubview:cover];
        cover.image = [UIImage resizedImage:@"hero_info_bg"];
        self.cover = cover;
        
        // 创建加点数组
        for (int i = 0; i < GXCellCount; i ++) {
            GXImageView *skill = [[GXImageView alloc] init];
            skill.userInteractionEnabled = YES;
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapSkillsment:)];
            [skill addGestureRecognizer:recognizer];
            [self.cover addSubview:skill];
            [self.skillAarray addObject:skill];
        }
        
        // 创建出装数组
        for (int i = 0; i < GXCellCount; i ++) {
            GXImageView *equipment = [[GXImageView alloc] init];
            equipment.userInteractionEnabled = YES;
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapEquipment:)];
            [equipment addGestureRecognizer:recognizer];
            [self.cover addSubview:equipment];
            [self.equipmentArray addObject:equipment];
        }
        
        // 创建说明
        UILabel *descripe = [[UILabel alloc] init];
        descripe.font = [UIFont systemFontOfSize:13];
        descripe.numberOfLines = 0;
        [self.cover addSubview:descripe];
        self.descripe = descripe;
    }
    return self;
}

- (void)setHeroCell:(GXHeroCellModel *)heroCell
{
    _heroCell = heroCell;
    
    
    self.titleLabel.text = _heroCell.title;
    CGFloat margin = 5;
    CGFloat padding = 2;
    CGFloat titleX = margin;
    CGFloat titleY = margin;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
    
    CGFloat skillY = margin;
    CGFloat skillW = 30;
    CGFloat skillH = 0;
    if (_heroCell.skills) {
        skillH = skillW;
        for (int i = 0; i < self.skillAarray.count; i ++) {
            GXImageView *skill = self.skillAarray[i];
            
            CGFloat skillX = margin + (skillW + padding) * i;
            skill.frame = CGRectMake(skillX, skillY, skillW, skillH);
            [skill sd_setImageWithURL:[NSURL URLWithString:_heroCell.skills[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            NSString *preTitle = [_heroCell.skills[i] stringByReplacingOccurrencesOfString:@"http://static.lolbox.duowan.com/images/pqwer/" withString:@""];
            NSString *title = [preTitle stringByReplacingOccurrencesOfString:@"_64x64.jpg" withString:@""];
            skill.title = [title skillUppercaseString];
            UILabel *markLabel = [[UILabel alloc] init];
            markLabel.textAlignment = NSTextAlignmentCenter;
            markLabel.font = [UIFont systemFontOfSize:10];
            markLabel.textColor = [UIColor pastelBlueColor];
            markLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            markLabel.layer.cornerRadius = 1.5;
            markLabel.clipsToBounds = YES;
            CGFloat markWidth = 12;
            markLabel.frame = CGRectMake(skill.width - markWidth, skill.height - markWidth, markWidth, markWidth);
            markLabel.text = [[skill.title componentsSeparatedByString:@"_"] lastObject];
            [skill addSubview:markLabel];
        }
    }
    
    CGFloat equipmentW = 50;
    CGFloat equipmentH = equipmentW;
    CGFloat equipmentY = skillY + skillH + margin;
    for (int i = 0; i < _heroCell.equipment.count; i ++) {
        GXImageView *equipment = self.equipmentArray[i];
        
        CGFloat equipmentX = margin + (equipmentW + padding) * i;
        equipment.frame = CGRectMake(equipmentX, equipmentY, equipmentW, equipmentH);
        [equipment sd_setImageWithURL:[NSURL URLWithString:_heroCell.equipment[i]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        NSString *preTitle = [_heroCell.equipment[i] stringByReplacingOccurrencesOfString:@"http://img.lolbox.duowan.com/zb/" withString:@""];
        equipment.title = [preTitle stringByReplacingOccurrencesOfString:@"_64x64.png" withString:@""];
    }
    
    self.descripe.text = _heroCell.explain;
    CGFloat describeX = margin;
    CGFloat describeY = equipmentY + equipmentH + margin;
    CGSize describeSize = [self.descripe.text sizeWithFont:self.descripe.font maxSize:CGSizeMake(300, MAXFLOAT)];
    self.descripe.frame = CGRectMake(describeX, describeY, describeSize.width, describeSize.height);
    
    CGFloat coverX = 0;
    CGFloat coverY = CGRectGetMaxY(self.titleLabel.frame);
    CGFloat coverW = GXScreenWidth;
    CGFloat coverH = CGRectGetMaxY(self.descripe.frame) + margin;
    self.cover.frame = CGRectMake(coverX, coverY, coverW, coverH);
    
    _heroCell.cellHeight = titleSize.height + coverH + margin;
    
}

/**
 *  装备点击
 */
- (void)tapEquipment:(UITapGestureRecognizer *)recognizer
{
    GXImageView *view = (GXImageView *)recognizer.view;
    if (self.equipmentBlock) {
        self.equipmentBlock(view.title);
    }
}

/**
 *  加点点击
 */
- (void)tapSkillsment:(UITapGestureRecognizer *)recognizer
{
    GXImageView *view = (GXImageView *)recognizer.view;
    if (self.skillBlock) {
        self.skillBlock(view.title);
    }
}

@end

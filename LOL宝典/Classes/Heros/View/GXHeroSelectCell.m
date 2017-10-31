//
//  GXHeroSelectCell.m
//  LOL宝典
//
//  Created by sgx on 14-8-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroSelectCell.h"
#import "GXHeroIntroduction.h"

@interface GXHeroSelectCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIImageView *selectImg;

@end

@implementation GXHeroSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 添加标题Label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 添加选择图片
        UIImageView *selectImg = [[UIImageView alloc] init];
        [self addSubview:selectImg];
        self.selectImg = selectImg;
        
        self.backgroundColor = [UIColor wheatColor];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"cell";
    GXHeroSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[GXHeroSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    return cell;
}

- (void)setSelectedModel:(GXHeroIntroduction *)selectedModel
{
    _selectedModel = selectedModel;
    self.titleLabel.text = _selectedModel.title;
    if (!_selectedModel.selected) {
        self.selectImg.image = [UIImage imageNamed:@"new_feature_share_false"];
    } else {
        self.selectImg.image = [UIImage imageNamed:@"new_feature_share_true"];
    }
    
    CGFloat margin = 10;
    CGFloat titleX = margin;
    CGFloat titleY = margin * 0.5;
    CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleSize.width, titleSize.height);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat selectW = 23;
    CGFloat selectH = selectW;
    CGFloat selectY = 10;
    CGFloat selectX = self.width - selectW - 10;
    self.selectImg.frame = CGRectMake(selectX, selectY, selectW, selectH);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

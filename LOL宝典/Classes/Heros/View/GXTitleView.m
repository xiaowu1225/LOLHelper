//
//  GXTitleView.m
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXTitleView.h"
#import "GXHeroIntroduction.h"
#import "UIImageView+WebCache.h"

@interface GXTitleView ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *nameLabel;

@property (nonatomic, weak) UIButton *giftBtn;

@property (nonatomic, weak) UILabel *authorLabel;
@end

@implementation GXTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 天赋与符文
        UIButton *giftBtn = [[UIButton alloc] init];
        [giftBtn addTarget:self action:@selector(giftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:giftBtn];
        self.giftBtn = giftBtn;
        
        // 作者
        UILabel *authorLabel = [[UILabel alloc] init];
        authorLabel.font = [UIFont systemFontOfSize:13];
        authorLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:authorLabel];
        self.authorLabel = authorLabel;
        
        
    }
    return self;
}

- (void)setIntroduction:(GXHeroIntroduction *)introduction
{
    _introduction = introduction;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_introduction.img] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    CGFloat margin = 5;
    CGFloat iconW = 64;
    CGFloat iconH = iconW;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",_introduction.ch_name, _introduction.en_name];
    CGFloat nameX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat nameY = iconY + margin;
    CGSize nameSize = [self.nameLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.nameLabel.frame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    [self.giftBtn setTitle:@"天赋与符文" forState:UIControlStateNormal];
    [self.giftBtn setBackgroundImage:[UIImage resizedImage:@"hero_info_bg"] forState:UIControlStateNormal];
    self.giftBtn.layer.cornerRadius = 3;
    self.giftBtn.clipsToBounds = YES;
    [self.giftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.giftBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    CGFloat giftW = 70;
    CGFloat giftH = 20;
    CGFloat giftX = GXScreenWidth - margin - giftW;
    CGFloat giftY = nameY;
    self.giftBtn.frame = CGRectMake(giftX, giftY, giftW, giftH);
    
    self.authorLabel.text = [NSString stringWithFormat:@"作者:%@(战斗力%@)", _introduction.author, _introduction.combat];
    CGFloat authorX = nameX;
    CGFloat authorY = CGRectGetMaxY(self.nameLabel.frame) + 4 * margin;
    CGSize authorSize = [self.authorLabel.text sizeWithFont:self.nameLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.authorLabel.frame = CGRectMake(authorX, authorY, authorSize.width, authorSize.height);

}

- (void)giftBtnClick
{
    if ([self.delegate respondsToSelector:@selector(giftBtnDidClickWithHeroName:)]) {
        [self.delegate giftBtnDidClickWithHeroName:self.introduction.en_name];
    }
}

@end

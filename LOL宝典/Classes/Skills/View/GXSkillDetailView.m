//
//  GXSkillDetailView.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillDetailView.h"
#import "GXSkillsTitleView.h"
#import "GXSkillsInfo.h"

@interface GXSkillDetailView ()
@property (nonatomic, strong) GXSkillsTitleView *titleView;
@property (nonatomic, weak) UILabel *describeLabel;
@property (nonatomic, weak) UIImageView *describeView;
@property (nonatomic, weak) UILabel *strongLabel;
@property (nonatomic, weak) UIImageView *strongView;
@property (nonatomic, weak) UILabel *tipsLabel;
@property (nonatomic, weak) UIImageView *tipsView;
@end

@implementation GXSkillDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        GXSkillsTitleView *titleView = [[GXSkillsTitleView alloc] init];
        [self addSubview:titleView];
        self.titleView = titleView;
        
        UILabel *describeLabel = [[UILabel alloc] init];
        describeLabel.textColor = [UIColor darkGrayColor];
        describeLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:describeLabel];
        self.describeLabel = describeLabel;
        
        UIImageView *describeView = [[UIImageView alloc] init];
        describeView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:describeView];
        self.describeView = describeView;
        
        UILabel *strongLabel = [[UILabel alloc] init];
        strongLabel.textColor = [UIColor darkGrayColor];
        strongLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:strongLabel];
        self.strongLabel = strongLabel;
        
        UIImageView *strongView = [[UIImageView alloc] init];
        strongView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:strongView];
        self.strongView = strongView;
        
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.textColor = [UIColor darkGrayColor];
        tipsLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:tipsLabel];
        self.tipsLabel = tipsLabel;
        
        UIImageView *tipsView = [[UIImageView alloc] init];
        tipsView.image = [UIImage resizedImage:@"hero_info_bg"];
        [self addSubview:tipsView];
        self.tipsView = tipsView;
        
        self.backgroundColor = [UIColor wheatColor];
    }
    return self;
}

- (void)setSkillSinfo:(GXSkillsInfo *)skillSinfo
{
    _skillSinfo = skillSinfo;
    CGFloat margin = 5;
    
    self.titleView.skills = _skillSinfo;
    
    self.describeLabel.text = @"描述";
    self.describeLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.titleView.frame), GXScreenWidth, 30);
    
    UILabel *describe = [[UILabel alloc] init];
    describe.text = _skillSinfo.des;
    describe.numberOfLines = 0;
    describe.font = [UIFont systemFontOfSize:13];
    CGSize describeSize = [describe.text sizeWithFont:describe.font maxSize:CGSizeMake(GXScreenWidth - 2 * margin, MAXFLOAT)];
    describe.frame = CGRectMake(margin, margin, describeSize.width, describeSize.height);
    [self.describeView addSubview:describe];
    self.describeView.frame = CGRectMake(0, CGRectGetMaxY(self.describeLabel.frame), GXScreenWidth, describeSize.height + 2 * margin);

    self.strongLabel.text = @"天赋强化";
    self.strongLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.describeView.frame), GXScreenWidth, 30);
    
    UILabel *strong = [[UILabel alloc] init];
    strong.text = _skillSinfo.strong;
    strong.numberOfLines = 0;
    strong.font = [UIFont systemFontOfSize:13];
    CGSize strongSize = [strong.text sizeWithFont:strong.font maxSize:CGSizeMake(GXScreenWidth - 2 * margin, MAXFLOAT)];
    strong.frame = CGRectMake(margin, margin, strongSize.width, strongSize.height);
    [self.strongView addSubview:strong];
    self.strongView.frame = CGRectMake(0, CGRectGetMaxY(self.strongLabel.frame), GXScreenWidth, strongSize.height + 2 * margin);

    self.tipsLabel.text = @"提示";
    self.tipsLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.strongView.frame), GXScreenWidth, 30);
    
    UILabel *tips = [[UILabel alloc] init];
    tips.text = _skillSinfo.tips;
    tips.numberOfLines = 0;
    tips.font = [UIFont systemFontOfSize:13];
    CGSize tipsSize = [tips.text sizeWithFont:tips.font maxSize:CGSizeMake(GXScreenWidth - 2 * margin, MAXFLOAT)];
    tips.frame = CGRectMake(margin, margin, tipsSize.width, tipsSize.height);
    [self.tipsView addSubview:tips];
    self.tipsView.frame = CGRectMake(0, CGRectGetMaxY(self.tipsLabel.frame), GXScreenWidth, tipsSize.height + 2 * margin);
    
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.tipsView.frame) + 84);
}

@end

//
//  GXHeroIntroductionView.m
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroIntroductionView.h"
#import "GXHeroIntroductionCell.h"
#import "GXHeroIntroduction.h"
#import "GXHeroCellModel.h"

@interface GXHeroIntroductionView ()
@property (nonatomic, weak) GXHeroIntroductionCell *preCell;
@property (nonatomic, weak) GXHeroIntroductionCell *midCell;
@property (nonatomic, weak) GXHeroIntroductionCell *endCell;
@property (nonatomic, weak) GXHeroIntroductionCell *nfCell;
@end

@implementation GXHeroIntroductionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 添加子控件
        GXHeroIntroductionCell *preCell = [[GXHeroIntroductionCell alloc] init];
        preCell.skillBlock = ^(NSString *skillsId) {
            if (self.skillBlock) {
                self.skillBlock(skillsId);
            }
        };
        preCell.equipmentBlock = ^(NSString *equipmentId) {
            if (self.equipmentBlock) {
                self.equipmentBlock(equipmentId);
            }
        };
        [self addSubview:preCell];
        self.preCell = preCell;
        
        GXHeroIntroductionCell *midCell = [[GXHeroIntroductionCell alloc] init];
        midCell.skillBlock = ^(NSString *skillsId) {
            if (self.skillBlock) {
                self.skillBlock(skillsId);
            }
        };
        midCell.equipmentBlock = ^(NSString *equipmentId) {
            if (self.equipmentBlock) {
                self.equipmentBlock(equipmentId);
            }
        };
        [self addSubview:midCell];
        self.midCell = midCell;
        
        GXHeroIntroductionCell *endCell = [[GXHeroIntroductionCell alloc] init];
        endCell.skillBlock = ^(NSString *skillsId) {
            if (self.skillBlock) {
                self.skillBlock(skillsId);
            }
        };
        endCell.equipmentBlock = ^(NSString *equipmentId) {
            if (self.equipmentBlock) {
                self.equipmentBlock(equipmentId);
            }
        };
        [self addSubview:endCell];
        self.endCell = endCell;
        
        GXHeroIntroductionCell *nfCell = [[GXHeroIntroductionCell alloc] init];
        nfCell.skillBlock = ^(NSString *skillsId) {
            if (self.skillBlock) {
                self.skillBlock(skillsId);
            }
        };
        nfCell.equipmentBlock = ^(NSString *equipmentId) {
            if (self.equipmentBlock) {
                self.equipmentBlock(equipmentId);
            }
        };
        [self addSubview:nfCell];
        self.nfCell = nfCell;
    }
    return self;
}

- (void)setIntroduction:(GXHeroIntroduction *)introduction
{
    _introduction = introduction;
    
    [self setupPreCellWithIntroduction:introduction];
    [self setupMidCellWithIntroduction:introduction];
    [self setupEndCellWithIntroduction:introduction];
    [self setupNfCellWithIntroduction:introduction];
    
    self.contentSize = CGSizeMake(0, CGRectGetMaxY(self.nfCell.frame) + 5);
}

- (void)setupPreCellWithIntroduction:(GXHeroIntroduction *)introduction
{
    GXHeroCellModel *cellModel = [[GXHeroCellModel alloc] init];
    cellModel.title = @"前期";
    cellModel.skills = [introduction.skills subarrayWithRange:NSMakeRange(0, 6)];
    cellModel.equipment = introduction.pre_equipment;
    cellModel.explain = introduction.pre_explain;
    self.preCell.heroCell = cellModel;
    self.preCell.frame = CGRectMake(0, 0, GXScreenWidth, cellModel.cellHeight);
}

- (void)setupMidCellWithIntroduction:(GXHeroIntroduction *)introduction
{
    GXHeroCellModel *cellModel = [[GXHeroCellModel alloc] init];
    cellModel.title = @"中期";
    cellModel.skills = [introduction.skills subarrayWithRange:NSMakeRange(6, 6)];
    cellModel.equipment = introduction.mid_equipment;
    cellModel.explain = introduction.mid_explain;
    self.midCell.heroCell = cellModel;
    self.midCell.frame = CGRectMake(0, CGRectGetMaxY(self.preCell.frame), GXScreenWidth, cellModel.cellHeight);
}

- (void)setupEndCellWithIntroduction:(GXHeroIntroduction *)introduction
{
    GXHeroCellModel *cellModel = [[GXHeroCellModel alloc] init];
    cellModel.title = @"后期";
    cellModel.skills = [introduction.skills subarrayWithRange:NSMakeRange(12, 6)];
    cellModel.equipment = introduction.end_equipment;
    cellModel.explain = introduction.end_explain;
    self.endCell.heroCell = cellModel;
    self.endCell.frame = CGRectMake(0, CGRectGetMaxY(self.midCell.frame), GXScreenWidth, cellModel.cellHeight);
}

- (void)setupNfCellWithIntroduction:(GXHeroIntroduction *)introduction
{
    GXHeroCellModel *cellModel = [[GXHeroCellModel alloc] init];
    cellModel.title = @"逆风";
    cellModel.equipment = introduction.nf_equipment;
    cellModel.explain = introduction.nf_explain;
    self.nfCell.heroCell = cellModel;
    self.nfCell.frame = CGRectMake(0, CGRectGetMaxY(self.endCell.frame), GXScreenWidth, cellModel.cellHeight);
}

@end

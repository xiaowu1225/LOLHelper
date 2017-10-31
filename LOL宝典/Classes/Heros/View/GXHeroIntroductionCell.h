//
//  GXHeroIntroductionCell.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapEquipmentBlock)(NSString *equipmentId);

typedef void(^TapSkillsBlock)(NSString *skillsId);

@class GXHeroCellModel;
@interface GXHeroIntroductionCell : UIView

@property (nonatomic, strong) GXHeroCellModel *heroCell;

@property (nonatomic, copy) TapEquipmentBlock equipmentBlock;

@property (nonatomic, copy) TapSkillsBlock skillBlock;

@end

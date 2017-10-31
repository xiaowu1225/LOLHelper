//
//  GXHeroIntroductionView.h
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapEquipmentBlock)(NSString *equipmentId);

typedef void(^TapSkillsBlock)(NSString *skillsId);

@class GXHeroIntroduction;
@interface GXHeroIntroductionView : UIScrollView

@property (nonatomic, strong) GXHeroIntroduction *introduction;

@property (nonatomic, copy) TapEquipmentBlock equipmentBlock;

@property (nonatomic, copy) TapSkillsBlock skillBlock;

@end

//
//  GXSkillsInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXSkillsInfo : NSObject
/**
 *  技能名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  技能id
 */
@property (nonatomic, copy) NSString *id;
/**
 *  技能需要等级
 */
@property (nonatomic, copy) NSString *level;
/**
 *  技能冷却时间
 */
@property (nonatomic, copy) NSString *cooldown;
/**
 *  技能具体描述
 */
@property (nonatomic, copy) NSString *des;
/**
 *  天赋强化
 */
@property (nonatomic, copy) NSString *strong;
/**
 *  技能提示
 */
@property (nonatomic, copy) NSString *tips;
/**
 *  技能图标
 */
@property (nonatomic, copy) NSString *icon;
@end

//
//  GXSkills.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXSkills : NSObject
/**
 *  加点ID
 */
@property (nonatomic, copy) NSString *id;
/**
 *  加点名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  加点字母
 */
@property (nonatomic, copy) NSString *enName;
/**
 *  加点图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  加点消耗
 */
@property (nonatomic, copy) NSString *cost;
/**
 *  加点冷却
 */
@property (nonatomic, copy) NSString *cooldown;
/**
 *  加点描述
 */
@property (nonatomic, copy) NSString *descStr;
/**
 *  加点范围
 */
@property (nonatomic, copy) NSString *range;
/**
 *  加点效果
 */
@property (nonatomic, copy) NSString *effect;

@end

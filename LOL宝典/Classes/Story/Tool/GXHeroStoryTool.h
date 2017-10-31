//
//  GXHeroStoryTool.h
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GXHeroStoryTool : NSObject
/**
 *  城市信息列表
 */
+ (NSMutableArray *)cityList;
/**
 *  武器信息列表
 */
+ (NSMutableArray *)wuqiList;
/**
 *  英雄信息列表
 */
+ (NSMutableArray *)lolPeople;
/**
 *  查询英雄信息
 */
+ (NSMutableArray *)queryWithCondition:(NSString *)condition;
@end

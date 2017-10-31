//
//  GXHeroTool.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GXUser, GXGift, GXSkills;

@interface GXHeroTool : NSObject

/**
 *  加载全部英雄列表信息
 *
 *  @param schoolNo 用户
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadHerosListWithUser:(GXUser *)user success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载免费英雄列表信息
 *
 *  @param schoolNo 用户
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadFreeHerosListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载英雄用法介绍信息
 *
 *  @param championName 英雄名
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadHerosIntroductionWithChampionName:(NSString *)championName success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载英雄符文与天赋信息
 *
 *  @param championName 英雄名
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadHeroGiftInfoWithChampionName:(NSString *)championName success:(void (^)(GXGift *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载英雄加点信息
 *
 *  @param championName 英雄名
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadHeroSkillsInfoWithChampionName:(NSString *)championName success:(void (^)(GXSkills *result))success failure:(void (^)(NSError *error))failure;

/**
 *  查询英雄信息
 */
+ (NSMutableArray *)queryWithCondition:(NSString *)condition;
@end

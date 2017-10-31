//
//  GXShakeTool.h
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GXUser, GXShakeResult;

@interface GXShakeTool : NSObject
/**
 *  加载英雄列表信息
 *
 *  @param schoolNo 用户
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadCurrentCombatInfoWithUser:(GXUser *)user success:(void (^)(GXShakeResult *result))success failure:(void (^)(NSError *error))failure;
@end

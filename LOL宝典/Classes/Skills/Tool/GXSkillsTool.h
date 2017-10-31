//
//  GXSkillsTool.h
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXSkillsTool : NSObject
/**
 *  加载技能列表数据
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)loadSkillsInfoSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;
@end

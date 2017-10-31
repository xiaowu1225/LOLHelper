//
//  GXEquitmentTool.h
//  LOL宝典
//
//  Created by sgx on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GXEquipmentDetailInfo;

@interface GXEquitmentTool : NSObject

/**
 *  加载装备列表数据
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)loadEquipmentListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载装备详细列表信息
 *
 *  @param tag 装备列表id
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadEquipmentDetailListWithTag:(NSString *)tag success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载装备详细信息
 *
 *  @param ID 装备id
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadEquipmentDetailInfoWithID:(NSString *)ID success:(void (^)(GXEquipmentDetailInfo *result))success failure:(void (^)(NSError *error))failure;
@end

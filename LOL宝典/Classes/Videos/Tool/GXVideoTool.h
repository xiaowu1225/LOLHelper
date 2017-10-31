//
//  GXVideoTool.h
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GXVideoDetailInfo;

@interface GXVideoTool : NSObject

/**
 *  加载首页视频列表数据
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)loadHomeVideoListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载视频详细列表信息
 *
 *  @param ID 视频列表id
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadVideoDetailListWithId:(NSString *)ID success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载视频详细地址信息
 *
 *  @param ID 视频id
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadVideoDetailUrlWithId:(NSString *)ID success:(void (^)(GXVideoDetailInfo *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载英雄视频列表信息
 *
 *  @param param    参数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadHeroVideoListWithParam:(NSDictionary *)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载英雄视频详细信息
 *
 *  @param param    参数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadHeroVideoInfoWithParam:(NSDictionary *)param success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载分类视频列表信息
 *
 *  @param param    参数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadCategoryVideoListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载搜索视频列表信息
 *
 *  @param param    参数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadSearchVideoListWithParam:(NSDictionary *)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载最新视频列表信息
 *
 *  @param param    参数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadNewsVideoListWithParam:(NSDictionary *)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

@end

//
//  GXHttpTool.h
//  新浪微博
//
//  Created by sgx on 14-7-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GXHttpTool : NSObject
/**
 *  发送一个GET请求
 *
 *  @param url     请求参数路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)GET:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+ (void)POST:(NSString *)url parameters:(NSDictionary*)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

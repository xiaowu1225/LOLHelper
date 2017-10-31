//
//  GXLiveTool.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXLiveTool : NSObject
/**
 *  加载直播首页数据
 *
 *  @param pageStr  直播页数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadLiveHomeInfoWithPage:(NSString *)pageStr success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
/**
 *  加载直播详细数据
 *
 *  @param pageStr  直播页数
 *  @param sid      直播sid
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)loadLiveDetailInfoWithSid:(NSString *)sid page:(NSString *)pageStr success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure;
@end

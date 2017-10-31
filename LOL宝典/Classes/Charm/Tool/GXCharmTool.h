//
//  GXCharmTool.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCharmTool : NSObject
/**
 *  加载技能列表数据
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)loadCharmInfoSuccess:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;
@end

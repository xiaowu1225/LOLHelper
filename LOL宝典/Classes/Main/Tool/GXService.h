//
//  GXService.h
//  LOL宝典
//
//  Created by siguoxi on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXService : NSObject
/**
 *  @return YES(网络连接正常);NO(网络未连接)
 */
+ (BOOL)isConnectionAvailable;
/**
 *  空值处理
 */
+ (id)processDictionaryIsNSNull:(id)obj;
/**
 *  MD5-32位加密
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;
/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;
/**
 *  获得本地视频路径
 */
+ (NSString *)getLocalVideoPathWithName:(NSString *)videoName;
/**
 *  时间戳转换成日期
 */
+ (NSString *)formatDateStamp:(NSString *)dateStamp;
/**
 *  日期转换成时间戳
 */
+ (NSTimeInterval)deFormatDateStamp:(NSString *)dateStamp;
@end

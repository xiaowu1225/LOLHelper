//
//  GXService.m
//  LOL宝典
//
//  Created by siguoxi on 16/6/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXService.h"
#import <CommonCrypto/CommonDigest.h>

@implementation GXService

/**
 *  @return YES(网络连接正常);NO(网络未连接)
 */
+ (BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork = [[NSUserDefaults standardUserDefaults]boolForKey:@"networkStatus"];
    
    return isExistenceNetwork;
}

/**
 *  空值处理
 */
+ (id)processDictionaryIsNSNull:(id)obj
{
    const NSString *blank = @"";
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

/**
 *  @brief  MD5-32位加密
 *
 *  @param  srcString   需要被加密的字符串
 *
 *  @return 经过加密的字符串
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString
{
    
    if ([self isBlankString:srcString] == YES) {
        return @"nothing";
    }
    
    const char *cStr = [srcString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 *  @brief   判断字符串是否为空
 *
 *  @param  string  需要被鉴定的字符串
 *
 *  @return  YES(字符串为空);NO(字符串不为空)
 */
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)getLocalVideoPathWithName:(NSString *)videoName
{
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *savePath = [cache stringByAppendingPathComponent:@"Videos"];
    return [savePath stringByAppendingPathComponent:videoName];
}

+ (NSString *)formatDateStamp:(NSString *)dateStamp
{
    NSDate * dt = [NSDate dateWithTimeIntervalSince1970:[dateStamp doubleValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM-dd HH:mm"];
    NSString *regStr = [df stringFromDate:dt];
    return regStr;
}

+ (NSTimeInterval)deFormatDateStamp:(NSString *)dateStamp
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt = [df dateFromString:dateStamp];
    return dt.timeIntervalSince1970;
}

@end

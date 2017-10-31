//
//  NSString+File.m
//  新浪微博
//
//  Created by sgx on 14-8-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+File.h"

@implementation NSString (File)

- (long long)fileSize
{
    // 1.获得文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 文件或文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subPaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subPath in subPaths) {
            NSString *fullSubPath = [self stringByAppendingPathComponent:subPath];
            totalSize += [fullSubPath fileSize];
        }
        return totalSize;
    } else { // 不是文件夹，是文件
        // 直接计算当前文件的尺寸
        NSDictionary *fileInfo = [mgr attributesOfItemAtPath:self error:nil];
        return [fileInfo[NSFileSize] longLongValue];
    }
}

@end

//
//  NSString+File.h
//  新浪微博
//
//  Created by sgx on 14-8-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (File)
/**
 *  获得文件/文件夹的总字节数
 */
- (long long)fileSize;
@end

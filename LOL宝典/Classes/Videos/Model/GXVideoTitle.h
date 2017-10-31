//
//  GXVideoTitle.h
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXVideoTitle : NSObject
/**
 *  分类视频标题
 */
@property (nonatomic, copy) NSString *name;
/**
 *  分类视频图标
 */
@property (nonatomic, copy) NSString *ico;
/**
 *  分类视频id
 */
@property (nonatomic, copy) NSString *id;
/**
 *  分类视频版本
 */
@property (nonatomic, copy) NSString *versions;
/**
 *  分类视频url
 */
@property (nonatomic, copy) NSString *url;
@end

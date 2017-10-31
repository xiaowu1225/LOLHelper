//
//  GXVideoDetailInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXVideoDetailInfo : NSObject
/**
 *  广告信息
 */
@property (nonatomic, strong) NSArray *ad;
/**
 *  视频格式
 */
@property (nonatomic, copy) NSString *type;
/**
 *  视频url
 */
@property (nonatomic, copy) NSString *url;
@end

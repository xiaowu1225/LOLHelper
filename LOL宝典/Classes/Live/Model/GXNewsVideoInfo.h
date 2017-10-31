//
//  GXNewsVideoInfo.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXNewsVideoInfo : NSObject
/**
 *  视频ID
 */
@property (nonatomic, copy) NSString *id;
/**
 *  视频标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  视频内容
 */
@property (nonatomic, copy) NSString *content;
/**
 *  视频播放数
 */
@property (nonatomic, copy) NSString *readCount;
/**
 *  视频图片
 */
@property (nonatomic, copy) NSString *srcPhoto;
/**
 *  视频URL
 */
@property (nonatomic, copy) NSString *destUrl;
/**
 *  视频vid
 */
@property (nonatomic, strong) NSArray *videoList;
/**
 *  视频发布时间
 */
@property (nonatomic, copy) NSString *time;
@end

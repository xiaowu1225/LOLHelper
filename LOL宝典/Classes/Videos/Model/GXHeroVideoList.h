//
//  GXHeroVideoList.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXHeroVideoList : NSObject
/**
 *  视频id
 */
@property (nonatomic, copy) NSString *vid;
/**
 *  视频列表名
 */
@property (nonatomic, copy) NSString *udb;
/**
 *  视频列表名
 */
@property (nonatomic, copy) NSString *letv_video_id;
/**
 *  视频缩略图
 */
@property (nonatomic, copy) NSString *cover_url;
/**
 *  视频标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  视频通道ID
 */
@property (nonatomic, copy) NSString *channelId;
/**
 *  视频长度
 */
@property (nonatomic, copy) NSString *video_length;
/**
 *  视频列表名
 */
@property (nonatomic, copy) NSString *letv_video_unique;
/**
 *  视频更新时间
 */
@property (nonatomic, copy) NSString *upload_time;
/**
 *  视频播放次数
 */
@property (nonatomic, copy) NSString *play_count;
/**
 *  视频总页数
 */
@property (nonatomic, copy) NSString *totalPage;
@end

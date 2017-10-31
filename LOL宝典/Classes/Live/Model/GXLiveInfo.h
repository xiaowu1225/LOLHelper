//
//  GXLiveInfo.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXLiveInfo : NSObject
/**
 *  回复数
 */
@property (nonatomic, copy) NSString *replyCount;
/**
 *  视频来源
 */
@property (nonatomic, copy) NSString *videosource;
/**
 *  主题图标
 */
@property (nonatomic, copy) NSString *topicImg;
/**
 *  主题描述
 */
@property (nonatomic, copy) NSString *topicDesc;
/**
 *  主题sid
 */
@property (nonatomic, copy) NSString *topicSid;
/**
 *  主题名称
 */
@property (nonatomic, copy) NSString *topicName;
/**
 *  视频图片
 */
@property (nonatomic, copy) NSString *cover;
/**
 *  视频标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  视频描述
 */
@property (nonatomic, copy) NSString *descStr;
/**
 *  播放次数
 */
@property (nonatomic, copy) NSString *playCount;
/**
 *  回复板
 */
@property (nonatomic, copy) NSString *replyBoard;
/**
 *  回复id
 */
@property (nonatomic, copy) NSString *replyid;
/**
 *  mp4播放地址
 */
@property (nonatomic, copy) NSString *mp4_url;
/**
 *  m3u8播放地址
 */
@property (nonatomic, copy) NSString *m3u8_url;
/**
 *  mp4高清播放地址
 */
@property (nonatomic, copy) NSString *mp4Hd_url;
/**
 *  m3u8高清播放地址
 */
@property (nonatomic, copy) NSString *m3u8Hd_url;
/**
 *  视频长度
 */
@property (nonatomic, copy) NSString *length;
/**
 *  更新时间
 */
@property (nonatomic, copy) NSString *ptime;
@end

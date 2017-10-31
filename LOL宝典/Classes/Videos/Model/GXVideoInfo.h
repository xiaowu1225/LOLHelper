//
//  GXVideoInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXVideoInfo : NSObject
/**
 *  视频id
 */
@property (nonatomic, copy) NSString *id;
/**
 *  视频类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  视频标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  是否为视频
 */
@property (nonatomic, copy) NSString *isvideo;
/**
 *  具体描述
 */
@property (nonatomic, copy) NSString *des;
/**
 *  视频发布时间
 */
@property (nonatomic, copy) NSString *datetime;
/**
 *  视频网址
 */
@property (nonatomic, copy) NSString *url;
/**
 *  查看次数
 */
@property (nonatomic, copy) NSString *viewnum;
/**
 *  视频类型
 */
@property (nonatomic, copy) NSString *videotype;
/**
 *  频道
 */
@property (nonatomic, copy) NSString *channel;
/**
 *  回复次数
 */
@property (nonatomic, copy) NSString *replynum;
/**
 *  评论数
 */
@property (nonatomic, copy) NSString *commentnum;
/**
 *  视频来源
 */
@property (nonatomic, copy) NSString *from;
/**
 *  视频图标
 */
@property (nonatomic, copy) NSString *ico;
/**
 *  本地视频
 */
@property (nonatomic, copy) NSString *videoName;
/**
 *  已经缓存
 */
@property (nonatomic, assign) BOOL hasCaching;
/**
 *  视频大小
 */
@property (nonatomic, copy) NSString *videoSize;
/**
 *  已经选中
 */
@property (nonatomic, assign) BOOL hasSelect;
@end

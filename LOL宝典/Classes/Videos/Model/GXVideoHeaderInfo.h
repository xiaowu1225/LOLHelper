//
//  GXVideoHeaderInfo.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXVideoHeaderInfo : NSObject
/**
 *  分类视频描述
 */
@property (nonatomic, copy) NSString *des;
/**
 *  分类视频图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  分类视频名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  分类视频图片
 */
@property (nonatomic, copy) NSString *pic;
/**
 *  分类视频播放次数
 */
@property (nonatomic, copy) NSString *playCount;
/**
 *  分类视频来源
 */
@property (nonatomic, copy) NSString *src;
/**
 *  分类视频tag
 */
@property (nonatomic, copy) NSString *tag;
/**
 *  分类视频标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  分类视频总数量
 */
@property (nonatomic, copy) NSString *videoCount;
/**
 *  头部高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
@end

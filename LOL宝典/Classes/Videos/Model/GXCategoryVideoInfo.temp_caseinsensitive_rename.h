//
//  GXCategoryVIdeoInfo.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCategoryVideoInfo : NSObject
/**
 *  分组tag
 */
@property (nonatomic, copy) NSString *tag;
/**
 *  分组名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  分组图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  分组播放次数
 */
@property (nonatomic, copy) NSString *playCount;
/**
 *  分组图标
 */
@property (nonatomic, copy) NSString *pic;
/**
 *  分组视频数量
 */
@property (nonatomic, copy) NSString *videoCount;
/**
 *  分组标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  分组描述
 */
@property (nonatomic, copy) NSString *des;
/**
 *  分组最新更新数
 */
@property (nonatomic, copy) NSString *dailyUpdate;
/**
 *  分组URL
 */
@property (nonatomic, copy) NSString *url;
@end

//
//  GXCharmInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCharmInfo : NSObject
/**
 *  符文名字
 */
@property (nonatomic, copy) NSString *Name;
/**
 *  符文表识
 */
@property (nonatomic, copy) NSString *Alias;
/**
 *  1级符文效果
 */
@property (nonatomic, copy) NSString *lev1;
/**
 *  2级符文效果
 */
@property (nonatomic, copy) NSString *lev2;
/**
 *  3级符文效果
 */
@property (nonatomic, copy) NSString *lev3;
/**
 *  1级符文游戏币
 */
@property (nonatomic, copy) NSString *iplev1;
/**
 *  2级符文游戏币
 */
@property (nonatomic, copy) NSString *iplev2;
/**
 *  3级符文游戏币
 */
@property (nonatomic, copy) NSString *iplev3;
/**
 *  符文效果
 */
@property (nonatomic, copy) NSString *Prop;
/**
 *  符文类型
 */
@property (nonatomic, copy) NSString *Type;
/**
 *  符文推荐
 */
@property (nonatomic, copy) NSString *Recom;
/**
 *  符文图片
 */
@property (nonatomic, copy) NSString *Img;
/**
 *  符文百分比
 */
@property (nonatomic, copy) NSString *Units;
/**
 *  符文支持
 */
@property (nonatomic, copy) NSString *Standby;
@end

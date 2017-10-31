//
//  GXPeople.h
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GXHeroTypeAll = 0,
    GXHeroTypeJinZhan,
    GXHeroTypeYuanCheng,
    GXHeroTypeWuLi,
    GXHeroTypeFaShu,
    GXHeroTypeTank,
    GXHeroTypeFuZhu,
    GXHeroTypeDaYe,
    GXHeroTypeQianXing,
    GXHeroTypeHot,
}GXHeroType;

@interface GXPeople : NSObject
/**
 *  英雄图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  英雄id
 */
@property (nonatomic, assign) int id;
/**
 *  英雄名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  英雄称谓
 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *imagepath;
/**
 *  英雄故事
 */
@property (nonatomic, copy) NSString *story;
/**
 *  英雄所在阵营
 */
@property (nonatomic, copy) NSString *zhenying;
/**
 *  英雄外号
 */
@property (nonatomic, copy) NSString *waihao;
/**
 *  使用技巧
 */
@property (nonatomic, copy) NSString *selfuse;
/**
 *  对付技巧
 */
@property (nonatomic, copy) NSString *otheruse;
/**
 *  是否为近战英雄
 */
@property (nonatomic, assign) int isJinZhan;
/**
 *  是否为远程英雄
 */
@property (nonatomic, assign) int isYuanCheng;
/**
 *  是否为物理英雄
 */
@property (nonatomic, assign) int isWuLi;
/**
 *  是否为法术英雄
 */
@property (nonatomic, assign) int isFaShu;
/**
 *  是否为坦克英雄
 */
@property (nonatomic, assign) int isTank;
/**
 *  是否为辅助英雄
 */
@property (nonatomic, assign) int isFuZhu;
/**
 *  是否为打野英雄
 */
@property (nonatomic, assign) int isDaYe;
/**
 *  是否为潜行英雄
 */
@property (nonatomic, assign) int isQianXing;
/**
 *  是否为热门英雄
 */
@property (nonatomic, assign) int isHot;
@end

//
//  GXShakeHeroInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXShakeHeroInfo : NSObject
/**
 *  排位赛
 */
@property (nonatomic, copy) NSString *zdl;
/**
 *  胜率
 */
@property (nonatomic, copy) NSString *winRate;
/**
 *  总场次
 */
@property (nonatomic, copy) NSString *total;
/**
 *  评级描述
 */
@property (nonatomic, copy) NSString *tierDesc;
/**
 *  所用英雄名
 */
@property (nonatomic, copy) NSString *heroName;
/**
 *  自己昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  服务器名称
 */
@property (nonatomic, copy) NSString *sn;
/**
 *  头像url
 */
@property (nonatomic, copy) NSString *img;
@end

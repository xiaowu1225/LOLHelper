//
//  GXHero.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXHero : NSObject
/**
 *  英雄ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  英雄英文名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  英雄中文名
 */
@property (nonatomic, copy) NSString *title;
/**
 *  英雄称号
 */
@property (nonatomic, copy) NSString *display_name;
/**
 *  图片地址
 */
@property (nonatomic, copy) NSString *img;
@end

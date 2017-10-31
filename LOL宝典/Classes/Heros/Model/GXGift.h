//
//  GXGift.h
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXGift : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  英雄名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  符文图片
 */
@property (nonatomic, copy) NSString *fuPic;
/**
 *  符文描述
 */
@property (nonatomic, copy) NSString *fuDes;
/**
 *  天赋图片
 */
@property (nonatomic, copy) NSString *tianPic;
/**
 *  天赋描述
 */
@property (nonatomic, copy) NSString *tianDes;
/**
 *  总体描述
 */
@property (nonatomic, copy) NSString *des;
@end

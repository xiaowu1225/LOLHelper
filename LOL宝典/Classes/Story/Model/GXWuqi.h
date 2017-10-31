//
//  GXWuqi.h
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXWuqi : NSObject
/**
 *  武器图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  武器id
 */
@property (nonatomic, assign) int id;
/**
 *  武器名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  武器介绍
 */
@property (nonatomic, copy) NSString *introduce;
@end

//
//  GXCitiy.h
//  数据库测试
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCitiy : NSObject
/**
 *  城市id
 */
@property (nonatomic, assign) int id;
/**
 *  城市名称
 */
@property (nonatomic, copy) NSString *cityname;
/**
 *  城市介绍
 */
@property (nonatomic, copy) NSString *cityintroduce;
@end

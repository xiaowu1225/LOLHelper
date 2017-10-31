//
//  GXCategoryVideoGroup.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCategoryVideoGroup : NSObject
/**
 *  分类视频组ID
 */
@property (nonatomic, copy) NSString *group;
/**
 *  分类视频组名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  分类视频子视频列表
 */
@property (nonatomic, strong) NSArray *subCategory;
@end

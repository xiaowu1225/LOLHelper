//
//  GXCommonGroup.h
//  新浪微博
//
//  Created by sgx on 14-7-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXCommonGroup : NSObject
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *header;
/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footer;
/**
 *  数组（里面存的是GXCommonItem模型）
 */
@property (nonatomic, strong) NSArray *items;
@end

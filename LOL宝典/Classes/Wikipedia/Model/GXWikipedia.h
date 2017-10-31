//
//  GXWikipedia.h
//  LOL宝典
//
//  Created by sgx on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXWikipedia : NSObject
/**
 *  百科名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  百科类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  百科tag
 */
@property (nonatomic, copy) NSString *tag;
/**
 *  百科图标
 */
@property (nonatomic, copy) NSString *icon;
@end

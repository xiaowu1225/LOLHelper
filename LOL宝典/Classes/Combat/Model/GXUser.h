//
//  GXUser.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXUser : NSObject
/**
 *  用户所在服务器名
 */
@property (nonatomic, copy) NSString *serverName;
/**
 *  用户名称
 */
@property (nonatomic, copy) NSString *playerName;
@end

//
//  GXShakeResult.h
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXShakeResult : NSObject
/**
 *  游戏时间
 */
@property (nonatomic, copy) NSString *timeStamp;
/**
 *  游戏模式
 */
@property (nonatomic, copy) NSString *gameMode;
/**
 *  游戏类型
 */
@property (nonatomic, copy) NSString *gameType;
/**
 *  游戏队列名
 */
@property (nonatomic, copy) NSString *queueTypeName;
/**
 *  游戏类型名
 */
@property (nonatomic, copy) NSString *queueTypeCn;
/**
 *  服务器名
 */
@property (nonatomic, copy) NSString *sn;
/**
 *  用户名
 */
@property (nonatomic, copy) NSString *pn;
/**
 *  己方战斗力排行
 */
@property (nonatomic, strong) NSMutableArray *own_sort;
/**
 *  敌方战斗力排行
 */
@property (nonatomic, strong) NSMutableArray *enemy_sort;
@end

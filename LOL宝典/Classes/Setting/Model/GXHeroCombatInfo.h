//
//  GXHeroCombatInfo.h
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXHeroCombatInfo : NSObject
/**
 *  双方信息
 */
@property (nonatomic, strong) NSDictionary *playerInfo;
/**
 *  游戏信息
 */
@property (nonatomic, strong) NSDictionary *gameInfo;
@end

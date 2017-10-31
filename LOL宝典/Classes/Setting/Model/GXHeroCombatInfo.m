//
//  GXHeroCombatInfo.m
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroCombatInfo.h"
#import "MJExtension.h"

@implementation GXHeroCombatInfo

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"own_sort": @"100_sort",
             @"enemy_sort": @"200_sort"};
}

@end

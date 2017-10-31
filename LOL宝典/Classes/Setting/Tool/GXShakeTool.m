//
//  GXShakeTool.m
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXShakeTool.h"
#import "GXUser.h"
#import "GXHeroCombatInfo.h"
#import "GXHttpTool.h"
#import "GXShakeHeroInfo.h"
#import "MJExtension.h"
#import "GXShakeHeroInfo.h"
#import "GXShakeResult.h"

@implementation GXShakeTool

+ (void)loadCurrentCombatInfoWithUser:(GXUser *)user success:(void (^)(GXShakeResult *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接请求参数
    NSString *url = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/apiCurrentMatch.php?action=getCurrentMatch&serverName=%@&target=%@", user.serverName, user.playerName];
    
    // 2.发送请求
    [GXHttpTool  GET:url parameters:nil success:^(NSDictionary *responseObject) {
        
        if (responseObject != nil) {
            GXShakeResult *result = [[GXShakeResult alloc] init];
            GXHeroCombatInfo *combat = [GXHeroCombatInfo objectWithKeyValues:responseObject];
            
            result.own_sort = [NSMutableArray array];
            result.enemy_sort = [NSMutableArray array];
            for (NSString *name in responseObject[@"gameInfo"][@"100_sort"]) {
                GXShakeHeroInfo *shake = [[GXShakeHeroInfo alloc] init];
                shake.name = name;
                shake.heroName = combat.gameInfo[@"100"][name];
                shake.zdl = combat.playerInfo[shake.name][@"zdl"];
                shake.winRate = combat.playerInfo[shake.name][@"winRate"];
                shake.total = combat.playerInfo[shake.name][@"total"];
                shake.tierDesc = combat.playerInfo[shake.name][@"tierDesc"];
                shake.sn = user.serverName;
                result.timeStamp = combat.gameInfo[@"timeStamp"];
                result.gameMode = combat.gameInfo[@"gameMode"];
                result.gameType = combat.gameInfo[@"gameType"];
                result.queueTypeName = combat.gameInfo[@"queueTypeName"];
                result.queueTypeCn = combat.gameInfo[@"queueTypeCn"];
                result.sn = combat.gameInfo[@"sn"];
                result.pn = combat.gameInfo[@"pn"];
                [result.own_sort addObject:shake];
            }
            for (NSString *name in responseObject[@"gameInfo"][@"200_sort"]) {
                GXShakeHeroInfo *shake = [[GXShakeHeroInfo alloc] init];
                shake.name = name;
                shake.heroName = combat.gameInfo[@"200"][name];
                shake.zdl = combat.playerInfo[shake.name][@"zdl"];
                shake.winRate = combat.playerInfo[shake.name][@"winRate"];
                shake.total = combat.playerInfo[shake.name][@"total"];
                shake.tierDesc = combat.playerInfo[shake.name][@"tierDesc"];
                shake.sn = user.serverName;
                result.timeStamp = combat.gameInfo[@"timeStamp"];
                result.gameMode = combat.gameInfo[@"gameMode"];
                result.gameType = combat.gameInfo[@"gameType"];
                result.queueTypeName = combat.gameInfo[@"queueTypeName"];
                result.queueTypeCn = combat.gameInfo[@"queueTypeCn"];
                result.sn = combat.gameInfo[@"sn"];
                result.pn = combat.gameInfo[@"pn"];
                [result.enemy_sort addObject:shake];
            }
            success(result);
        } else {
            success(nil);
        }
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

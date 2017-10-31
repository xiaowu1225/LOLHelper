//
//  GXHeroTool.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroTool.h"
#import "GXHttpTool.h"
#import "GXUser.h"
#import "GXHero.h"
#import "MJExtension.h"
#import "GXHeroIntroduction.h"
#import "FMDB.h"
#import "GXGift.h"
#import "GXSkills.h"


@implementation GXHeroTool

/**
 *  数据库实例
 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [doc stringByAppendingPathComponent:@"hero.sqlite"];
    
    // 2.得到数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    // 3.打开数据库
    if ([db open]) { // 不存在的时候自动创建 status.sqlite 数据库
        // 4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_hero (ID TEXT NOT NULL, name TEXT NOT NULL, title TEXT NOT NULL, display_name TEXT NOT NULL, img TEXT NOT NULL)"];
        if (result) {
            GXLog(@"创表成功");
        } else {
            GXLog(@"创表失败");
        }
    }
    
    _db = db;
}

+ (void)loadHerosListWithUser:(GXUser *)user success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://api.lolbox.duowan.com/api/v2/champion/all" parameters:nil success:^(NSDictionary *responseObject) {
        NSArray *resultArray = responseObject[@"champion_list"];
        if (resultArray) {
            NSArray *result = [GXHero objectArrayWithKeyValuesArray:resultArray];
            // 缓存英雄数据
            [self saveHeroInfo:result];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadFreeHerosListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://api.lolbox.duowan.com/api/v2/champion/free" parameters:nil success:^(NSDictionary *responseObject) {
        NSArray *resultArray = responseObject[@"champion_list"];
        if (resultArray) {
            NSArray *result = [GXHero objectArrayWithKeyValuesArray:resultArray];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *  缓存英雄数据
 */
+ (void)saveHeroInfo:(NSArray *)heroList
{
    // 先清空数据库再缓存
    [_db executeUpdate:@"DELETE FROM t_hero"];
    for (GXHero *hero in heroList) {
        [_db executeUpdate:@"INSERT INTO t_hero (ID, name, title, display_name, img) VALUES (?, ?, ?, ?, ?)", hero.ID, hero.name, hero.title, hero.display_name, hero.img];
    }
}

+ (NSMutableArray *)queryWithCondition:(NSString *)condition
{
    // 1.创建缓存英雄信息列表的数组
    NSMutableArray *heroList = [NSMutableArray array];
    
    // 1.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM t_hero WHERE name like '%%%@%%' OR display_name like '%%%@%%' OR title like '%%%@%%';", condition, condition, condition]];
    
    // 2.遍历结果
    while ([resultSet next]) {
        GXHero *hero = [[GXHero alloc] init];
        hero.ID = [resultSet stringForColumn:@"ID"];
        hero.name = [resultSet stringForColumn:@"name"];
        hero.title = [resultSet stringForColumn:@"title"];
        hero.display_name = [resultSet stringForColumn:@"display_name"];
        hero.img = [resultSet stringForColumn:@"img"];
        [heroList addObject:hero];
    }
    return heroList;
}


+ (void)loadHerosIntroductionWithChampionName:(NSString *)championName success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"http://db.duowan.com/lolcz/img/ku11/api/lolcz.php?championName=%@&limit=7", championName];
    
    // 2.发送GET请求
    [GXHttpTool GET:url parameters:nil success:^(NSArray *responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *result = [GXHeroIntroduction objectArrayWithKeyValuesArray:responseObject];
            success(result);
        } else {
            success([NSArray array]);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadHeroGiftInfoWithChampionName:(NSString *)championName success:(void (^)(GXGift *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"http://box.dwstatic.com/apiHeroSuggestedGiftAndRun.php?hero=%@", championName];
    
    [GXHttpTool GET:url parameters:nil success:^(NSArray *responseObject) {
        NSDictionary *dict = [responseObject firstObject];
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            GXGift *gift = [GXGift objectWithKeyValues:dict];
            success(gift);
        } else {
            success(nil);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadHeroSkillsInfoWithChampionName:(NSString *)championName success:(void (^)(GXSkills *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *heroName = [[championName componentsSeparatedByString:@"_"] firstObject];
    NSString *url = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/apiHeroDetail.php?heroName=%@", heroName];
    
    [GXHttpTool GET:url parameters:nil success:^(NSDictionary *responseObject) {
        if (responseObject && [responseObject objectForKey:championName]) {
            GXSkills *skills = [GXSkills objectWithKeyValues:[responseObject objectForKey:championName]];
            skills.enName = [[championName componentsSeparatedByString:@"_"] lastObject];
            skills.icon = [NSString stringWithFormat:@"http://static.lolbox.duowan.com/images/pqwer/%@_64x64.jpg", [championName skillLowercaseString]];
            success(skills);
        } else {
            GXSkills *skills = [[GXSkills alloc] init];
            skills.enName = [[championName componentsSeparatedByString:@"_"] lastObject];
            skills.icon = [NSString stringWithFormat:@"http://static.lolbox.duowan.com/images/pqwer/%@_64x64.jpg", [championName skillLowercaseString]];
            success(skills);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

//
//  GXHeroStoryTool.m
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroStoryTool.h"
#import "FMDB.h"
#import "GXCitiy.h"
#import "GXWuqi.h"
#import "GXPeople.h"
#import "MJExtension.h"

@implementation GXHeroStoryTool

/**
 *  数据库实例
 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"mydate.db" ofType:nil];
    
    // 2.得到数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    // 3.打开数据库
    if ([db open]) { // 不存在的时候自动创建 status.sqlite 数据库
        GXLog(@"成功打开数据库");
    } else {
        GXLog(@"打开数据库失败");
    }
    _db = db;
}

/**
 *  城市信息列表
 */
+ (NSMutableArray *)cityList
{
    // 1.创建缓存城市信息列表的数组
    NSMutableArray *citylist = [NSMutableArray array];
    
    // 2.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM citylist"];
    
    // 3.遍历结果
    while ([resultSet next]) {
        GXCitiy *city = [[GXCitiy alloc] init];
        city.id = [resultSet intForColumn:@"id"];
        city.cityname = [resultSet stringForColumn:@"cityname"];
        city.cityintroduce = [resultSet stringForColumn:@"cityintroduce"];
        [citylist addObject:city];
    }
    return citylist;
}
/**
 *  武器信息列表
 */
+ (NSMutableArray *)wuqiList
{
    // 1.创建缓存武器信息列表的数组
    NSMutableArray *wuqilist = [NSMutableArray array];
    
    // 2.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM wuqilist"];
    
    // 3.遍历结果
    while ([resultSet next]) {
        GXWuqi *wuqi = [[GXWuqi alloc] init];
        wuqi.id = [resultSet intForColumn:@"id"];
        wuqi.name = [resultSet stringForColumn:@"name"];
        wuqi.introduce = [resultSet stringForColumn:@"introduce"];
        [wuqilist addObject:wuqi];
    }
    return wuqilist;
}
/**
 *  英雄信息列表
 */
+ (NSMutableArray *)lolPeople
{
    // 1.创建缓存英雄信息列表的数组
    NSMutableArray *lolpeople = [NSMutableArray array];
    
    // 2.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM lolpeople"];
    
    // 3.遍历结果
    while ([resultSet next]) {
        GXPeople *people = [[GXPeople alloc] init];
        people.id = [resultSet intForColumn:@"id"];
        people.name = [resultSet stringForColumn:@"name"];
        people.nickname = [resultSet stringForColumn:@"nickname"];
        people.imagepath = [resultSet stringForColumn:@"imagepath"];
        people.story = [resultSet stringForColumn:@"story"];
        people.zhenying = [resultSet stringForColumn:@"zhenying"];
        people.waihao = [resultSet stringForColumn:@"waihao"];
        people.selfuse = [resultSet stringForColumn:@"selfuse"];
        people.otheruse = [resultSet stringForColumn:@"otheruse"];
        people.isJinZhan = [resultSet intForColumn:@"isJinZhan"];
        people.isYuanCheng = [resultSet intForColumn:@"isYuanCheng"];
        people.isWuLi = [resultSet intForColumn:@"isWuLi"];
        people.isFaShu = [resultSet intForColumn:@"isFaShu"];
        people.isTank = [resultSet intForColumn:@"isTank"];
        people.isFuZhu = [resultSet intForColumn:@"isFuZhu"];
        people.isDaYe = [resultSet intForColumn:@"isDaYe"];
        people.isQianXing = [resultSet intForColumn:@"isQianXing"];
        people.isHot = [resultSet intForColumn:@"isHot"];
        
        [lolpeople addObject:people];
    }
    return lolpeople;
}

+ (NSMutableArray *)queryWithCondition:(NSString *)condition
{
    // 1.创建缓存英雄信息列表的数组
    NSMutableArray *lolpeople = [NSMutableArray array];
    
    // 1.执行查询语句
    FMResultSet *resultSet = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM lolpeople WHERE name like '%%%@%%' OR nickname like '%%%@%%' OR waihao like '%%%@%%' ORDER BY id ASC;", condition, condition, condition]];
    
    // 2.遍历结果
    while ([resultSet next]) {
        GXPeople *people = [[GXPeople alloc] init];
        people.id = [resultSet intForColumn:@"id"];
        people.name = [resultSet stringForColumn:@"name"];
        people.nickname = [resultSet stringForColumn:@"nickname"];
        people.imagepath = [resultSet stringForColumn:@"imagepath"];
        people.story = [resultSet stringForColumn:@"story"];
        people.zhenying = [resultSet stringForColumn:@"zhenying"];
        people.waihao = [resultSet stringForColumn:@"waihao"];
        people.selfuse = [resultSet stringForColumn:@"selfuse"];
        people.otheruse = [resultSet stringForColumn:@"otheruse"];
        people.isJinZhan = [resultSet intForColumn:@"isJinZhan"];
        people.isYuanCheng = [resultSet intForColumn:@"isYuanCheng"];
        people.isWuLi = [resultSet intForColumn:@"isWuLi"];
        people.isFaShu = [resultSet intForColumn:@"isFaShu"];
        people.isTank = [resultSet intForColumn:@"isTank"];
        people.isFuZhu = [resultSet intForColumn:@"isFuZhu"];
        people.isDaYe = [resultSet intForColumn:@"isDaYe"];
        people.isQianXing = [resultSet intForColumn:@"isQianXing"];
        people.isHot = [resultSet intForColumn:@"isHot"];
        
        [lolpeople addObject:people];
    }
    return lolpeople;
}

@end

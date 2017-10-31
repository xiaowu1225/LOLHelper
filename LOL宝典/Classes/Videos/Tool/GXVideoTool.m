//
//  GXVideoTool.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoTool.h"
#import "MJExtension.h"
#import "GXHttpTool.h"
#import "GXVideoList.h"
#import "GXVideoInfo.h"
#import "GXVideoDetailInfo.h"
#import "GXCategoryVideoGroup.h"

@implementation GXVideoTool

+ (void)loadHomeVideoListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"https://x.xiushuang.com/client/Portal/p_cat_list/cat/video/ver/2/game/Lol/appinfo/590197302_49_apple_iphone/index.json" parameters:nil success:^(NSDictionary *responseObject) {
        NSArray *videoDictArray = responseObject[@"children"];
        NSArray *videoList = [GXVideoList objectArrayWithKeyValuesArray:videoDictArray];
        NSMutableArray *result = [NSMutableArray array];
        for (GXVideoList *video in videoList) {
            if (![video.name isEqualToString:@"秀爽活动"] && ![video.name isEqualToString:@"秀爽直播"]) {
                [result addObject:video];
            }
        }
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadVideoDetailListWithId:(NSString *)ID success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"https://x.xiushuang.com/client/Portal/p_list/catid/%@/p/1/game/Lol/appinfo/590197302_49_apple_iphone/index.json", ID];
    
    // 2.发送GET请求
    [GXHttpTool GET:url parameters:@{@"Content-Type": @"application/json"} success:^(NSDictionary *responseObject) {
        NSArray *videoInfoArray = responseObject[@"article"];
        NSArray *result = [GXVideoInfo objectArrayWithKeyValuesArray:videoInfoArray];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadVideoDetailUrlWithId:(NSString *)ID success:(void (^)(GXVideoDetailInfo *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"https://x.xiushuang.com/client/Portal/p_m3u8/id/%@/game/Lol/appinfo/590197302_49_apple_iphone/index.json", ID];
    
    // 2.发送GET请求
    [GXHttpTool GET:url parameters:@{@"Content-Type": @"application/json"} success:^(NSDictionary *responseObject) {
        GXVideoDetailInfo *result = [GXVideoDetailInfo objectWithKeyValues:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadHeroVideoListWithParam:(NSDictionary *)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?action=l&withCategory=1&src=letv&v=193" parameters:param success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadNewsVideoListWithParam:(NSDictionary *)param success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=newsVideo&v=197" parameters:param success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadSearchVideoListWithParam:(NSDictionary *)param success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?v=193&action=search" parameters:param success:^(NSArray *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadHeroVideoInfoWithParam:(NSDictionary *)param success:(void (^)(NSString *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?action=f" parameters:param success:^(NSDictionary *responseObject) {
        NSArray *urls = responseObject[@"result"][@"items"][@"1300"][@"transcode"][@"urls"];
        success([urls firstObject]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadCategoryVideoListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://box.dwstatic.com/apiVideoesNormalDuowan.php?v=193&action=c" parameters:nil success:^(NSArray *responseObject) {
        NSArray *videoList = [GXCategoryVideoGroup objectArrayWithKeyValuesArray:responseObject];
        success(videoList);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

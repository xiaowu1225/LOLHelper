//
//  GXLiveTool.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXLiveTool.h"
#import "GXHttpTool.h"
#import "GXLiveSid.h"
#import "GXLiveInfo.h"
#import "MJExtension.h"

@implementation GXLiveTool
+ (void)loadLiveHomeInfoWithPage:(NSString *)pageStr success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%@.html", pageStr];
    
    [GXHttpTool GET:url parameters:nil success:^(NSDictionary *responseObject) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        NSArray *videoSidList = [GXLiveSid objectArrayWithKeyValuesArray:responseObject[@"videoSidList"]];
        NSArray *videoList = [GXLiveInfo objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        result[@"videoSidList"] = videoSidList;
        result[@"videoList"] = videoList;
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadLiveDetailInfoWithSid:(NSString *)sid page:(NSString *)pageStr success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/list/%@/y/%@.html", sid, pageStr];
    
    [GXHttpTool GET:url parameters:nil success:^(NSDictionary *responseObject) {
        NSArray *liveArr = [GXLiveInfo objectArrayWithKeyValuesArray:[responseObject objectForKey:sid]];
        success(liveArr);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

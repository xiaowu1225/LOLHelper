//
//  GXEquitmentTool.m
//  LOL宝典
//
//  Created by sgx on 14-8-12.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXEquitmentTool.h"
#import "GXHttpTool.h"
#import "GXEquipmentTitle.h"
#import "MJExtension.h"
#import "GXEquipmentInfo.h"
#import "GXWikipedia.h"
#import "GXEquipmentDetailInfo.h"

@implementation GXEquitmentTool

+ (void)loadEquipmentListSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://lolbox.duowan.com/phone/apiZBCategory.php" parameters:nil success:^(NSArray *responseObject) {
        NSArray *result = [GXEquipmentTitle objectArrayWithKeyValuesArray:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadEquipmentDetailListWithTag:(NSString *)tag success:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/apiZBItemList.php?tag=%@", tag];
    
    // 2.发送GET请求
    [GXHttpTool GET:url parameters:@{@"Content-Type": @"application/json"} success:^(NSArray *responseObject) {
        NSArray *result = [GXEquipmentInfo objectArrayWithKeyValuesArray:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)loadEquipmentDetailInfoWithID:(NSString *)ID success:(void (^)(GXEquipmentDetailInfo *result))success failure:(void (^)(NSError *error))failure
{
    // 1.拼接URL
    NSString *url = [NSString stringWithFormat:@"http://lolbox.duowan.com/phone/apiItemDetail.php?id=%@", ID];
    
    // 2.发送GET请求
    [GXHttpTool GET:url parameters:@{@"Content-Type": @"application/json"} success:^(NSDictionary *responseObject) {
        if (responseObject) {
            GXEquipmentDetailInfo *result = [GXEquipmentDetailInfo objectWithKeyValues:responseObject];
            success(result);
        } else {
            success(nil);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

//
//  GXSkillsTool.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillsTool.h"
#import "GXSkillsInfo.h"
#import "GXHttpTool.h"
#import "MJExtension.h"

@implementation GXSkillsTool
+ (void)loadSkillsInfoSuccess:(void (^)(NSArray *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://lolbox.duowan.com/phone/apiSumAbility.php" parameters:nil success:^(NSArray *responseObject) {
        NSArray *result = [GXSkillsInfo objectArrayWithKeyValuesArray:responseObject];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

//
//  GXCharmTool.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXCharmTool.h"
#import "GXHttpTool.h"
#import "MJExtension.h"

@implementation GXCharmTool
+ (void)loadCharmInfoSuccess:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure
{
    [GXHttpTool GET:@"http://lolbox.duowan.com/phone/apiRunes.php" parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

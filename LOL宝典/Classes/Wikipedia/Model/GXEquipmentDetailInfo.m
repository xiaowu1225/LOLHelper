//
//  GXEquipmentDetailInfo.m
//  LOL宝典
//
//  Created by sgx on 14-8-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXEquipmentDetailInfo.h"
#import "GXEquitmentTool.h"

@implementation GXEquipmentDetailInfo

- (void)setId:(NSString *)id
{
    _id = id;
    self.icon = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", _id];
}

- (void)setNeed:(NSString *)need
{
    _need = need;
    if (_need.length != 0) {
        self.needEquitment = [NSMutableArray array];
        NSArray *needArray = [_need componentsSeparatedByString:@","];
        for (NSString *needStr in needArray) {
            [self.needEquitment addObject:needStr];
        }
    }
}

- (void)setCompose:(NSString *)compose
{
    _compose = compose;
    if (_compose.length != 0) {
        self.composeEquitment = [NSMutableArray array];
        NSArray *composeArray = [_compose componentsSeparatedByString:@","];
        for (NSString *composeStr in composeArray) {
            [self.composeEquitment addObject:composeStr];
        }
    }
}

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"descStr":@"description"};
}

@end

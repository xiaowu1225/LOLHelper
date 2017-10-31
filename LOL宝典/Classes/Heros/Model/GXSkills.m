//
//  GXSkills.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/9.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXSkills.h"

@implementation GXSkills
- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"descStr":@"description"};
}

- (NSString *)cost
{
    if (_cost && _cost.length > 0) {
        return _cost;
    } else {
        return @"无";
    }
}

- (NSString *)cooldown
{
    if (_cooldown && _cooldown.length > 0) {
        return _cooldown;
    } else {
        return @"无";
    }
}

- (NSString *)descStr
{
    if (_descStr && _descStr.length > 0) {
        return _descStr;
    } else {
        return @"无";
    }
}

- (NSString *)range
{
    if (_range && _range.length > 0) {
        return _range;
    } else {
        return @"无";
    }
}

- (NSString *)effect
{
    if (_effect && _effect.length > 0) {
        return _effect;
    } else {
        return @"无";
    }
}

@end

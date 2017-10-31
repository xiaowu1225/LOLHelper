//
//  GXVideoList.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoList.h"
#import "MJExtension.h"
#import "GXVideoTitle.h"

@implementation GXVideoList

- (NSDictionary *)objectClassInArray
{
    return @{@"children" : [GXVideoTitle class]};
}

@end

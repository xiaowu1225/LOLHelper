//
//  GXWuqi.m
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXWuqi.h"

@implementation GXWuqi

- (void)setId:(int)id
{
    _id = id;
    self.icon = [NSString stringWithFormat:@"wuqi%d", _id];
}

@end

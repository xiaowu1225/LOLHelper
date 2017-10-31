//
//  GXPeople.m
//  LOL宝典
//
//  Created by sgx on 14-8-7.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXPeople.h"

@implementation GXPeople

- (void)setId:(int)id
{
    _id = id;
    self.icon = [NSString stringWithFormat:@"hero%d", _id];
}

@end

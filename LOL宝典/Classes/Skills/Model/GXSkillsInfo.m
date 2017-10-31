//
//  GXSkillsInfo.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXSkillsInfo.h"

@implementation GXSkillsInfo

- (void)setId:(NSString *)id
{
    _id = id;
    self.icon = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/spells/png/%@.png", _id];
}

@end

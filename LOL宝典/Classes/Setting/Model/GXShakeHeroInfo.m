//
//  GXShakeHeroInfo.m
//  LOL宝典
//
//  Created by sgx on 14-8-14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXShakeHeroInfo.h"

@implementation GXShakeHeroInfo

- (void)setHeroName:(NSString *)heroName
{
    _heroName = heroName;
    
    self.img = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/champions/%@.jpg", _heroName];
}

@end

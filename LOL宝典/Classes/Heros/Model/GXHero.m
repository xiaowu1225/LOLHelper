//
//  GXHero.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHero.h"

@implementation GXHero

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}

- (void)setName:(NSString *)name
{
    _name = name;
    
    self.img = [NSString stringWithFormat:@"http://static.lolbox.duowan.com/images/champions/%@_120x120.jpg", _name];
}

@end

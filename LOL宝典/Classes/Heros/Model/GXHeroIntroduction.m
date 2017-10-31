//
//  GXHeroIntroduction.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXHeroIntroduction.h"

@implementation GXHeroIntroduction

- (void)setEn_name:(NSString *)en_name
{
    _en_name = en_name;
    
    self.img = [NSString stringWithFormat:@"http://static.lolbox.duowan.com/images/champions/%@_120x120.jpg", _en_name];
}

- (void)setSkill:(NSString *)skill
{
    _skill = skill;
    
    self.skills = [NSMutableArray array];
    NSArray *skillArray = [_skill componentsSeparatedByString:@","];
    for (NSString *skillStr in skillArray) {
        NSString *skillUrl = [NSString stringWithFormat:@"http://static.lolbox.duowan.com/images/pqwer/%@_%@_64x64.jpg", self.en_name, skillStr.lowercaseString];
        
        [self.skills addObject:skillUrl];
    }
}

- (void)setPre_cz:(NSString *)pre_cz
{
    _pre_cz = pre_cz;
    
    self.pre_equipment = [NSMutableArray array];
    NSArray *equipArray = [_pre_cz componentsSeparatedByString:@","];
    for (NSString *equipStr in equipArray) {
        NSString *equipUrl = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", equipStr];
        
        [self.pre_equipment addObject:equipUrl];
    }
}

- (void)setMid_cz:(NSString *)mid_cz
{
    _mid_cz = mid_cz;
    
    self.mid_equipment = [NSMutableArray array];
    NSArray *equipArray = [_mid_cz componentsSeparatedByString:@","];
    for (NSString *equipStr in equipArray) {
        NSString *equipUrl = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", equipStr];
        
        [self.mid_equipment addObject:equipUrl];
    }
}

- (void)setEnd_cz:(NSString *)end_cz
{
    _end_cz = end_cz;
    
    self.end_equipment = [NSMutableArray array];
    NSArray *equipArray = [_end_cz componentsSeparatedByString:@","];
    for (NSString *equipStr in equipArray) {
        NSString *equipUrl = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", equipStr];
        
        [self.end_equipment addObject:equipUrl];
    }
}

- (void)setNf_cz:(NSString *)nf_cz
{
    _nf_cz = nf_cz;
    
    self.nf_equipment = [NSMutableArray array];
    NSArray *equipArray = [_nf_cz componentsSeparatedByString:@","];
    for (NSString *equipStr in equipArray) {
        NSString *equipUrl = [NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%@_64x64.png", equipStr];
        
        [self.nf_equipment addObject:equipUrl];
    }
}

@end

//
//  GXVideoInfo.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoInfo.h"

@implementation GXVideoInfo

- (void)setId:(NSString *)id
{
    _id = id;
    self.url = [NSString stringWithFormat:@"http://www.xiushuang.com/client/index.php?s=/Portal/p_m3u8/id/%@/appinfo/comxiushuanglol_337_xs_android/index.json", _id];
}

@end

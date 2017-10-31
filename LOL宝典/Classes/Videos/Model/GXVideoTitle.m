//
//  GXVideoTitle.m
//  LOL宝典
//
//  Created by sgx on 14-8-11.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXVideoTitle.h"

@implementation GXVideoTitle

- (void)setId:(NSString *)id
{
    _id = id;
    
    self.url = [NSString stringWithFormat:@"http://www.xiushuang.com/client/index.php?s=/Portal/p_list/catid/%@/p/1/appinfo/comxiushuanglol_337_xs_android/index.json", _id];
}

@end

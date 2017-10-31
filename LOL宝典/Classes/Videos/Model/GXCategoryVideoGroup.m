//
//  GXCategoryVideoGroup.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXCategoryVideoGroup.h"
#import "GXCategoryVideoInfo.h"

@implementation GXCategoryVideoGroup
- (NSDictionary *)objectClassInArray
{
    return @{@"subCategory" : [GXCategoryVideoInfo class]};
}
@end

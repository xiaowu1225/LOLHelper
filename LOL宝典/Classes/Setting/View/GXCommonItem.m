//
//  GXCommonItem.m
//  新浪微博
//
//  Created by sgx on 14-7-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCommonItem.h"

@implementation GXCommonItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title subTitle:(NSString *)subTitle
{
    GXCommonItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    return [self itemWithIcon:icon title:title subTitle:nil];
}
+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}


@end

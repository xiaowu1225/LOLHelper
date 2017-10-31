//
//  GXCommonMarkGroup.m
//  新浪微博
//
//  Created by sgx on 14-7-23.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXCommonMarkGroup.h"
#import "GXCommonMarkItem.h"

@implementation GXCommonMarkGroup

- (void)setMarkIndex:(int)markIndex
{
    _markIndex = markIndex;
    
    int count = self.items.count;
    for (int i = 0; i < count; i ++) {
        GXCommonMarkItem *item = self.items[i];
        if (i == markIndex) {
            item.mark = YES;
        } else {
            item.mark = NO;
        }
    }
}

- (void)setItems:(NSArray *)items
{
    [super setItems:items];
    
    self.markIndex = self.markIndex;
}

@end

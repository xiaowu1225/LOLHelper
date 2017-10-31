//
//  GXButton.m
//  LOL宝典
//
//  Created by sgx on 14-8-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXButton.h"

@implementation GXButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.width;
    CGFloat titleH = self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}



@end

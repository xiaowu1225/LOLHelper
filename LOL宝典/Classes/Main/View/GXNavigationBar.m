//
//  GXNavigationBar.m
//  LOL宝典
//
//  Created by sgx on 14-8-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXNavigationBar.h"

@implementation GXNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIButton *button in self.subviews) {
        if (![button isKindOfClass:[UIButton class]]) continue;
        
        if (button.centerX < self.width * 0.5) { // 左边的按钮
            button.x = 0;
        } else if (button.centerX > self.width * 0.5) { // 右边的按钮
            button.x = self.width - button.width;
        }
    }
}

@end

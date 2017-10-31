//
//  GXShakeView.m
//  LOL宝典
//
//  Created by sgx on 14-8-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXShakeView.h"

@interface GXShakeView ()
- (IBAction)voiceClick:(UIButton *)sender;

- (IBAction)ShockClick:(UIButton *)sender;

- (IBAction)shakeBtnClick;



@end

@implementation GXShakeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)voiceClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(voiceBtnClick:)]) {
        [self.delegate voiceBtnClick:sender];
    }
}

- (IBAction)ShockClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(shockBtnClick:)]) {
        [self.delegate shockBtnClick:sender];
    }
}

- (IBAction)shakeBtnClick {
    if ([self.delegate respondsToSelector:@selector(shakeBtnClick)]) {
        [self.delegate shakeBtnClick];
    }
}

@end

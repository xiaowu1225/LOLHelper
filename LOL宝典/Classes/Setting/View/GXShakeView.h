//
//  GXShakeView.h
//  LOL宝典
//
//  Created by sgx on 14-8-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GXShakeViewDelegate <NSObject>

- (void)voiceBtnClick:(UIButton *)button;
- (void)shockBtnClick:(UIButton *)button;
- (void)shakeBtnClick;

@end

@interface GXShakeView : UIView

@property (nonatomic, assign) id<GXShakeViewDelegate> delegate;

@end

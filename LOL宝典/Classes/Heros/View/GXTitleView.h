//
//  GXTitleView.h
//  LOL宝典
//
//  Created by sgx on 14-8-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GXHeroIntroduction;

@protocol GXTitleViewDelegate <NSObject>

- (void)giftBtnDidClickWithHeroName:(NSString *)heroName;

@end

@interface GXTitleView : UIView

@property (nonatomic, strong) GXHeroIntroduction *introduction;

@property (nonatomic, assign) id<GXTitleViewDelegate> delegate;

@end

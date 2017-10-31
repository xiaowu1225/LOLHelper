//
//  GXVideoInfoView.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/12.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXVideoInfo.h"

@protocol GXVideoInfoViewDelegate <NSObject>

- (void)downloadBtnDidClick;

@end

@interface GXVideoInfoView : UIView
@property (nonatomic, strong) GXVideoInfo *videoInfo;
@property (nonatomic, weak) id<GXVideoInfoViewDelegate> delegate;
@end

//
//  GXVideoPlayController.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/8.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXVideoInfo.h"

@interface GXVideoPlayController : UIViewController
@property (nonatomic, copy)NSString * URLString;
@property (nonatomic, strong) GXVideoInfo *videoInfo;
@end

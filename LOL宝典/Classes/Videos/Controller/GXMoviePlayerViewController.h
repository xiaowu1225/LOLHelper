//
//  GXMoviePlayerViewController.h
//  LOL宝典
//
//  Created by siguoxi on 2017/3/31.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GXVideoInfo.h"

@interface GXMoviePlayerViewController : UIViewController
/** 视频URL */
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, strong) GXVideoInfo *videoInfo;
@end

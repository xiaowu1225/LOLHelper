//
//  GXAppDelegate.h
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface GXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 监控网络状况
 */
@property (nonatomic,strong) Reachability*hostReach;

@end

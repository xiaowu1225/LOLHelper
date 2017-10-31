//
//  GXLocalNoteTool.h
//  LOL宝典
//
//  Created by siguoxi on 16/7/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXLocalNoteTool : NSObject
+ (instancetype)localNoteTool;
// 设置本地通知
- (void)registerLocalNotification:(NSDate *)fireDate;
// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key;
@end

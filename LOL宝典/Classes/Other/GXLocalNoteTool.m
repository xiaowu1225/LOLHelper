//
//  GXLocalNoteTool.m
//  LOL宝典
//
//  Created by siguoxi on 16/7/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "GXLocalNoteTool.h"

@implementation GXLocalNoteTool

{
    UILocalNotification *_notification;
}

+ (instancetype)localNoteTool
{
    return [[self alloc] init];
}

// 设置本地通知
- (void)registerLocalNotification:(NSDate *)fireDate
{
    _notification = [[UILocalNotification alloc] init];
    
    _notification.fireDate = fireDate;
    // 时区
    _notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    _notification.repeatInterval = NSCalendarUnitDay;
    
    // 通知内容
    _notification.alertBody =  @"视频下载完成!";
    _notification.applicationIconBadgeNumber ++;
    // 通知被触发时播放的声音
    _notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"赶紧查看吧！😊" forKey:@"downLoadFinishNoteKey"];
    _notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        _notification.repeatInterval = NSCalendarUnitDay;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:_notification];
}

// 取消某个本地推送通知
- (void)cancelLocalNotificationWithKey:(NSString *)key
{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

@end

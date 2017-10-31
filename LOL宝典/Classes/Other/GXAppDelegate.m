//
//  GXAppDelegate.m
//  LOL宝典
//
//  Created by sgx on 14-8-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GXAppDelegate.h"
#import "GXTabBarController.h"
#import "GXLocalNoteTool.h"

@implementation GXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    // 2.显示窗口（成为主窗口）
    [self.window makeKeyAndVisible];
    
    // 3.设置窗口的根控制器
    GXTabBarController *tabVc = [[GXTabBarController alloc] init];
    self.window.rootViewController = tabVc;
    // 网络监听
    [self reachability];
    return YES;
}

#pragma mark - NetworkingStatus
/**
 开启网络监听
 */
-(void)reachability
{
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityForInternetConnection] ;
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
    [self updateInterfaceWithReachability:self.hostReach];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:currReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status == NotReachable)
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"networkStatus"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return;
    }else{
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"networkStatus"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"noti:%@",notification);
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    NSString *notMess = [notification.userInfo objectForKey:@"downLoadFinishNoteKey"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频下载完成!"
                                                    message:notMess
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
    
    // 在不需要再推送时，可以取消推送
    GXLocalNoteTool *noteTool = [GXLocalNoteTool localNoteTool];
    [noteTool cancelLocalNotificationWithKey:@"downLoadFinishNoteKey"];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

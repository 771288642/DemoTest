//
//  AppDelegate.m
//  Demo
//
//  Created by analysysmac-1 on 2018/7/30.
//  Copyright © 2018年 analysysmac-1. All rights reserved.
//

#import "AppDelegate.h"
#import <AnalysysAgent/AnalysysAgent.h>
#import "DemoView.h"

@interface AppDelegate ()

@property (nonatomic, strong) DemoView *demoView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AnalysysAgent startWithAppKey:@"paastest"
                           channel:@"App Store"
                           baseURL:@"arkpaastest.analysys.cn"
                       autoProfile:YES];
    
<<<<<<< HEAD
    //  防止SDK 未初始化完成，异常错误信息通知已发出，导致无法接收通知
    [NSThread sleepForTimeInterval:1.0];

=======
//    [AnalysysAgent setUploadURL:@"https://arkpaastest.analysys.cn:4089"];
//    [AnalysysAgent setVisitorDebugURL:@"wss://arkpaastest.analysys.cn:4091"];
//    [AnalysysAgent setVisitorConfigURL:@"https://arkpaastest.analysys.cn:4089"];
>>>>>>> 45d8f64d0bf5d1b008bcfd3d4c6c1643984967e5
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

/*
 ******************************************************************************
 * AppDelegate.m -
 *
 * Copyright (c) 2015-2016 by ZealTek Electronic Co., Ltd.
 *
 * This software is copyrighted by and is the property of ZealTek
 * Electronic Co., Ltd. All rights are reserved by ZealTek Electronic
 * Co., Ltd. This software may only be used in accordance with the
 * corresponding license agreement. Any unauthorized use, duplication,
 * distribution, or disclosure of this software is expressly forbidden.
 *
 * This Copyright notice MUST not be removed or modified without prior
 * written consent of ZealTek Electronic Co., Ltd.
 *
 * ZealTek Electronic Co., Ltd. reserves the right to modify this
 * software without notice.
 *
 * History:
 *	2015.01.16	T.C. Chiu	frist edition
 *
 ******************************************************************************
 */
#import "UIDeviceHardware/UIDeviceHardware.h"
#import "AppDelegate.h"


/*
 ******************************************************************************
 *
 * for debug
 *
 ******************************************************************************
 */
#define LOGGING_APP         1
#include "DbgMsg.h"

#if defined(LOGGING_APP) && LOGGING_APP
#define _dmsg(fmt, ...)     LOG_FORMAT(fmt, @"APP", ##__VA_ARGS__)
#else
#define _dmsg(...)
#endif


/*
 ******************************************************************************
 *
 * @interface
 *
 ******************************************************************************
 */
@interface AppDelegate ()

@end


/*
 ******************************************************************************
 *
 * @implementation
 *
 ******************************************************************************
 */
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _dmsg(@"application:didFinishLaunchingWithOptions:%@", launchOptions);
    _dmsg(@"\
          \n window bounds = %@\
          \n status bar    = %@\
          \n work space    = %@\
          \n window        = %@",
        NSStringFromCGRect(self.window.bounds),
        NSStringFromCGRect([[UIApplication sharedApplication]statusBarFrame]),
        NSStringFromCGRect([UIScreen mainScreen].applicationFrame),
        NSStringFromCGRect([[UIScreen mainScreen] bounds]));

    //取得當前狀態
    UIDevice *device = [UIDevice currentDevice];
    _dmsg(@"\n 唯一識別碼 : %@\
          \n 裝置名稱   : %@\
          \n 系統名稱   : %@\
          \n 系統版本   : %@\
          \n 使用模組   : %@\
          \n 區域模組   : %@",
          [[device identifierForVendor] UUIDString],
          [device name],
          [device systemName],
          [device systemVersion],
          [device model],
          [device localizedModel]);

    _dmsg(@"\n 裝置名稱   : %@", [[[UIDeviceHardware alloc] init] platformString]);

    sleep(1);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

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

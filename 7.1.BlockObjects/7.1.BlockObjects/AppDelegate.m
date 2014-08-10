//
//  AppDelegate.m
//  7.1.BlockObjects
//
//  Created by artwalk on 8/10/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

// c style


@implementation AppDelegate

#pragma mark -
// obj-c style
- (NSInteger)subtract:(NSInteger)paramValue from:(NSInteger)paramFrom {
    return paramFrom - paramValue;
}

// c style
NSInteger subtract(NSInteger paramValue, NSInteger paramFrom) {
    return paramFrom - paramValue;
}

// block style
NSInteger (^substract)(NSInteger, NSInteger) = ^(NSInteger paramValue, NSInteger paramFrom) {
    return paramFrom - paramValue;
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSInteger num = [self subtract:10 from:20];
    NSLog(@"%d", num);
    num = subtract(100, 200);
    NSLog(@"%d", num);
    
    num = 
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
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

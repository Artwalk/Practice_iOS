//
//  AppDelegate.m
//  14.2.Files
//
//  Created by artwalk on 8/18/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSArray *urls = [fm URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    
    for (NSString* url in urls) {
        NSLog(@"%@", url);
    }
    
    
    NSString *someText = @"someText";
    NSString *dPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MyFile.txt"];
    BOOL succeeded = [someText writeToFile:dPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *array = @[@"aaa", @"bbb", @"ccc"];
    [array writeToFile:dPath atomically:YES];
    
    NSLog(@"%@", [[NSArray alloc] initWithContentsOfFile:dPath]);
    
    NSString *imgDir = [NSTemporaryDirectory() stringByAppendingPathComponent:@"images/"];
    
    [fm createDirectoryAtPath:imgDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *bundleDir = [[NSBundle mainBundle] bundlePath];
    
    array = [fm contentsOfDirectoryAtPath:bundleDir error:nil];
    NSLog(@"%@", array);
    
    [fm removeItemAtPath:imgDir error:nil];
    
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

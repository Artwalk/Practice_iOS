//
//  AppDelegate.m
//  7.10.Construction Your Own Dispatch Queues with GCD
//
//  Created by artwalk on 8/11/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

void iterations(void *paramContext) {
    int i = (int)paramContext;
        NSUInteger counter = 0;
        for (counter = 0; counter < 5; counter++) {
            NSLog(@"%d, %lu",i, (unsigned long)counter);
        }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    dispatch_queue_t firstSerialQueue = dispatch_queue_create("1.io.artwalk.www", 0);
    /*
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0; counter < 5; counter++) {
            NSLog(@"111 %lu", (unsigned long)counter);
        }
    });
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0; counter < 5; counter++) {
            NSLog(@"222 %lu", (unsigned long)counter);
        }
    });
    dispatch_async(firstSerialQueue, ^{
        NSUInteger counter = 0;
        for (counter = 0; counter < 5; counter++) {
            NSLog(@"333 %lu", (unsigned long)counter);
        }
    });
    */
    
    dispatch_sync_f(firstSerialQueue, (void *)1, iterations);
    dispatch_sync_f(firstSerialQueue, (void *)2, iterations);
    dispatch_sync_f(firstSerialQueue, (void *)3, iterations);
    
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

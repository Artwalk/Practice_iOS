//
//  AppDelegate.m
//  7.16.Invoking Background Methods
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)counter:(int)index {
    @autoreleasepool {
        NSUInteger i;
        for (i = 0; i < 10; ++i) {
            NSLog(@"%d  ---> %lu",index, (unsigned long)i);
        }
        
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *filePath = [mainBundle pathForResource:@"MacBook Pro" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        NSLog(@"%@", image);
    }
}

- (void)firstCounter {
    [self counter:1];
}

- (void)secondCounter {
    [self counter:2];
}

- (void)thirdCounter {
    [self counter:3];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self performSelectorInBackground:@selector(firstCounter) withObject:nil];
    [self performSelectorInBackground:@selector(secondCounter) withObject:nil];
    [self performSelectorInBackground:@selector(thirdCounter) withObject:nil];
    
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

//
//  AppDelegate.m
//  7.7.PerformingTasksAfterADelayWithGCD
//
//  Created by artwalk on 8/11/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

static dispatch_once_t onceToken;

void (^executeOnlyOnce)(void) = ^{
    static NSUInteger numberOfEntries = 0;
    numberOfEntries++;
    NSLog(@"%lu", (unsigned long)numberOfEntries);
};

- (void)printString:(NSString *)paramString {
    NSLog(@"%@", paramString);
}

void processSomething(void *paramContext) {
    NSLog(@"hehe");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
//    [self performSelector:@selector(printString:) withObject:@"Grand Central Dispatch" afterDelay:3.0];
    double delayInSeconds = 2.0;
    
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    /*
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^{
        NSLog(@"hehe");
    });
    */
    
//    dispatch_after_f(delayInNanoSeconds, concurrentQueue, NULL, processSomething);
    

    dispatch_once(&onceToken, ^{
        dispatch_async(concurrentQueue, executeOnlyOnce);
    });
    dispatch_once(&onceToken, ^{
        dispatch_async(concurrentQueue, executeOnlyOnce);
    });
    
    
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

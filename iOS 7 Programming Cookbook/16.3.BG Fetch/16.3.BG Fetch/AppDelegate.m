//
//  AppDelegate.m
//  16.3.BG Fetch
//
//  Created by artwalk on 8/20/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"
#import "NewsItem.h"

@implementation AppDelegate

- (NSMutableArray *)allNewsItems {
    if (_allNewsItems == nil) {
        _allNewsItems = [[NSMutableArray alloc] init];
        
        NewsItem *item = [[NewsItem alloc] init];
        item.date = [NSDate date];
        item.text = [NSString stringWithFormat:@"News text 1"];
        
        [_allNewsItems addObject:item];
    }
    
    return _allNewsItems;
}

- (void)fetchNewsItems:(BOOL *)fetchNewItems {
    if (arc4random_uniform(2) != 1) {
        if (fetchNewItems != nil) {
            *fetchNewItems = NO;
        }
        return;
    }
    
    [self willChangeValueForKey:@"allNewsItems"];
    
    NewsItem *item = [[NewsItem alloc] init];
    item.date = [NSDate date];
    item.text = [NSString stringWithFormat:@"News text %lu", (unsigned long)self.allNewsItems.count + 1];
    [self.allNewsItems addObject:item];
    
    if (fetchNewItems != nil) {
        *fetchNewItems = YES;
    }
    
    [self didChangeValueForKey:@"allNewsItems"];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    BOOL haveNewContent = NO;
    [self fetchNewsItems:&haveNewContent];
    
    if (haveNewContent) {
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
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

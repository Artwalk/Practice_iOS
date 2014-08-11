//
//  AppDelegate.m
//  7.1.BlockObjects
//
//  Created by artwalk on 8/10/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

typedef NSString* (^IntToStringConverter)(NSUInteger paramInterger);

@implementation AppDelegate

#pragma mark -
// obj-c style
- (NSInteger)subtract:(NSInteger)paramValue from:(NSInteger)paramFrom {
    return paramFrom - paramValue;
}

- (NSString *)intToString:(NSUInteger)paramInterger {
    return [NSString stringWithFormat:@"%lu", (unsigned long) paramInterger];
}

// c style
/*
NSInteger subtract(NSInteger paramValue, NSInteger paramFrom) {
    return paramFrom - paramValue;
}

NSString * intToString(NSUInteger paramInterger) {
    return [NSString stringWithFormat:@"%lu", (unsigned long) paramInterger];
}
*/

// block style
NSInteger (^subtract)(NSInteger, NSInteger) = ^(NSInteger paramValue, NSInteger paramFrom) {
    return paramFrom - paramValue;
};

NSString* (^intToString)(NSUInteger) = ^(NSUInteger paramInterger) {
    NSString *result = [NSString stringWithFormat:@"%lu", (unsigned long) paramInterger];
    
    return result;
};

- (NSString *)converIntToString:(NSUInteger)paramInterger usingBlockObject:(IntToStringConverter)paramBlockObject {
    return paramBlockObject(paramInterger);
}

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSInteger num = [self subtract:0 from:0];
    NSLog(@"obj-c: %d %@", num, [self intToString:num]);
    
    num = subtract(0, 0);
    NSLog(@"using block: %d %@", num, intToString(num));
    
    IntToStringConverter inlineConverter = ^(NSUInteger paramInterger) {
        NSString *result = [NSString stringWithFormat:@"%lu", (unsigned long) paramInterger];
        return result;
    };
    NSLog(@"%@", [self converIntToString:12 usingBlockObject:inlineConverter]);
    
    NSLog(@"%@", [self converIntToString:123 usingBlockObject:^NSString *(NSUInteger paramInterger) {
        NSString *result = [NSString stringWithFormat:@"%lu", (unsigned long) paramInterger];
        return result;
    }]);
    
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

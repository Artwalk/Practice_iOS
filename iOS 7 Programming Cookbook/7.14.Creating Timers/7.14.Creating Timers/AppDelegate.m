//
//  AppDelegate.m
//  7.14.Creating Timers
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSTimer *paintingTimer;
@end

@implementation AppDelegate

- (void)paint:(NSTimer *)paramTimer {
    NSLog(@"%@", paramTimer);
}

- (void)startPainting {
//    self.paintingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(paint:) userInfo:nil repeats:YES];
    SEL selectorToCall = @selector(paint:);
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:selectorToCall];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setTarget:self];
    [invocation setSelector:selectorToCall];
    
    self.paintingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 invocation:invocation repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.paintingTimer forMode:NSDefaultRunLoopMode];
}

- (void)stopPainting {
    if (self.paintingTimer != nil) {
        [self.paintingTimer invalidate];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
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
    [self stopPainting];
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
    [self startPainting];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

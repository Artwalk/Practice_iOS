//
//  AppDelegate.m
//  21.Core Motion
//
//  Created by artwalk on 8/28/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate ()

@property (nonatomic, strong) CMMotionManager *mm;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    application.applicationSupportsShakeToEdit = YES;
    
    self.mm = [[CMMotionManager alloc] init];
    
    if ([self.mm isAccelerometerAvailable]) {
        NSLog(@"available");
//        NSOperationQueue *q = [[NSOperationQueue alloc] init];
//        self.mm.accelerometerUpdateInterval = .1;
//        [self.mm startAccelerometerUpdatesToQueue:q withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//            if (error == nil) {
//                NSLog(@"%.4f %.4f %.4f", accelerometerData.acceleration.x, accelerometerData.acceleration.y,accelerometerData.acceleration.z);
//            } else {
//                NSLog(@"%@", error);
//            }
//        }];
        
    } else {
        NSLog(@"not availabel");
    }
    
    if ([self.mm isAccelerometerActive]) {
        NSLog(@"active");
    } else {
        NSLog(@"not active");
    }
    
    if ([self.mm isGyroAvailable]) {
        NSLog(@"gyro");
        if ([self.mm isGyroActive]) {
            NSLog(@"gyro active");
        } else {
            NSLog(@"not active");
            [self.mm setGyroUpdateInterval:0.1];
            NSOperationQueue *q = [[NSOperationQueue alloc] init];
            [self.mm startGyroUpdatesToQueue:q withHandler:^(CMGyroData *gyroData, NSError *error) {
                NSLog(@"%.4f %.4f %.4f", gyroData.rotationRate.x, gyroData.rotationRate.y,gyroData.rotationRate.z);
            }];
            
        }
    } else {
        NSLog(@"no gyro");
    }
    
    
    
    
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

//
//  AppDelegate.m
//  16.4.Playing Audio in BG
//
//  Created by artwalk on 8/20/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *aPlayer;

@end

@implementation AppDelegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        [player play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if ([player isEqual:self.aPlayer]) {
        self.aPlayer = nil;
    } else {
        ;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    dispatch_queue_t dQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dQueue, ^{
        NSError *aSessionErr = nil;
        AVAudioSession *aSession = [AVAudioSession sharedInstance];
        
        [aSession setActive:YES error:nil];
        
        if ([aSession setCategory:AVAudioSessionCategoryPlayback error:&aSessionErr]) {
            NSLog(@"session success!");
        } else {
            NSLog(@"session faild!");
        }
        
        NSString *fPath = [NSString stringWithFormat:@"%@/%@", NSTemporaryDirectory(), @"16 步云登仙.m4a"];
        NSData *fData = [NSData dataWithContentsOfFile:fPath];
        
        NSError *err = nil;
        
        self.aPlayer = [[AVAudioPlayer alloc] initWithData:fData error:&err];
        
        if (self.aPlayer != nil) {
            self.aPlayer.delegate = self;
            
            if ([self.aPlayer prepareToPlay] && [self.aPlayer play]) {
                NSLog(@"playing...");
            } else {
                NSLog(@"faild to play");
            }
        } else {
            ;
        }
        
    });
    
    
    
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

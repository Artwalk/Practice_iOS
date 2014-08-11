//
//  AppDelegate.m
//  7.4.Performing UI-Related Tasks with GCD
//
//  Created by artwalk on 8/11/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"



@implementation AppDelegate

typedef struct {
    char *title;
    char *message;
    char *cancelButtonTitle;
} AlertViewData;

void displayAlertView (void *paramContext) {
    
    sleep(5);
    AlertViewData *alertData = (AlertViewData *)paramContext;
    
    NSString *title = charToNSString(alertData->title);
    NSString *message = charToNSString(alertData->message);
    NSString *cancelButtonTitle = charToNSString(alertData->cancelButtonTitle);
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil] show];
    
    free(paramContext);
}

NSString* charToNSString (char *s) {
    return [NSString stringWithUTF8String:s];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    /*
    dispatch_async(mainQueue, ^{
        [[[UIAlertView alloc] initWithTitle:@"GCD" message:@"GCD is amazing!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    });
    */
    
    AlertViewData *context = (AlertViewData *)malloc(sizeof(AlertViewData));
    
    if (context != NULL) {
        context->title = "GDC";
        context->message = "C is amazing";
        context->cancelButtonTitle = "OK";
        
        dispatch_async_f(mainQueue, (void *)context, displayAlertView);
        
        NSLog(@"Cur thread == %@", [NSThread currentThread]);
        NSLog(@"Main thread == %@", [NSThread mainThread]);
    }
    
    NSLog(@"Cur thread == %@", [NSThread currentThread]); 
    
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

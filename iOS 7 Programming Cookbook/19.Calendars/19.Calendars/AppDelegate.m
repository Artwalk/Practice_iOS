//
//  AppDelegate.m
//  19.Calendars
//
//  Created by artwalk on 8/24/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@implementation AppDelegate

- (void)displayMessage:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)displayAccessDenied {
    [self displayMessage:@" ---> Denied"];
}

- (void)displayAccessRestricted {
    [self displayMessage:@" ---> Restricted"];
}

- (void)extractEventEntityCalendarsOutOfStore:(EKEventStore *)store {
    NSArray *calTypes = @[
                          @"Local",
                          @"CalDAV",
                          @"Exchange",
                          @"Subscription",
                          @"Birthday",
                          ];
    NSArray *calendars = [store calendarsForEntityType:EKEntityTypeEvent];
    
    int i = 1;
    for (EKCalendar *cal in calendars) {
        NSLog(@"%d --- %@ --- %@ --- %@ --- can%@ modified",i,  cal.title, calTypes[cal.type], [UIColor colorWithCGColor:cal.CGColor], [cal allowsContentModifications]?@"":@"'t");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            [self extractEventEntityCalendarsOutOfStore:eventStore];
            break;
        case EKAuthorizationStatusDenied:
            [self displayAccessDenied];
            break;
        case EKAuthorizationStatusNotDetermined: {
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if (granted) {
                    [self extractEventEntityCalendarsOutOfStore:eventStore];
                } else {
                    [self displayAccessDenied];
                }
            }];
            break;
        }
            
        case EKAuthorizationStatusRestricted:
            [self displayAccessRestricted];
            break;
            
        default:
            break;
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

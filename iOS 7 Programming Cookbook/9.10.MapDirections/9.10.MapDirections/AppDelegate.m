//
//  AppDelegate.m
//  9.10.MapDirections
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSString *destination = @"浙江省 杭州市 西湖区 桂花城";
    
    [[CLGeocoder new] geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil) {
            NSLog(@"error ---> %@", error);
            return ;
        }
        for (CLPlacemark *placemark in placemarks) {
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];

            request.source = [MKMapItem mapItemForCurrentLocation];
            
            CLLocationCoordinate2D destinationCoordinate = placemark.location.coordinate;
            MKPlacemark *destination = [[MKPlacemark alloc] initWithCoordinate:destinationCoordinate addressDictionary:nil];
            request.destination = [[MKMapItem alloc] initWithPlacemark:destination];
            request.transportType = MKDirectionsTransportTypeAny;
            MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
            
            
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error != nil) {
                    NSLog(@"error ---> %@", error);
                    return ;
                }
                [MKMapItem openMapsWithItems:@[response.source, response.destination] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving}];
            }];
        }
    }];
    
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

//
//  ViewController.m
//  9.8.Longitude Latitude VS. Meaningful Address
//
//  Created by artwalk on 8/15/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (nonatomic, strong) CLGeocoder *myGeocoder;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSString *address = @"1005 Gravenstein Highway North, Sebastopol, CA 95472, USA";
    
//    [self location2Address:location];
    
    self.myMapView.userTrackingMode = MKUserTrackingModeFollow;
}


- (void)address2Location:(NSString *)address {
    self.myGeocoder = [[CLGeocoder alloc] init];
    [self.myGeocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count > 0 && error == nil){
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"%f, %f", placemark.location.coordinate.longitude, placemark.location.coordinate.latitude);
                //                [self location2Address:placemark.location];
            }
        } else if (placemarks.count == 0 && error == nil){
            NSLog(@"Found no placemarks.");
        } else if (error != nil){
            NSLog(@"An error occurred = %@", error);
        }
    }];
 
}

-(void)location2Address:(CLLocation *)location {
    self.myGeocoder = [[CLGeocoder alloc] init];
    
    [self.myGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && placemarks.count > 0) {
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"%@", placemark);
            }
        } else if (error == nil && placemarks.count == 0) {
            NSLog(@"NO results");
        } else if (error != nil) {
            NSLog(@"error: %@", error);
        }
    }];
    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"restaurants";
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    request.region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (MKMapItem *item in response.mapItems) {
            NSLog(@"%@", item);
        }
    }];
    
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"art --- > %s", __FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

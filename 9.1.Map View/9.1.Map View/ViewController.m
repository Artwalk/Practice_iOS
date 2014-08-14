//
//  ViewController.m
//  9.1.Map View
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"
#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) CLLocationManager *myLocationManager;

@end

@implementation ViewController

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    for (CLLocation *location in locations) {
        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:location.coordinate title:@"Art" subTitle:@"Walk"];
        [self.myMapView addAnnotation:annotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *result = nil;
    
    if ([annotation isKindOfClass:[MyAnnotation class]] == NO) {
        return result;
    }
    
    if ([mapView isEqual:self.myMapView] == NO) {
        return result;
    }
    
    MyAnnotation *senderAnnotation = (MyAnnotation *)annotation;
    NSString *pinReusableIdentifier = [MyAnnotation reusableIdentifierforPinColor:senderAnnotation.pinColor];
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinReusableIdentifier];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinReusableIdentifier];
        [annotationView setCanShowCallout:YES];
    }
    
    annotationView.pinColor = senderAnnotation.pinColor;
    
    
    UIImage *pinImage = [UIImage imageNamed:@"pin"];
    if (pinImage != nil) {
        annotationView.image = pinImage;
    }
    
    result = annotationView;
    return result;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([CLLocationManager locationServicesEnabled]) {
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        
        [self.myLocationManager startUpdatingLocation];
    } else {
        NSLog(@"hehe");
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

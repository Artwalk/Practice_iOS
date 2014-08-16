//
//  MyAnnotation.h
//  9.1.Map View
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

extern NSString *const kReusablePinRed;
extern NSString *const kReusablePinGreen;
extern NSString *const kReusablePinPurple;

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, unsafe_unretained, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *subtitle;

@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle;


+ (NSString *)reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor;

@end

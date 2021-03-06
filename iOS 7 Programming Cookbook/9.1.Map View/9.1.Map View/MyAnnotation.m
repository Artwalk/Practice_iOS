//
//  MyAnnotation.m
//  9.1.Map View
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "MyAnnotation.h"


NSString *const kReusablePinRed = @"Red";
NSString *const kReusablePinGreen = @"Green";
NSString *const kReusablePinPurple = @"Purple";

@implementation MyAnnotation

+ (NSString *)reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor {
    NSString *result = nil;
    
    switch (paramColor) {
        case MKPinAnnotationColorRed:
            result = kReusablePinRed;
            break;
        case MKPinAnnotationColorGreen:
            result = kReusablePinGreen;
            break;
        case MKPinAnnotationColorPurple:
            result = kReusablePinPurple;
            break;
            
        default:
            break;
    }
    
    return result;
}

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle {
    self = [super init];
    if (self != nil) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
        _pinColor = MKPinAnnotationColorGreen;
    }
    
    return self;
}

@end

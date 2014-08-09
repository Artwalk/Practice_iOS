//
//  ARTViewController.h
//  Compass
//
//  Created by artwalk on 6/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ARTViewController : UIViewController <CLLocationManagerDelegate> {
    IBOutlet UIImageView *arrow;
    IBOutlet UILabel *angel;
    CLLocationManager *locManager;
}

@property (retain) CLLocationManager *locManager;
@property (retain,nonatomic)IBOutlet UILabel *angel;

@end

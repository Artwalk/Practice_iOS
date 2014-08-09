//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by artwalk on 6/10/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRColorDescription.h"

@interface BNRColorViewController : UIViewController <UIViewControllerRestoration>

@property (nonatomic) BOOL existingColor;
@property (nonatomic) BNRColorDescription *colorDescription;

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UISlider *redSlider;

@property (weak, nonatomic) IBOutlet UISlider *greenSlider;

@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

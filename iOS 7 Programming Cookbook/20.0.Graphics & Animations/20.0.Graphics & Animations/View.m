//
//  View.m
//  20.0.Graphics & Animations
//
//  Created by artwalk on 8/27/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "View.h"

@implementation View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)enumerateFonts {
    for (NSString *fName in [UIFont familyNames]) {
        NSLog(@"Font Family --> %@", fName);
        for (NSString *font in [UIFont fontNamesForFamilyName:fName]) {
            NSLog(@"\t%@", font);
        }
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    [self enumerateFonts];
    UIColor *color = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0];
    [color set];
    CGColorRef cRef = color.CGColor;
    const CGFloat *comp = CGColorGetComponents(cRef);
    NSUInteger compCount = CGColorGetNumberOfComponents(cRef);
    for (int i = 0; i < compCount; ++i) {
        NSLog(@"%d --> %f", i, comp[i]);
    }
    
    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
    
    NSString *s = @"Artwalk";
    
//    [s drawAtPoint:CGPointMake(25, 190) withAttributes:@{NSFontAttributeName:helveticaBold}];
    [s drawWithRect:CGRectMake(100, 50, 50, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: helveticaBold} context:nil];
    
    UIImage *img = [UIImage imageNamed:@"screen"];
    [img drawAtPoint:CGPointMake(0.0f, 120.0f)];
    [img drawInRect:CGRectMake(50.0f, 10.0f, 40.0f,  35.0f)];
    
    
}


@end

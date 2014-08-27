//
//  view.m
//  20.10.Gradients
//
//  Created by artwalk on 8/27/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "view.h"

@implementation view

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    UIColor *startColor = [UIColor redColor];
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents([startColor CGColor]);
    
    UIColor *endColor = [UIColor blueColor];
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    CGFloat colorComponents[8] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3],
    };
    
    CGFloat colorIndices[2] = {
        0, 1,
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&colorComponents, (const CGFloat *)&colorIndices, 2);
    
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint, endPoint;
    startPoint = CGPointMake(0, 0);
    endPoint = CGPointMake(0, 576);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);//kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(context);
    
    
}


@end

//
//  view.m
//  20.7.ConstructingPaths
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
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    CGPathMoveToPoint(path, NULL, screenBounds.origin.x, screenBounds.origin.y);
    CGPathAddLineToPoint(path, NULL, screenBounds.size.width, screenBounds.size.height);
    
    CGPathMoveToPoint(path, NULL, screenBounds.size.width, screenBounds.origin.y);
    CGPathAddLineToPoint(path, NULL, screenBounds.origin.x, screenBounds.size.height);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(ref, path);
    
    [[UIColor blueColor] setStroke];
    
    CGContextDrawPath(ref, kCGPathStroke);
    CGPathRelease(path);
    
    
    path = CGPathCreateMutable();
    // rectangle
    CGRect rec1 = CGRectMake(10, 30, 200, 300);
    CGRect rec2 = CGRectMake(40, 100, 90, 300);
    
    CGRect recs[2] = {rec1, rec2};
    
    CGPathAddRects(path, NULL, recs, 2);
    
    ref = UIGraphicsGetCurrentContext();
    CGContextAddPath(ref, path);
    
    [[UIColor colorWithRed:0.2 green:0.6 blue:0.8 alpha:1] setFill];
    
    [[UIColor brownColor] setStroke];
    CGContextSetLineWidth(ref, 5);
    CGContextDrawPath(ref, kCGPathFillStroke);
    
    CGPathRelease(path);
}


@end

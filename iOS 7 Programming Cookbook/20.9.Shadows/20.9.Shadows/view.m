//
//  view.m
//  20.9.Shadows
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

- (void)drawRectAtTopOfScreen {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ref);
    
    CGContextSetShadowWithColor(ref, CGSizeMake(10, 10), 20, [[UIColor grayColor] CGColor]);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rect1 = CGRectMake(55, 60, 150, 150);
    
    CGPathAddRect(path, NULL, rect1);
    
    CGContextAddPath(ref, path);
    
    [[UIColor blueColor] setFill];
    
    CGContextDrawPath(ref, kCGPathFill);
    
    CGPathRelease(path);
    
    CGContextRestoreGState(ref);
}

- (void)drawRectAtBottomOfScreen {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ref);

    CGMutablePathRef path = CGPathCreateMutable();
    
    CGRect rect1 = CGRectMake(155, 255, 100, 100);
    
    CGPathAddRect(path, NULL, rect1);
    
    CGContextAddPath(ref, path);
    
    [[UIColor purpleColor] setFill];
    
    CGContextDrawPath(ref, kCGPathFill);
    
    CGPathRelease(path);
    
    
    CGContextRestoreGState(ref);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self drawRectAtTopOfScreen];
    [self drawRectAtBottomOfScreen];
}


@end

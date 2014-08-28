//
//  view.m
//  20.11.Moving Shapes
//
//  Created by artwalk on 8/28/14.
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
    
    CGRect rectangle = CGRectMake(10, 30, 200, 300);
    
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(100, 0);
//    CGPathAddRect(path, &transform, rectangle);
    CGPathAddRect(path, NULL, rectangle);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 100, 0);
    CGContextScaleCTM(context, 0.5, 0.5);
    
    CGContextAddPath(context, path);
    
    [[UIColor blueColor] setFill];
    
    [[UIColor redColor] setStroke];
    CGContextSetLineWidth(context, 5.0f);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGPathRelease(path);
    
    CGContextRestoreGState(context);
}


@end

//
//  view.m
//  20.6.Drawing Lines
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
    [self drawRooftopAtTopPointf:CGPointMake(160.0f, 40.0f) textToDispaly:@"Miter" lineJoin:kCGLineJoinMiter];
    [self drawRooftopAtTopPointf:CGPointMake(160.0f, 180.0f) textToDispaly:@"Bevel" lineJoin:kCGLineJoinBevel];
    [self drawRooftopAtTopPointf:CGPointMake(160.0f, 320.0f) textToDispaly:@"Round" lineJoin:kCGLineJoinRound];
    
}

- (void)drawRooftopAtTopPointf:(CGPoint)topPoint textToDispaly:(NSString *)text lineJoin:(CGLineJoin)lineJoin {
    [[UIColor cyanColor] set];
    
    CGContextRef curRef = UIGraphicsGetCurrentContext();
    
    CGContextSetLineJoin(curRef, lineJoin);
    
    CGContextSetLineWidth(curRef, 20);
    
    CGContextMoveToPoint(curRef, topPoint.x - 140, topPoint.y + 100);
    CGContextAddLineToPoint(curRef, topPoint.x - 0, topPoint.y + 0);
    CGContextAddLineToPoint(curRef, topPoint.x + 140, topPoint.y + 100);
    CGContextAddLineToPoint(curRef, topPoint.x - 140, topPoint.y + 100);
    CGContextAddLineToPoint(curRef, topPoint.x - 0, topPoint.y + 0);
    
    CGContextStrokePath(curRef);
    
    CGPoint point = CGPointMake(topPoint.x - 40, topPoint.y + 60);
    UIFont *f = [UIFont boldSystemFontOfSize:30.0f];
    
    [text drawAtPoint:point withAttributes:@{NSFontAttributeName: f}];
}

@end

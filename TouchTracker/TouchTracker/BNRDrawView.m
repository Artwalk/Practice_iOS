//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by artwalk on 6/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

//@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) UIGestureRecognizer *tapRecognizer;

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;


@property (nonatomic, weak) BNRLine *selectedLine;

@property (nonatomic) BOOL taped;
@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        
        [self addGestureRecognizer:doubleTapRecognizer];
        
        self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        self.tapRecognizer.delaysTouchesBegan = YES;
        [self.tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:self.tapRecognizer];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPressGestureRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
//        [self.moveRecognizer requireGestureRecognizerToFail:self.tapRecognizer];
        [self addGestureRecognizer:self.moveRecognizer];
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect");
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }
    
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
    //    if (self.currentLine) {
    //        [[UIColor redColor] set];
    //        [self strokeLine:self.currentLine];
    //    }
    
//    [self fuckCPU];
}

- (void)fuckCPU {
    float f = 0.0;
    for (int i = 0; i < 1000000; i++) {
        f = f + sin(sin(sin(time(NULL) + i)));
    }
    NSLog(@"f = %f", f);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}

- (int)numberOfLines {
    int count = 0;
    
    if (self.linesInProgress && self.finishedLines) {
        count = [self.linesInProgress count] + [self.finishedLines count];
        
    }
    
    return count;
}

#pragma mark - taps

- (void)moveLine:(UIPanGestureRecognizer *)gr {
    NSLog(@"%d", self.taped);
    if (!self.selectedLine || self.taped) {
        return;
    }
    
    if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        
        //
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        
        [self setNeedsDisplay];
        
        [gr setTranslation:CGPointZero inView:self];
    }
}


- (void)longPress:(UIGestureRecognizer *)gr {
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine  = [self lineAtPoint:point];
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognized tap");
    
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        //
        [self becomeFirstResponder];
        
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        //
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        //
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
        self.taped = YES;
    } else {
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
        self.taped = NO;
    }
    
    [self setNeedsDisplay];
}

- (void)doubleTap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognized Double Tap");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark - lines

- (void)deleteLine:(id)sender {
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
    
    self.taped = NO;
}
- (BNRLine *)lineAtPoint:(CGPoint)p {
    for (BNRLine *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        for (float t = 0.0;t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            if (hypot(x-p.x, y-p.y) < 20.0) {
                return l;
            }
        }
    }
    return nil;
}

- (void)strokeLine:(BNRLine *)line{
//    NSLog(@"strokeLine");
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    
//    self.currentLine = [[BNRLine alloc] init];
//    self.currentLine.begin = location;
//    self.currentLine.end = location;

    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    
        for (UITouch *t in touches) {
            CGPoint location = [t locationInView:self];
            
            BNRLine *line = [[BNRLine alloc] init];
            line.begin = location;
            line.end = location;
            
            NSValue *key = [NSValue valueWithNonretainedObject:t];
            self.linesInProgress[key] = line;
        }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    
//    self.currentLine.end = location;

    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [t locationInView:self];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.finishedLines addObject:self.currentLine];
//    
//    self.currentLine = nil;

    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        if (!self.taped) {
            
            [self.finishedLines addObject:line];
        }
        
        [self.linesInProgress removeObjectForKey:key];
        
        line.containingArray = self.finishedLines;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

@end

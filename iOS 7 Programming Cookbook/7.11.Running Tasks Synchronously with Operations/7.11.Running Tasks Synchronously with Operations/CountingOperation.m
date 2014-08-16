//
//  CountingOperation.m
//  7.11.Running Tasks Synchronously with Operations
//
//  Created by artwalk on 8/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "CountingOperation.h"

@interface CountingOperation ()

@property (nonatomic, unsafe_unretained) NSUInteger startingCount;
@property (nonatomic, unsafe_unretained) NSUInteger endingCount;
@property (nonatomic, unsafe_unretained, getter=isFinished) BOOL finished;
@property (nonatomic, unsafe_unretained, getter=isExecuting) BOOL executing;

@end

@implementation CountingOperation

- (instancetype) init {
    return [self initWithStartingCount:0 endingCount:1000];
}

- (instancetype) initWithStartingCount:(NSUInteger)paramStartingCount endingCount:(NSUInteger)paramEndingCount {
    self = [super init];
    
    if (self != nil) {
        _startingCount = paramStartingCount;
        _endingCount = paramEndingCount;
    }
    
    return(self);
}

- (void)main {
    @try {
        @autoreleasepool {
            BOOL taskIsFinished = NO;
            
            while (taskIsFinished == NO && [self isCancelled] == NO) {
                NSLog(@"Main Thread = %@", [NSThread mainThread]);
                NSLog(@"Current Thread = %@", [NSThread currentThread]);
                for (NSUInteger i = _startingCount; i < _endingCount; ++i) {
                    NSLog(@"Count = %lu", (unsigned long)i);
                }
                taskIsFinished = YES;
            }
            
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            _finished = YES;
            _executing = NO;
            [self didChangeValueForKey:@"isFinished"];
            [self didChangeValueForKey:@"isExecuting"];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
    @finally {
        
    }
}
@end
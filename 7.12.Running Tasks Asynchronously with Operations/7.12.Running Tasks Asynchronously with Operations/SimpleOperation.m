//
//  SimpleOperation.m
//  7.12.Running Tasks Asynchronously with Operations
//
//  Created by artwalk on 8/14/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "SimpleOperation.h"

@interface SimpleOperation ()

@property (nonatomic, strong) NSObject *givenObject;
@property (nonatomic, unsafe_unretained, getter = isFinished) BOOL finished;
@property (nonatomic, unsafe_unretained, getter = isExecuting) BOOL executing;

@end

@implementation SimpleOperation

- (instancetype) init {
    return ([self initWithObject:@123]);
}

- (instancetype) initWithObject:(NSObject *)paramObject {
    self = [super init];
    if (self != nil) {
        _givenObject = paramObject;
    }
    return self;
}

- (void) main {
    @try {
        @autoreleasepool {
            BOOL taskIsFinished = NO;
            
            while (taskIsFinished == NO && [self isCancelled] == NO) {
                
                NSLog(@"%s", __FUNCTION__);
                NSLog(@"givenObject: %@", _givenObject);
                NSLog(@"MainThread --> %@", [NSThread mainThread]);
                NSLog(@"CurrThread --> %@", [NSThread currentThread]);
                
                for (int i = 0; i < 100; ++i) {
                    NSLog(@"%@ ---> %d", _givenObject, i);
                }
                
                
                taskIsFinished = YES;
            }
            
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            _finished = YES;
            _executing = NO;
            [self didChangeValueForKey:@"isFinished"];
            [self didChangeValueForKey:@"isexecuting"];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@", exception);
    }
    @finally {
        ;
    }
}

- (BOOL) isConcurrent {
    return YES;
}

@end

//
//  CountingOperation.h
//  7.11.Running Tasks Synchronously with Operations
//
//  Created by artwalk on 8/12/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface CountingOperation : NSOperation

- (instancetype)initWithStartingCount:(NSUInteger)paramStartingCount endingCount:(NSUInteger)paramEndingCount;

@end


//
//  MySingleton.m
//  7.7.PerformingTasksAfterADelayWithGCD
//
//  Created by artwalk on 8/11/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "MySingleton.h"

@implementation MySingleton

- (instancetype)sharedInstance {
    static MySingleton *SharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SharedInstance = [MySingleton new];
    });
    
    return SharedInstance;
}

@end

//
//  BNRLine.h
//  TouchTracker
//
//  Created by artwalk on 6/3/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRLine : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;


@property (nonatomic, strong) NSMutableArray *containingArray;

@end

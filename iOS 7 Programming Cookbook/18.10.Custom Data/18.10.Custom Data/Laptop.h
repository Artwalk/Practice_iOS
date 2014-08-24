//
//  Laptop.h
//  18.10.Custom Data
//
//  Created by artwalk on 8/24/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Laptop : NSManagedObject

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) NSString * model;

@end

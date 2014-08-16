//
//  Person.h
//  CookBook_1
//
//  Created by artwalk on 6/28/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kFirstNameKey;
extern NSString *const kLastNameKey;

@interface Person : NSObject

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

@property (nonatomic, assign) CGFloat currentHeight;

+ (CGFloat) maximumHeightIncentimeters;
+ (CGFloat) minimumHeightInCentimeters;

- (id) objectForKeyedSubscript:(id<NSCopying>)paramKey;
- (void) setObject:(id)paramObject forKeyedSubscript:(id<NSCopying>)paramKey;

//@property (nonatomic, weak) Person *fooPerson;

@end

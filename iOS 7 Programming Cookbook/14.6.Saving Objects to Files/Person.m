//
//  Person.m
//  14.6.Saving Objects to Files
//
//  Created by artwalk on 8/18/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "Person.h"

NSString *const kFirstNameKey = @"FirstNameKey";
NSString *const kLastNameKey = @"LastNameKey";

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstName forKey:kFirstNameKey];
    [aCoder encodeObject:self.lastName forKey:kLastNameKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self != nil) {
        _firstName = [aDecoder decodeObjectForKey:kFirstNameKey];
        _lastName = [aDecoder decodeObjectForKey:kLastNameKey];
    }
    
    return self;
}

@end

//
//  Person.m
//  CookBook_1
//
//  Created by artwalk on 6/28/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "Person.h"

NSString *const kFirstNameKey = @"firstName";
NSString *const kLastNameKey = @"lastName";

@implementation Person

- (id) objectForKeyedSubscript:(id<NSCopying>)paramKey {
    NSObject<NSCopying> *keyAsObject = (NSObject<NSCopying> *)paramKey;
    
    if ([keyAsObject isKindOfClass:[NSString class]]) {
        NSString *keyAsString = (NSString *)keyAsObject;
        if ([keyAsString isEqualToString:kFirstNameKey] || [keyAsString isEqualToString:kLastNameKey]) {
            return [self valueForKey:keyAsString];
        }
    }
    
    return nil;
}

- (void) setObject:(id)paramObject forKeyedSubscript:(id<NSCopying>)paramKey {
    NSObject<NSCopying> *keyAsObject = (NSObject<NSCopying> *)paramKey;
    
    if ([keyAsObject isKindOfClass:[NSString class]]) {
        NSString *keyAsString = (NSString *)keyAsObject;
        if ([keyAsString isEqualToString:kFirstNameKey] || [keyAsString isEqualToString:kLastNameKey]) {
            [self setValue:paramObject forKey:keyAsString];
        }
    }
}

+ (CGFloat) maximumHeightIncentimeters {
    return 250.0f;
}

+ (CGFloat) minimumHeightInCentimeters {
    return 40.0f;
}

@end

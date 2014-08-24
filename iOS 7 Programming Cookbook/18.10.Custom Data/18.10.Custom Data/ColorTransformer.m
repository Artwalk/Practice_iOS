//
//  ColorTransformer.m
//  18.10.Custom Data
//
//  Created by artwalk on 8/24/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "ColorTransformer.h"

@implementation ColorTransformer


+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id) transformedValue:(id)value {
    UIColor *color = (UIColor *)value;
    CGFloat r, g, b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    
    CGFloat components[4] = {r, g, b, a};
    NSData *dataFromColors = [[NSData alloc] initWithBytes:components length:sizeof(components)];
    
    return dataFromColors;
}

- (id)reverseTransformedValue:(id)value {
    NSData *data = (NSData *)value;
    CGFloat components[4] = {0.0f, 0.0f, 0.0f, 0.0f};
    [data getBytes:components length:sizeof(components)];
    
    UIColor *color = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
    
    return color;
}

@end

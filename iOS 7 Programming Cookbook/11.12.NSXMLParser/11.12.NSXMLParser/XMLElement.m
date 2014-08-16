//
//  XMLElement.m
//  11.12.NSXMLParser
//
//  Created by artwalk on 8/16/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "XMLElement.h"

@interface XMLElement ()


@end

@implementation XMLElement

- (NSMutableArray *)subElements {
    if (_subElements == nil) {
        _subElements = [[NSMutableArray alloc] init];
    }
    
    return _subElements;
}

@end

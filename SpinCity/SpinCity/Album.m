//
//  Album.m
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import "Album.h"

@implementation Album

-(id)initWithTitle:(NSString *)title artist:(NSString *)artist summary:(NSString *)summary price:(float)price locationInStore:(NSString *)locationInStore {
    self = [super self];
    
    if (self) {
        _title = title;
        _artist = artist;
        _summary = summary;
        _price = price;
        _locationInStore = locationInStore;
        
        return self;
    }
    
    return nil;
}

@end

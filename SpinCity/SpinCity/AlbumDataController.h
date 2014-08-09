//
//  AlbumDataController.h
//  SpinCity
//
//  Created by artwalk on 5/21/14.
//  Copyright (c) 2014 artwalk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Album;

@interface AlbumDataController : NSObject

- (NSUInteger)albumCount;

- (Album *)albumAtIndex:(NSUInteger)index;

- (void)addAlbumWithTitle:(NSString*)title artist:(NSString *)artist summary:(NSString *)summary price:(float)price locationInStore:(NSString *)locationInStore ;

@end
